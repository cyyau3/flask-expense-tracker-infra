from flask import Flask, render_template, request, redirect
from models import db, Expense
from datetime import datetime
from dotenv import load_dotenv
from sqlalchemy import inspect
import os
import logging
import boto3
import json
from botocore.exceptions import ClientError

logging.basicConfig(
    filename='app.log',
    level=logging.INFO,
    format='%(asctime)s %(levelname)s: %(message)s [in %(pathname)s:%(lineno)d]'
)

load_dotenv()

app = Flask(__name__)

def get_db_uri_from_secret():
    try:
        secret_name = os.environ["AWS_SECRET_NAME"]
        region_name = os.environ["AWS_REGION"] 
    except KeyError as e:
        raise RuntimeError(f"Missing required environment variable: {e}")

    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name=region_name
    )

    try:
        get_secret_value_response = client.get_secret_value(SecretId=secret_name)
        logging.info("Successfully fetched DB credentials from Secrets Manager.")
    except ClientError as e:
        logging.error(f"Unable to retrieve secret: {e}")
        raise e

    secret = json.loads(get_secret_value_response['SecretString'])
    db_uri = f"postgresql://{secret['username']}:{secret['password']}@{secret['host']}:{secret['port']}/{secret['dbname']}"
    return db_uri

app.config['SQLALCHEMY_DATABASE_URI'] = get_db_uri_from_secret()
db.init_app(app)

with app.app_context():
    inspector = inspect(db.engine)
    if not inspector.has_table("expenses"):
        print("Creating tables...")
        db.create_all()
    else:
        print("Database tables already exist. Skipping initialization.")

@app.route('/')
def index():
    category = request.args.get('category')
    payment_method = request.args.get('payment_method')
    who = request.args.get('who')
    start_date = request.args.get('start_date')
    end_date = request.args.get('end_date')

    query = Expense.query
    if category:
        query = query.filter_by(category=category)
    if payment_method:
        query = query.filter_by(payment_method=payment_method)
    if who:
        query = query.filter_by(who=who)
    if start_date:
        query = query.filter(Expense.date >= datetime.strptime(start_date, '%Y-%m-%d').date())
    if end_date:
        query = query.filter(Expense.date <= datetime.strptime(end_date, '%Y-%m-%d').date())

    expenses = query.order_by(Expense.date.desc()).all()
    total_amount = sum(float(e.amount) for e in expenses)
    return render_template('list.html', expenses=expenses, selected_filters={
        'category': category,
        'payment_method': payment_method,
        'who': who,
        'start_date': start_date,
        'end_date': end_date
    }, total_amount=total_amount)


@app.route('/add', methods=['GET', 'POST'])
def add_expense():
    if request.method == 'POST':
        new_expense = Expense(
            date=datetime.strptime(request.form['date'], '%Y-%m-%d').date(),
            category=request.form['category'],
            store=request.form['store'],
            amount=request.form['amount'],
            description=request.form['description'],
            payment_method=request.form['payment_method'],
            who=request.form['who']
        )
        try:
            db.session.add(new_expense)
            db.session.commit()
            logging.info(f"Added new expense: {request.form}")
        except Exception as e:
            db.session.rollback()
            logging.error(f"Error adding expense: {e}")
            return "An error occurred while adding the expense.", 500
        return redirect('/')
    return render_template('add.html')


@app.route('/edit/<int:id>', methods=['GET', 'POST'])
def update_expenses(id):
    expense = Expense.query.get_or_404(id)
    if request.method == 'POST':
        expense.date = datetime.strptime(request.form['date'], '%Y-%m-%d').date()
        expense.category = request.form['category']
        expense.store = request.form['store']
        expense.amount = request.form['amount']
        expense.description = request.form['description']
        expense.payment_method = request.form['payment_method']
        expense.who = request.form['who']
        try:
            db.session.commit()
            logging.info(f"Updated expense ID {id} with data: {request.form}")
        except Exception as e:
            db.session.rollback()
            logging.error(f"Error updating expense ID {id}: {e}")
            return "An error occurred while updating the expense.", 500
        return redirect('/')
    return render_template('edit.html', expense=expense)


@app.route('/delete/<int:id>')
def delete_expense(id):
    expense = Expense.query.get_or_404(id)
    try:
        db.session.delete(expense)
        db.session.commit()
        logging.info(f"Deleted expense ID {id}")
    except Exception as e:
        db.session.rollback()
        logging.error(f"Error deleting expense ID {id}: {e}")
        return "An error occurred while deleting the expense.", 500
    return redirect('/')

@app.route('/health')
def health_check():
    return "OK", 200

# if __name__ == "__main__":
#     with app.app_context():
#         db.create_all()
#     app.run(host='0.0.0.0', port=5000, debug=True)
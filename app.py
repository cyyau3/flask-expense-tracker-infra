from flask import Flask, render_template, request, redirect
from models import db, Expense
from datetime import datetime

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///expenses.db'
db.init_app(app)

@app.before_request
def create_tables():
    db.create_all()

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
        db.session.add(new_expense)
        db.session.commit()
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
        db.session.commit()
        return redirect('/')
    return render_template('edit.html', expense=expense)

@app.route('/delete/<int:id>')
def delete_expense(id):
    expense = Expense.query.get_or_404(id)
    db.session.delete(expense)
    db.session.commit()
    return redirect('/')
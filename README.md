# Expense Tracker App – Production Infrastructure with Terraform & ECS

This repo builds on the [Phase 1 deployment](https://github.com/cyyau3/flask-expense-tracker), which launched a Flask-based expense tracker on AWS using EC2 and RDS via the AWS Console.

In **Phase 2**, the project was restructured into a **modular, production-ready infrastructure** using **Terraform**, **Docker**, and **AWS ECS (Fargate)** — highlighting cloud-native design, scalability, and Infrastructure as Code best practices.

---

## Key Features

- **Flask + PostgreSQL** – Python web backend with persistent storage
- **Docker + Amazon ECR** – Containerized app with remote image hosting
- **Terraform (modular)** – Infrastructure as Code used to automate provisioning of networking infrastructure (VPC, subnets, NAT Gateway, security groups)
- **ECS Fargate + ALB, ECR, Route 53, ACM** – Application deployment, container registry, custom domain, and SSL certificate were configured manually via AWS Console for learning and demonstration purposes
- **VPC + NAT Gateway** – Isolated subnets and controlled internet routing for secure architecture
- **IAM + Secrets Manager** – Secure credential management and execution role handling
- **CloudWatch** – Log and metric streaming for monitoring and observability

---

## What’s New in Phase 2

- Rebuilt infrastructure with **modular Terraform** (network, compute, DB)
- Containerized the Flask app and stored it in **Amazon ECR**
- Deployed the app using **ECS Fargate** for managed scalability
- Configured **Application Load Balancer (ALB)** for public access
- Pulled secrets securely via **AWS Secrets Manager**
- Enforced least-privilege access using **IAM roles**
- Streamlined networking with reusable **VPC module** and **NAT Gateway**

---

## Folder Structure
```
.
├── static/
├── templates/
├── terraform/
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── terraform.tfvars.example
│   ├── .terraform.lock.hcl
│   └── modules/
│       └── vpc/
│           ├── data.tf
│           ├── igw.tf
│           ├── nat.tf
│           ├── outputs.tf
│           ├── subnets.tf
│           ├── variables.tf
│           └── vpc.tf
├── .dockerignore
├── .gitignore
├── .env
├── app.py
├── Dockerfile
├── models.py
├── README.md
└── requirements.txt
```

---

## Cloud Architecture Diagram

![Cloud Project Diagram - P1-Phrase2-300ppi](https://github.com/user-attachments/assets/f1767dbe-37df-41ab-aae7-5134d27e2c9a)

---

## Demo Video

[Watch the demo video](https://youtu.be/WJZAnc1_ZDY)

---

## How to Deploy

> **Note:** In this phase, the networking infrastructure (VPC, subnets, NAT Gateway, security groups) is provisioned using Terraform. The ECS Fargate service, ECR repository, Application Load Balancer, Route 53, and ACM certificate are configured manually via the AWS Console for learning and demonstration purposes.

1. **Clone the repository**
```bash
git clone https://github.com/cyyau3/flask-expense-tracker.git
cd flask-expense-tracker
```

2. **Provision networking infrastructure with Terraform**
   - Create a `terraform.tfvars` file in the `terraform/` directory (based on the example):
     ```hcl
     aws_region     = "your-aws-region"
     key_name       = "your-key-name"
     db_password    = "your-db-password"
     your_ip_cidr   = "YOUR_PUBLIC_IP/32"
     ```
> Use `terraform.tfvars.example` to create your own `terraform.tfvars` file with real values.
> Do not commit the real file.

   - Deploy:
     ```bash
     cd terraform/
     terraform init
     terraform apply
     ```

3. **Build and push Docker image to ECR**
   - Create an ECR repository via the AWS Console (if not already done)
   - Build and push your Docker image:
     ```bash
     docker build -t flask-expense-tracker .
     docker tag flask-expense-tracker:latest <your_ecr_repo_uri>
     docker push <your_ecr_repo_uri>
     ```

4. **Manually configure ECS Fargate, ALB, and Route 53 using AWS Console**
   - Set up an ECS Fargate service, referencing your ECR image and the networking resources created by Terraform
   - Create or configure an Application Load Balancer for public access
   - Register your service with Route 53 and enable HTTPS with ACM

5. **Access the App**
   - Once the ECS service is running and the ALB/Route 53 configuration is complete, your app will be accessible via your custom domain.

## Security Practices
- No credentials committed to source code
- Secrets pulled securely via AWS Secrets Manager
- RDS hosted in private subnet
- EC2/ECS access controlled via IAM roles and Security Groups

## Future Improvements
- CI/CD Pipeline with Github Actions
- OCR Receipt Upload using AWS Textract
- Dashboard & Analytics for expense trends

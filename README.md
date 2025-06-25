# Expense Tracker App – Production Infrastructure with Terraform & ECS

This project showcases a full-stack cloud deployment of a real-world Flask web application using a production-grade AWS infrastructure.

As part of my transition into a cloud engineering career, I built this project to deepen my hands-on experience with AWS services, DevOps workflows, and Infrastructure as Code. What started as a basic app hosted on EC2 [See phase 1 here](https://github.com/cyyau3/flask-expense-tracker) evolved into a robust, scalable system deployed on ECS Fargate, fully containerized and automated via CI/CD. Each phase of the project was designed to simulate real-world practices, helping me build confidence in deploying secure, maintainable, and production-ready applications in the cloud.

---

## Table of Contents
- [Key Features & Security Practices](#key-features--security-practices)
- [Phase 2 – Terraform & ECS](#whats-new-in-phase-2)
- [Phase 3 – CI/CD & Automation](#whats-new-in-phase-3--cicd--production-automation)
- [Project Folder Structure](#project-folder-structure)
- [Deployment Instructions](#deployment-instructions)
- [Real-World Implementation Summary](#real-world-implementation-summary)
- [Architecture Diagram](#cloud-architecture-diagram)
- [Demo Video](#demo-video)

---

## Key Features & Security Practices

- **Flask + PostgreSQL** – Python web backend with persistent storage  
- **Docker + Amazon ECR** – Containerized app with remote image hosting  
- **Terraform (modular)** – Infrastructure as Code used to automate provisioning of networking infrastructure (VPC, subnets, NAT Gateway, security groups)  
- **ECS Fargate + ALB, ECR, Route 53, ACM** – Application deployment, container registry, custom domain, and SSL certificate were configured manually via AWS Console for learning and demonstration purposes  
- **VPC + NAT Gateway** – Isolated subnets and controlled internet routing for secure architecture  
- **IAM + Secrets Manager** – Secure credential management and execution role handling  
- **CloudWatch** – Log and metric streaming for monitoring and observability  

**Security Practices**  
- No credentials committed to source code  
- Secrets pulled securely via AWS Secrets Manager  
- RDS hosted in private subnet  
- EC2/ECS access controlled via IAM roles and Security Groups  

---

## Phase 2 – Terraform Infrastructure & Container Deployment

This phase re-engineers the application infrastructure using modern Infrastructure as Code practices and introduces containerization for scalable and consistent deployments.

- Rebuilt infrastructure with **modular Terraform** (network, compute, DB)  
- Containerized the Flask app and stored it in **Amazon ECR**  
- Deployed the app using **ECS Fargate** for managed scalability  
- Configured **Application Load Balancer (ALB)** for public access  
- Pulled secrets securely via **AWS Secrets Manager**  
- Enforced least-privilege access using **IAM roles**  
- Streamlined networking with reusable **VPC module** and **NAT Gateway**  

---

## Phase 3 – CI/CD & Production Automation

This final phase transforms the infrastructure into a **production-ready system with CI/CD automation**, enhancing maintainability, security, and scalability.

### CI/CD with GitHub Actions
- Implemented a **CI/CD pipeline** that automatically builds, tags, and pushes Docker images to **Amazon ECR** and deploys updates to **ECS Fargate** upon GitHub push.  
- Ensured all secrets and environment variables are managed securely via **GitHub Secrets** and **AWS Secrets Manager**.  
- Enabled efficient, repeatable deployments without requiring manual image builds or ECS console interaction.  

### ECS Service Auto Scaling
- Configured ECS **auto scaling** to dynamically adjust the number of tasks based on CPU usage thresholds.  
- Used Terraform to manage target tracking scaling policies and CloudWatch alarms.  

### Enhanced Secret Management
- Pulled database credentials securely via **Secrets Manager** with fine-grained IAM task role permissions.  
- Prevented hardcoding sensitive information across infrastructure or application layers.  

### Custom Domain with HTTPS via Route 53
- Integrated **ACM (AWS Certificate Manager)** to provision HTTPS for the application.  
- Used **Route 53** to associate a custom domain (managed via Namecheap) with the ALB endpoint.  
- Resolved DNS propagation issues and validated secure HTTPS access end-to-end.
- To ensure proper routing, use the ALB DNS name with a `dualstack.` prefix (e.g., `dualstack.my-alb-name.region.elb.amazonaws.com`).

### Production-Grade Best Practices
- Verified ECS tasks operate within **private subnets**, with internet access routed through a **NAT Gateway**.  
- Segregated security groups and IAM roles for least-privilege access.  
- Ensured repeatable, version-controlled deployment process using **Terraform modules** and GitHub workflows.  

This phase represents a full-stack DevOps implementation that mirrors how real-world cloud-native applications are deployed and maintained in production environments.

---

## Project Folder Structure
```
.
├── app.py                        # Main Flask application
├── models.py                     # Database models
├── requirements.txt              # Python dependencies
├── Dockerfile                    # Docker image build file
├── .github/
│   └── workflows/
│       └── deploy.yml            # GitHub Actions CI/CD workflow
├── static/
│   └── style.css                 # App styling
├── templates/
│   ├── base.html                 # HTML templates for UI
│   ├── add.html
│   ├── edit.html
│   └── list.html                 
├── terraform/
│   ├── main.tf                   # Root module entry
│   ├── provider.tf               # AWS provider config
│   ├── variables.tf              # Input variables
│   ├── terraform.tfvars.example  # Actual values for variables
│   ├── outputs.tf                # Output values for referencing
│   └── modules/                  # Modular infrastructure components
│       ├── alb/                  # Application Load Balancer
│       ├── cloudwatch/           # Logging setup
│       ├── ecr/                  # Container registry
│       ├── ecs/                  # ECS service and task definition
│       ├── iam/                  # IAM roles and policies
│       ├── networking/           # VPC, subnets, NAT, etc.
│       ├── rds/                  # PostgreSQL RDS instance
│       ├── route53/              # Custom domain via Route 53
│       └── secretsmanager/       # AWS Secrets Manager integration
└── README.md                     # Project documentation
```

---

## Deployment Instructions

### 1. Infrastructure Provisioning with Terraform
All AWS infrastructure components are deployed via Terraform, including VPC, subnets, NAT Gateway, security groups, ECS Fargate service, Application Load Balancer, ECR, RDS, ACM, Route 53, IAM, and Secrets Manager.

1. **Clone the repository**  
```bash
git clone https://github.com/cyyau3/flask-expense-tracker-infra.git
cd flask-expense-tracker/terraform
```

2. **Set up your Terraform variables**  
   Create a `terraform.tfvars` file using the provided `terraform.tfvars.example` as a reference. Include values such as:
```hcl
aws_region         = "us-east-2"
project_name       = "flask-expense-tracker-infra"
db_username        = "postgresAdmin"
db_password        = "your-password"
db_instance_class  = "db.t3.micro"
db_name            = "postgres"
domain_name        = "your.domain.com"
route53_zone_id    = "ZXXXXXXXXXXXXX"
secret_string_json = <<EOF
{
  "host": "your-db-endpoint",
  "port": "5432",
  "username": "postgresAdmin",
  "password": "your-password",
  "dbname": "postgres"
}
EOF
```

3. **Initialize and apply Terraform**  
```bash
terraform init
terraform apply
```
> Note: For production-grade teams, consider using a remote backend (e.g., S3 with DynamoDB) for Terraform state management.

### 2. CI/CD Deployment via GitHub Actions
- GitHub Actions is configured to automatically build, tag, and push Docker images to ECR and deploy to ECS Fargate on every push to the `main` branch.
- Ensure the following GitHub Secrets are configured in your repository:
```
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION
ECR_REPOSITORY
```
- CI/CD pipeline lives in `.github/workflows/deploy.yml`

### 3. Post-Deployment
- After Terraform and GitHub Actions complete successfully, your app is accessible via the custom domain you configured.
- HTTPS is enabled via ACM certificate.
- ECS Auto Scaling is configured for high availability.

---

## Real-World Implementation Summary

This project delivers an end-to-end cloud-native solution for a Flask-based expense tracker application, leveraging Infrastructure as Code with Terraform, containerization with Docker, and managed container orchestration using AWS ECS Fargate. The infrastructure is designed with security best practices including private subnets, IAM roles, and Secrets Manager integration. The addition of CI/CD pipelines ensures automated, reliable deployments, while custom domain and HTTPS support provide a production-grade user experience. This comprehensive approach demonstrates modern DevOps principles applied to real-world application deployment and management.

---

## Cloud Architecture Diagram

![Cloud Project Diagram - P1-Phase2-300ppi](https://github.com/user-attachments/assets/f1767dbe-37df-41ab-aae7-5134d27e2c9a)

---

## Demo Video

[Watch the demo video](https://youtu.be/WJZAnc1_ZDY)
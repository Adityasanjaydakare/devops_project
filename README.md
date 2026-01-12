# 🔐 DevSecOps CI/CD Automation Project

**Automated, Secure, and Scalable CI/CD Pipeline using Jenkins, Docker, Trivy, Terraform, Ansible, Prometheus & Grafana**

This project implements a modern **DevSecOps pipeline** that integrates security, infrastructure automation, monitoring, and notifications into every stage of application delivery.

---

## 🎯 Objective

To design and implement a fully automated pipeline that:

- Builds and packages an application
- Performs security scanning at multiple levels
- Provisions cloud infrastructure automatically
- Configures monitoring and observability
- Notifies stakeholders on pipeline outcomes

---

## 🔄 End-to-End Workflow

Code Push → Jenkins → Dependency Install → Security Scan → Docker Build →
Image Scan → Terraform Infra → Ansible Monitoring → Email Notification

yaml
Copy code

---

## 🗂️ Repository Layout

devsecops-project/
│
├── app/ → Application source code (Node.js)
├── terraform/ → AWS EC2 provisioning (Terraform)
├── ansible/ → Monitoring automation (Prometheus + Grafana)
│ ├── inventory
│ └── playbook.yml
├── Dockerfile → Container image definition
├── Jenkinsfile → CI/CD pipeline script
└── README.md → Documentation

yaml
Copy code

---

## ⚙️ Tools & Technologies

**CI/CD:** Jenkins  
**Containerization:** Docker  
**Security:** Trivy  
**IaC:** Terraform  
**Configuration Management:** Ansible  
**Monitoring:** Prometheus, Grafana  
**Cloud Platform:** AWS (EC2)  
**Notifications:** Jenkins Email Extension  

---

## 🧪 Pipeline Stages Explained

### 1️⃣ Workspace Cleanup
Ensures a fresh build environment.
```groovy
cleanWs()
2️⃣ Source Code Checkout
Fetches the latest code from GitHub.

groovy
Copy code
checkout scm
3️⃣ Dependency Installation
Installs required Node.js packages.

bash
Copy code
cd app
node -v
npm -v
npm install
4️⃣ Security Scan – Source Code
Scans application files for vulnerabilities.

bash
Copy code
trivy fs app
5️⃣ Container Build
Creates a Docker image of the application.

bash
Copy code
docker build -t devsecops-app:latest .
6️⃣ Security Scan – Container Image
Checks Docker image for vulnerabilities.

bash
Copy code
trivy image devsecops-app:latest
7️⃣ Cloud Infrastructure Automation
Provisions AWS EC2 using Terraform.

bash
Copy code
cd terraform
terraform init
terraform apply -auto-approve
🔐 AWS credentials are securely injected via Jenkins credentials:

aws-access-key

aws-secret-key

8️⃣ Monitoring Deployment
Configures Prometheus & Grafana using Ansible.

bash
Copy code
cd ansible
ansible-playbook -i inventory playbook.yml
📧 Build Notifications
The pipeline automatically sends emails:

✅ Success Email
Job Name

Build Number

Build URL

Status confirmation

❌ Failure Email
Job Name

Build Number

Error tracking link

🌍 Environment Configuration
groovy
Copy code
IMAGE_NAME = "devsecops-app"
DOCKER_TAG = "latest"
AWS_DEFAULT_REGION = "ap-south-1"
🧩 Prerequisites
Before running the pipeline, ensure:

Jenkins with required plugins installed

Docker installed on Jenkins agent

Node.js & npm available

Terraform installed

Ansible installed

Trivy installed

AWS account configured

Jenkins credentials created:

aws-access-key

aws-secret-key

Jenkins Email Extension configured

🚀 How to Run
Clone this repository.

Add the pipeline script as Jenkinsfile.

Configure AWS credentials in Jenkins.

Create a Jenkins Pipeline Job linked to this repo.

Trigger the build manually or using a webhook.

🏆 Key Highlights
✔ End-to-end DevSecOps automation
✔ Security scanning at code & image level
✔ Infrastructure provisioning via Terraform
✔ Automated monitoring with Ansible
✔ Real-time email notifications
✔ Production-style CI/CD architecture

👨‍💻 Author
Aditya Sanjay Dakare
DevOps Engineer | AWS | Jenkins | Docker | Terraform | Ansible | DevSecOps

⭐ Support
If you found this project useful:
👉 Star the repository
👉 Fork it to customize
👉 Open issues for improvements

Building secure, automated pipelines — one commit at a time. 🚀

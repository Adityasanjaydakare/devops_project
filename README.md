# 🔐 DevSecOps CI/CD Automation Project

**End-to-End Secure CI/CD Pipeline using Jenkins, Docker, Trivy, Terraform, Ansible, Prometheus & Grafana**

This project demonstrates a complete **DevSecOps workflow** that automates application build, security scanning, infrastructure provisioning, monitoring setup, and email notifications.

---

## 🎯 Purpose of This Project

To implement a production-style pipeline that:

- Automates builds and deployments
- Integrates security at every stage
- Provisions cloud infrastructure automatically
- Enables monitoring and observability
- Sends real-time build notifications

---

## 🔄 Pipeline Flow

Code Push → Jenkins → Dependency Install → Trivy Scan →
Docker Build → Trivy Image Scan → Terraform Infra →
Ansible Monitoring → Email Notification

yaml
Copy code

---

## 🗂 Repository Structure

devsecops-project/
│
├── app/ # Node.js application source code
├── terraform/ # AWS EC2 provisioning using Terraform
├── ansible/ # Monitoring automation (Prometheus + Grafana)
│ ├── inventory
│ └── playbook.yml
├── Dockerfile # Application container image
├── Jenkinsfile # Jenkins pipeline definition
└── README.md # Project documentation

yaml
Copy code

---

## ⚙️ Tools & Technologies

- **CI/CD:** Jenkins  
- **Containerization:** Docker  
- **Security Scanning:** Trivy  
- **Infrastructure as Code:** Terraform  
- **Configuration Management:** Ansible  
- **Monitoring:** Prometheus, Grafana  
- **Cloud:** AWS (EC2)  
- **Notifications:** Jenkins Email Extension  

---

## 🧪 Pipeline Stages

1. **Clean Workspace** – Removes previous artifacts  
2. **Checkout Code** – Pulls latest GitHub code  
3. **Install Dependencies** – Runs `npm install`  
4. **Trivy File Scan** – Scans application files  
5. **Docker Build** – Builds container image  
6. **Trivy Image Scan** – Scans Docker image  
7. **Terraform Provisioning** – Creates AWS EC2  
8. **Ansible Monitoring Setup** – Installs Prometheus & Grafana  
9. **Email Notifications** – Sends success/failure emails  

---

## 🚀 How To Do This Project (Step-by-Step)

Follow these steps to implement the project from scratch.

---

### 🔧 Step 1: Create Project Structure

```bash
mkdir devsecops-project
cd devsecops-project
mkdir app terraform ansible
touch Dockerfile Jenkinsfile README.md
🔧 Step 2: Add a Sample Node.js Application
Inside the app/ folder:

bash
Copy code
cd app
npm init -y
npm install express
Create index.js:

javascript
Copy code
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('DevSecOps Pipeline Running Successfully!');
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});
🔧 Step 3: Create Dockerfile
In the project root:

dockerfile
Copy code
FROM node:18
WORKDIR /app
COPY app/package*.json ./
RUN npm install
COPY app .
EXPOSE 3000
CMD ["node", "index.js"]
🔧 Step 4: Install Required Tools on Jenkins Server
bash
Copy code
sudo apt update
sudo apt install -y docker.io ansible terraform
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh
Add Jenkins user to Docker group:

bash
Copy code
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
🔧 Step 5: Configure AWS Credentials in Jenkins
Go to Jenkins → Manage Jenkins → Credentials

Add:

aws-access-key

aws-secret-key

🔧 Step 6: Write Terraform Code (EC2 Setup)
Inside terraform/main.tf:

hcl
Copy code
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "devsecops_ec2" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"

  tags = {
    Name = "DevSecOps-EC2"
  }
}
🔧 Step 7: Create Ansible Monitoring Playbook
Inside ansible/playbook.yml:

yaml
Copy code
- name: Install Prometheus and Grafana
  hosts: all
  become: yes

  tasks:
    - name: Install Docker
      apt:
        name: docker.io
        state: present
        update_cache: yes

    - name: Start Docker
      service:
        name: docker
        state: started
        enabled: true

    - name: Run Prometheus
      shell: docker run -d -p 9090:9090 prom/prometheus

    - name: Run Grafana
      shell: docker run -d -p 3000:3000 grafana/grafana
🔧 Step 8: Add Jenkins Pipeline (Jenkinsfile)
Add your provided pipeline script into Jenkinsfile:

groovy
Copy code
pipeline {
    agent any

    environment {
        IMAGE_NAME = "devsecops-app"
        DOCKER_TAG = "latest"
        AWS_DEFAULT_REGION = "ap-south-1"
    }

    stages {
        stage('Clean Workspace') {
            steps { cleanWs() }
        }

        stage('Checkout Code') {
            steps { checkout scm }
        }

        stage('Install Dependencies') {
            steps {
                dir('app') {
                    sh '''
                        node -v
                        npm -v
                        npm install
                    '''
                }
            }
        }

        stage('Trivy File Scan') {
            steps { sh 'trivy fs app' }
        }

        stage('Docker Build') {
            steps { sh 'docker build -t ${IMAGE_NAME}:${DOCKER_TAG} .' }
        }

        stage('Trivy Image Scan') {
            steps { sh 'trivy image ${IMAGE_NAME}:${DOCKER_TAG}' }
        }

        stage('Terraform Infra Provision (EC2)') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    dir('terraform') {
                        sh '''
                            terraform init
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }

        stage('Monitoring Setup (Prometheus + Grafana)') {
            steps {
                sh '''
                    cd ansible
                    ansible-playbook -i inventory playbook.yml
                '''
            }
        }
    }
}
🔧 Step 9: Create Jenkins Pipeline Job
Open Jenkins Dashboard

Click New Item → Pipeline

Select Pipeline script from SCM

Add GitHub repository URL

Save and click Build Now

📧 Email Notifications
The pipeline automatically sends:

✅ Success Email when all stages pass

❌ Failure Email if any stage fails

Includes:

Job name

Build number

Build URL

🏆 Key Highlights
✔ DevSecOps best practices
✔ Security scanning at code & image level
✔ Infrastructure automation with Terraform
✔ Monitoring with Prometheus & Grafana
✔ Email alerts for pipeline status
✔ Real-world CI/CD architecture

👨‍💻 Author
Aditya Sanjay Dakare
DevOps Engineer | AWS | Jenkins | Docker | Terraform | Ansible | DevSecOps

⭐ Support
If this project helped you:

⭐ Star the repository
🍴 Fork to customize
🐛 Raise issues for improvements

Automating securely, deploying confidently 🚀

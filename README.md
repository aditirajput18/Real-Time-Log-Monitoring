# 🚀 Real-Time Log Monitoring Dashboard

A real-time log monitoring system built using **AWS**, **Terraform**, and **Python**.  
It streams simulated application logs, processes them serverlessly, and visualizes them in **OpenSearch Dashboards (Kibana)**.

---

## 🧰 Tech Stack

- **AWS Lambda** – Serverless log processor  
- **Amazon Kinesis** – Real-time log streaming  
- **Amazon OpenSearch Service** – Log storage and visualization  
- **Terraform** – Infrastructure as Code (IaC)  
- **Python** – Log simulation and Lambda code  
- **CloudWatch** – Lambda monitoring  

---

## ✨ Key Features

- Real-time streaming and log ingestion  
- Serverless processing (no manual scaling)  
- Fully automated setup using Terraform  
- Live visualization in OpenSearch Dashboards  
- Simple Python script to simulate logs  

---

## ⚙️ How to Use

### 1️⃣ Clone the Repository
git clone https://github.com/<your-username>/

real-time-log-monitoring-dashboard.git  

cd real-time-log-monitoring-dashboard

### 2️⃣ Configure AWS CLI


Make sure your AWS credentials are configured:

aws configure

### 3️⃣ Build and Package Lambda

Navigate to the Lambda directory and build the deployment package:

cd lambda

bash build_layer.sh

### 4️⃣ Deploy Infrastructure using Terraform

Initialize and apply the Terraform configuration to 
create AWS resources:

cd ../terraform

terraform init

terraform apply -auto-approve


Once deployment is complete, note down the OpenSearch Dashboard URL from the Terraform output.

### 5️⃣ Start Sending Logs

Run the log simulator to push logs into Kinesis:

cd ../log-simulator

python3 log_producer.py

### 6️⃣ View Logs in OpenSearch Dashboard (Kibana)

Open the OpenSearch Dashboard URL output from Terraform.

Create a new index pattern:

app-logs*


Explore and visualize logs in real time.

### 🧹 Cleanup

To remove all AWS resources and prevent charges:

cd terraform

terraform destroy -auto-approve

### 🧠 Learnings

Building real-time data pipelines using AWS managed services.

Handling event-driven serverless architectures with Lambda and Kinesis.

Automating deployments using Terraform.

Setting up observability dashboards using OpenSearch (Kibana).
``` bash

🚀 Real-Time Log Monitoring Dashboard

A real-time log monitoring system built using AWS, Terraform, and Python.
It streams simulated application logs, processes them serverlessly, and visualizes them in OpenSearch Dashboards (Kibana).

🧰 Tech Stack

AWS Lambda – Serverless log processor

Amazon Kinesis – Real-time log streaming

Amazon OpenSearch Service – Log storage and visualization

Terraform – Infrastructure as Code (IaC)

Python – Log simulation and Lambda code

CloudWatch – Lambda monitoring

✨ Key Features

Real-time streaming and log ingestion

Serverless processing (no manual scaling)

Fully automated setup using Terraform

Live visualization in OpenSearch Dashboards

Simple Python script to simulate logs

⚙️ How to Use
1️⃣ Clone the Repository
git clone https://github.com/<your-username>/real-time-log-monitoring-dashboard.git
cd real-time-log-monitoring-dashboard

2️⃣ Configure AWS CLI

Make sure your AWS credentials are configured:

aws configure

3️⃣ Build and Package Lambda
cd lambda
bash build_layer.sh

4️⃣ Deploy Infrastructure
cd ../terraform
terraform init
terraform apply -auto-approve

5️⃣ Start Sending Logs
cd ../log-simulator
python3 log_producer.py

6️⃣ View Logs

Open the OpenSearch Dashboard (Kibana) URL from Terraform output

Create an index pattern: app-logs*

Explore logs in real time

🧹 Cleanup

To remove all AWS resources and prevent charges:

cd terraform
terraform destroy -auto-approve
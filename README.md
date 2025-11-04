# 🚀 Real-Time Log Monitoring Dashboard (AWS + Terraform)

### 🧠 Overview
A serverless, real-time observability pipeline that streams simulated logs → processes them → visualizes insights using AWS services.

### 🏗️ Architecture
![Architecture](https://raw.githubusercontent.com/yourusername/real-time-log-monitoring-dashboard/main/docs/architecture.png)

### ⚙️ Services Used
- **Amazon Kinesis** – real-time log streaming
- **AWS Lambda** – processes and sends logs to OpenSearch
- **Amazon OpenSearch Service** – storage and visualization
- **Terraform** – infrastructure as code
- **Python** – log simulation and Lambda function

### 💡 Key Features
- Event-driven serverless architecture  
- Real-time data ingestion and visualization  
- Infrastructure fully automated with Terraform  

### 🧩 Setup
```bash
# Build Lambda package
cd lambda
bash build_layer.sh

# Deploy infrastructure
cd ../terraform
terraform init
terraform apply -auto-approve

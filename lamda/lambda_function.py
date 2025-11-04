import json
import base64
import boto3
import requests
from requests_aws4auth import AWS4Auth
import os

region = os.environ['AWS_REGION']
service = 'es'
credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key, region, service, session_token=credentials.token)

opensearch_url = os.environ['OPENSEARCH_URL']
index_name = 'app-logs'
headers = {"Content-Type": "application/json"}

def lambda_handler(event, context):
    for record in event['Records']:
        payload = base64.b64decode(record["kinesis"]["data"]).decode("utf-8")
        log_data = json.loads(payload)

        document = {
            "timestamp": log_data.get("timestamp"),
            "level": log_data.get("level"),
            "message": log_data.get("message"),
            "source": log_data.get("source")
        }

        url = f"{opensearch_url}/{index_name}/_doc"
        response = requests.post(url, auth=awsauth, json=document, headers=headers)
        print(f"Indexed log: {response.status_code} -> {response.text}")

    return {"statusCode": 200, "body": "Processed successfully"}

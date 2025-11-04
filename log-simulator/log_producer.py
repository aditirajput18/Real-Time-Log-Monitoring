import boto3
import json
import time
import random
import datetime

kinesis = boto3.client('kinesis', region_name='us-east-1')
stream_name = 'real-time-log-monitor-stream'

levels = ['INFO', 'WARN', 'ERROR']
sources = ['auth-service', 'payment-service', 'api-gateway', 'frontend']

while True:
    log = {
        "timestamp": datetime.datetime.utcnow().isoformat(),
        "level": random.choice(levels),
        "source": random.choice(sources),
        "message": f"Sample log entry at {datetime.datetime.now().strftime('%H:%M:%S')}"
    }

    kinesis.put_record(
        StreamName=stream_name,
        Data=json.dumps(log),
        PartitionKey="partitionKey"
    )

    print(f"Sent log: {log}")
    time.sleep(2)

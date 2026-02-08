#!/bin/bash
set -e

echo "Starting EC2 initialization..."

# Update system packages
yum update -y

# Install MySQL client (to verify DB connectivity)
yum install -y mysql

# Install jq (to parse JSON from Secrets Manager)
yum install -y jq

# Install CloudWatch agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
rpm -U ./amazon-cloudwatch-agent.rpm

echo "Fetching DB credentials from Secrets Manager..."

# Fetch DB credentials from Secrets Manager
SECRET_JSON=$(aws secretsmanager get-secret-value \
  --secret-id chewbacca/rds/mysql \
  --region us-east-1 \
  --query 'SecretString' \
  --output text)

DB_HOST=$(echo $SECRET_JSON | jq -r '.host')
DB_PORT=$(echo $SECRET_JSON | jq -r '.port')
DB_USER=$(echo $SECRET_JSON | jq -r '.username')
DB_PASSWORD=$(echo $SECRET_JSON | jq -r '.password')
DB_NAME=$(echo $SECRET_JSON | jq -r '.dbname')

echo "Testing database connection to $DB_HOST:$DB_PORT..."

# Test DB connectivity
if mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -e "SELECT 1" > /dev/null 2>&1; then
  echo "✓ Database connection successful!"
else
  echo "✗ Database connection FAILED"
  # Send custom metric to CloudWatch
  aws cloudwatch put-metric-data \
    --metric-name DBConnectionErrors \
    --namespace Lab/RDSApp \
    --value 1 \
    --region us-east-1
  exit 1
fi

echo "Configuring CloudWatch agent..."

# Configure CloudWatch agent to ship logs
mkdir -p /opt/aws/amazon-cloudwatch-agent/etc

cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<EOF
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/app.log",
            "log_group_name": "/aws/ec2/chewbacca-rds-app",
            "log_stream_name": "{instance_id}"
          }
        ]
      }
    }
  },
  "metrics": {
    "namespace": "Lab/RDSApp",
    "metrics_collected": {
      "mem": {
        "measurement": [
          {
            "name": "mem_used_percent",
            "rename": "MemoryUtilization",
            "unit": "Percent"
          }
        ],
        "metrics_collection_interval": 60
      }
    }
  }
}
EOF

# Start CloudWatch agent
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -s \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

echo "Creating application log file..."

# Create log file
touch /var/log/app.log
chmod 666 /var/log/app.log

# TODO: Student installs their application here
# Example for a simple Python app:
# pip install flask
# cat > /home/ec2-user/app.py << 'APPEOF'
# from flask import Flask
# app = Flask(__name__)
# @app.route('/health')
# def health():
#     return {"status": "healthy"}
# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=80)
# APPEOF

# TODO: Student starts their application here
# Example: nohup python /home/ec2-user/app.py > /var/log/app.log 2>&1 &

# For now, create a simple placeholder app that listens on port 80
nohup bash -c 'while true; do { echo -e "HTTP/1.1 200 OK\r\nContent-Length: 13\r\n\r\nHello World!"; } | nc -l -p 80 -q 1; done' > /var/log/app.log 2>&1 &

echo "✓ EC2 initialization complete!"
echo "Application should now be running on port 80"
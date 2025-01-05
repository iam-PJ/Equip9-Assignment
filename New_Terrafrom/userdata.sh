#!/bin/bash

# Update the package list
sudo apt-get update -y

# Install required dependencies
sudo apt-get install -y python3-venv python3-pip

# Create a virtual environment
python3 -m venv /home/ubuntu/assignment/venv

# Activate the virtual environment
source /home/ubuntu/assignment/venv/bin/activate

# Install Flask and boto3 in the virtual environment
pip install flask boto3

# Setup AWS credentials
mkdir -p /home/ubuntu/.aws
cat <<EOL > /home/ubuntu/.aws/credentials
[default]
aws_access_key_id =  ******
aws_secret_access_key = *******
EOL

# Create the project directory
mkdir -p /home/ubuntu/assignment
cd /home/ubuntu/assignment

# Create the Flask app
cat <<EOF > /home/ubuntu/assignment/app.py
from flask import Flask, jsonify
import boto3
from botocore.exceptions import NoCredentialsError

app = Flask(__name__)

# Initialize the S3 client
s3_client = boto3.client('s3')
bucket_name = 'equip9transport'  # Replace with your S3 bucket name

@app.route('/')
def index():
    return "Welcome to the S3 Bucket Content Service!"

@app.route('/favicon.ico')
def favicon():
    return '', 204  # No content, no error

@app.route('/list-bucket-content', defaults={'path': ''})
@app.route('/list-bucket-content/<path>', methods=['GET'])
def list_bucket_content(path):
    try:
        # List objects in the specified path
        if path:
            prefix = path + '/'
        else:
            prefix = ''

        response = s3_client.list_objects_v2(
            Bucket=bucket_name,
            Prefix=prefix,
            Delimiter='/'
        )

        # Extract the content (folders and files)
        content = []
        if 'CommonPrefixes' in response:
            content.extend([prefix['Prefix'].split('/')[-2] for prefix in response['CommonPrefixes']])
        if 'Contents' in response:
            content.extend([content['Key'].split('/')[-1] for content in response['Contents']])

        return jsonify({"content": content})

    except NoCredentialsError:
        return jsonify({"error": "No AWS credentials found"}), 403
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)  # Ensure you're using the correct port
EOF

# Start Flask app in the background
nohup python3 /home/ubuntu/assignment/app.py &

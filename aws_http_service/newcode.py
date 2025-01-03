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

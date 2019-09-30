import os
import json
import zlib
import base64
import boto3
from email.utils import parseaddr
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

SQS_URL = "${cc_sqs}"
SES_FROM = os.environ['sender']


def lambda_handler(event, context):
    ses = boto3.client('ses')
    sqs = boto3.client('sqs')
    iam = boto3.client('iam')

    body = event['Records'][0]['body']
    receipt_handle = event['Records'][0]['receiptHandle']

    users = json.loads(zlib.decompress(base64.b64decode(body)))['resources']
    for user in users:
        to_email = SES_FROM
        user_tags = iam.list_user_tags(UserName=user['UserName'])['Tags']
        for t in user_tags:
            if 'email' in t['Key']:
                to_email = t['Value']
        print(to_email)

        template_data = {}
        template_data['user_name'] = user['UserName']
        response = ses.send_templated_email(
            Source=SES_FROM,
            Destination={
                'ToAddresses': [
                    to_email,
                ]
            },
            ReplyToAddresses=[
                SES_FROM,
            ],
            Template='TEMPLATE_NAME',
            TemplateData=template_data.as_string()
        )

    sqs.delete_message(QueueUrl=SQS_URL, ReceiptHandle=receipt_handle)

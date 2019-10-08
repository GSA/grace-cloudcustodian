cd lambda
virtualenv -p python3 venv 
source venv/bin/activate 
pip3 install boto3 
pip3 freeze > requirements.txt 
cd venv/lib/*/site-packages/ 
zip -r9 sqs_mailer.zip * 
cd - 
mv venv/lib/*/site-packages/sqs_mailer.zip . 
touch sqs_mailer.py
zip -r9 sqs_mailer.zip sqs_mailer.py
rm -fr venv

import json
import boto3
import os

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(os.environ['TABLE_NAME'])

def handler(event, context):
    try:
        data = json.loads(event['body'])
        item = {
            'id': data['id'],
            'name': data['name'],
            'age': data['age']
        }

        table.put_item(Item=item)

        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'Data added successfully!', 'item': item})
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'message': 'Failed to add data', 'error': str(e)})
        }

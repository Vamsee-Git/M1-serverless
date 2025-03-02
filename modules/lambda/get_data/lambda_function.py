import json
import boto3
import os

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(os.environ['TABLE_NAME'])

def handler(event, context):
    try:
        item_id = event['queryStringParameters']['id']
        response = table.get_item(Key={'id': item_id})

        if 'Item' not in response:
            return {
                'statusCode': 404,
                'body': json.dumps({'message': f"Item with id {item_id} not found."})
            }

        return {
            'statusCode': 200,
            'body': json.dumps({'item': response['Item']})
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'message': 'Failed to retrieve data', 'error': str(e)})
        }

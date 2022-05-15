import boto3
import json
import logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

dynamodbTableName = 'mytable'
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(dynamodbTableName)

getMethod = 'GET'
postMethod = 'POST'
patchMethod = 'PATCH'
deleteMethod = 'DELETE'
healthPath = '/health'
moviePath = '/movie'
moviesPath = '/movies'





def lambda_handler(event, context):
    logger.info(event)
    httpMethod = event['httpMethod']
    path = event['path']
    if httpMethod == getMethod and path == healthPath:
       response = buildResponse(200)
    elif httpMethod == getMethod and path == moviePath:
        response = getmovie(event['queryStringParameters']['movies'])
    elif httpMethod == getMethod and path == moviesPath:
        response = getmovies()
    elif httpMethod == postMethod and path == moviePath:
        response = savemovies(json.loads(event['body']))
    elif httpMethod == deleteMethod and path == moviePath:
        requestBody = json.loads(event['body'])
        response = deletemovie(requestBody['movies'])
    else:
        response = buildResponse(400, 'Not Found')
    return response

def getmovie(movies):
    try:
        response= table.get_item(
            Key={
                'movies' : movies
            }
        )
        if 'Item' in response :
            return buildResponse(200, response['Item'])
        else:
            return buildResponse(404, {'Message': 'ProductId: %s not found' % productId})
    except:
        logger.exception('Do your error handling here')

def getmovies():
    try:
        response = table.scan()
        result = response['Items']

        while 'LastEvaluatedkey' in response:
            response = table.scan(ExclusiveStartkey=response['LastEvaluatedkey'])
            result.extend(response['Items'])
        body = {
            'products' : result
        }
        return buildResponse(200, body)
    except:
        logger.exception('do you custm error')

def savemovies(requestBody):
    try:
        table.put_item(Item=requestBody)
        body = {
            'Operation' : 'SAVE',
            'Message' : 'SUCCESS',
            'Item' : requestBody
        }
        return buildResponse(200,body)
    except:
        logger.exception('do your custom error')
        
def deletemovie(movies):
    try:
        response = table.delete_item(
            Key={
                'movies': movies
            },
            ReturnValues='ALL_OLD'
        )
        body = {
            'Operation': 'DELETE',
            'Message': 'SUCCESS',
            'deleteItem': response
        }
        return buildResponse(200, body)
    except:
        logger.exception('do your custom error')


def buildResponse(statusCode, body=None):
    response = {
        'statusCode' : statusCode,
        'headers':{
            'content-Type' : 'application/json',
            'Access-Control-Allow-Origin' : '*'
        }
    }
    if body is not None:
        response['body'] = json.dumps(body)
    return response
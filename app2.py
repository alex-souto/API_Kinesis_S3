from flask import Flask, request
from typing import NamedTuple
import boto3
import json


client = boto3.client('firehose')
Stream = 'PUT-S3---123'
app = Flask(__name__)



class Event(NamedTuple):
    """ Simple Class just to criate an Event object. """
    eventName: str
    metadata: dict
    timestampUTC: int


class TrackBody(NamedTuple): 
    """ Simple Class just to criate an TrackBody object, to follow swagger.yml file.   """
    userId: str
    events: List[Event]


@app.route('/track', methods=['POST']) 
def track():
    """  Responsible to send an incoming data to Kinesis Firehose.   """
    req = request.get_json(force=True)

    track_body = TrackBody(
        userId=req.get('userId'), 
       events=req.get('events')
    )

    """ Writes a single data record into an Amazon Kinesis Data Firehose delivery stream """
    if request.method == 'POST':
        client.put_record(
            DeliveryStreamName=Stream,
            Record={
                'Data': json.dumps(track_body)
            },
        )

        return 'Success, 200



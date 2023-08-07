import os
import boto3
import json
import pandas as pd
import requests

# grab environment variables
ENDPOINT_NAME = os.environ["ENDPOINT_NAME"]
API_ENDPOINT = os.environ["API_ENDPOINT"]
runtime = boto3.client("runtime.sagemaker")

#TODO generalize the logic in this function
def lambda_handler(event, context):


    data = json.loads(json.dumps(event))

    data = data[0]["payload"]["value"]
    data = json.loads(data)

    df = pd.DataFrame.from_records(data)
    df["dt"] = pd.to_datetime(df["timestamp"], unit="ms")

    numTrains = df.vehicleId.nunique()
    timestamp = df.iloc[0]["dt"]

    prediction_array = [numTrains, timestamp.dayofweek, timestamp.hour, timestamp.minute]

    payload = ", ".join(str(x) for x in prediction_array)
    response = runtime.invoke_endpoint(EndpointName=ENDPOINT_NAME, ContentType="text/csv", Body=payload)

    result = json.loads(response["Body"].read().decode())

    url = "http://" + API_ENDPOINT + "/prediction"
    prediction_body = {
        "prediction": result,
        "actual": numTrains,
        "time": str(timestamp.round(freq="T"))
    }

    requests.post(url, json=prediction_body)

    return result

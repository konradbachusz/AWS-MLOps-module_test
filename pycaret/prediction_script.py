#!/usr/bin/env python

# Import the necessary libraries
import json
from pycaret.regression import *
import flask
from flask import Flask, request
import pandas as pd

# Instantiate Flask app
app = Flask(__name__)

# Define the model path
# When you configure the model, you will need to specify the S3 location of
# your model artifacts.
# Sagemaker will automatically download, decompress and store the model's
# weights in the /opt/ml/model folder.
MODEL_PATH = "/opt/ml/model/final_best_model"

# Load the model from the specified path
model = load_model(MODEL_PATH)


@app.route("/ping", methods=["GET"])
def ping():
    return flask.Response(response="\n", status=200,
                          mimetype="application/json")


# Define an endpoint for making predictions
@app.route("/invocations", methods=["POST"])
def predict():
    # Get data from the POST request
    data = request.get_data().decode("utf-8")

    # Convert the data into a Pandas DataFrame
    df = pd.read_json(data, orient="split")

    # Make predictions using the loaded model
    prediction = model.predict(df)

    # Return the prediction results as JSON
    return json.dumps(prediction.tolist())


if __name__ == "__main__":
    # run() method of Flask class runs the application
    # on the local development server.
    app.run()

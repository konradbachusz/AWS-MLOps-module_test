#!/usr/bin/env python

# Import the necessary libraries
from pycaret.regression import *
import flask
from flask import Flask
import pandas as pd
import io

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
    data = None

    # Convert from CSV to pandas
    if flask.request.content_type == "text/csv":
        data = flask.request.data.decode("utf-8")
        s = io.StringIO(data)
        data = pd.read_csv(s, header=None)
    else:
        return flask.Response(
            response="This predictor only supports CSV data", status=415,
            mimetype="text/plain"
        )
    print("Invoked with {} records".format(data.shape[0]))
    # Make predictions using the loaded model
    predictions = model.predict(data)
    # Convert from numpy back to CSV
    out = io.StringIO()
    pd.DataFrame({"results": predictions}).to_csv(out, header=False,
                                                  index=False)
    result = out.getvalue()

    return flask.Response(response=result, status=200, mimetype="text/csv")


if __name__ == "__main__":
    # run() method of Flask class runs the application
    # on the local development server.
    app.run()

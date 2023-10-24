# import libraries
import boto3
from sagemaker import get_execution_role
from dotenv import load_dotenv
from pycaret.regression import *
import pandas as pd
from pycaret.regression import save_model
import sys
sys.path.append(".")
from mlops_ml_models.load_data import load_data
# import mlops_ml_models


my_region = boto3.session.Session().region_name

role = get_execution_role()


data_location_s3 = "streaming-data-platform-ml-data/bakerloo.csv"
target = "Bakerloo10"
data_location = "s3://{}".format(data_location_s3)


data = load_data(data_location)
df = data.copy()
print(df.head())

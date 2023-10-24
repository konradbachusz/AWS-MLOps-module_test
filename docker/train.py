# import libraries
import boto3
import os
from sagemaker import get_execution_role
from dotenv import load_dotenv
from load_data import load_data
from pycaret.regression import *
from pycaret.regression import save_model


my_region = boto3.session.Session().region_name

load_dotenv(".env")
role = get_execution_role()

data_location_s3 = os.getenv("data_location_s3")
target = os.getenv("target")

data_location_s3 = "streaming-data-platform-ml-data/bakerloo.csv"
target = "Bakerloo10"
data_location = "s3://{}".format(data_location_s3)


data = load_data(data_location)
df = data.copy()

# Randomly shuffle the DataFrame
df_shuffled = df.sample(frac=1).reset_index(drop=True)
# Sort by day and then pick the first 80% as your test data.
train_size = int(0.8 * len(df))
train_data = df_shuffled[:train_size]
test_data = df_shuffled[train_size:]

s = setup(data=train_data, target=target, session_id=123)
best = compare_models()
final_best_model = finalize_model(best)
save_model(final_best_model, "final_best_model")

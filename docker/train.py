# import libraries
import boto3
import os
from sagemaker import get_execution_role

# from dotenv import load_dotenv
from pycaret.regression import *
from pycaret.regression import save_model
import pandas as pd
from sagemaker import Session


def read_data(data_location: str) -> pd.DataFrame:
    """This script takes in the location of your data (csv file),
    loads that as a dataframe and then returns the dataframe.
    Note:
        There is a section to remove all unnamed columns, you may want
        to remove that if you think it will affect your data.

    Args:
        data_location (str): This is the location of your data, usually S3

    Returns:
        pd.DataFrame: This returns a dataframe of your data.
    """
    try:
        df = pd.read_csv(data_location, low_memory=False)
        # Dropped unnamed columns. You should comment this portion out before
        # using the script if you dont have unamed columns
        df = df.loc[:, ~df.columns.str.contains("^Unnamed")]
        return df
    except Exception as e:
        print(f"Error loading data: {e}")


my_region = boto3.session.Session().region_name
print(f"my region {my_region}")
sagemaker_client = boto3.client('sagemaker', region_name="eu-west-2")

role = get_execution_role()
print("role:", role)
# load_dotenv(".env")
# data_location_s3 = os.getenv("data_location_s3")
# target = os.getenv("target")

data_location_s3 = "streaming-data-platform-ml-data/bakerloo.csv"
target = "Bakerloo10"
data_location = "s3://{}".format(data_location_s3)


data = read_data(data_location)
df = data.copy()
print(df.head())

# Randomly shuffle the DataFrame
df_shuffled = df.sample(frac=1).reset_index(drop=True)
# Sort by day and then pick the first 80% as your test data.
train_size = int(0.8 * len(df))
train_data = df_shuffled[:train_size]
test_data = df_shuffled[train_size:]

s = setup(data=train_data, target=target, session_id=123)
best = compare_models()
final_best_model = finalize_model(best)


model_save_dir = f"{os.environ.get('SM_MODEL_DIR')}/1"

# Model prediction
predict_model(final_best_model, data=test_data)

# Save model
save_model(final_best_model, model_save_dir)

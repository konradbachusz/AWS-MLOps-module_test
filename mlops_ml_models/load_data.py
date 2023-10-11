import pandas as pd


def load_data(data_location):
    try:
        df = pd.read_csv(data_location, low_memory=False)
        # Dropped unnamed columns. You should comment this portion out before
        # using the script if you dont have unamed columns
        df = df.loc[:, ~df.columns.str.contains('^Unnamed')]
        return df
    except Exception as e:
        print(f"Error loading data: {e}")

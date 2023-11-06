import pandas as pd

def split_data(df: pd.DataFrame, shuffle: bool) -> pd.DataFrame:
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
        if shuffle:
            df = df.sample(frac=1).reset_index(drop=True)

        train_size = int(0.8 * len(df))
        train_data = df[:train_size]
        test_data = df[train_size:]

        return train_data, test_data
    except Exception as e:
        print(f"Error loading data: {e}")
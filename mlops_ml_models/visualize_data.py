import seaborn as sns
import matplotlib.pyplot as plt


def visualize_data(df):
    num_cols = df.select_dtypes(include=["float64", "int64"]).columns
    cat_cols = df.select_dtypes(include=["object", "category"]).columns

    for col in num_cols:
        sns.histplot(df[col])
        plt.title(f"Histogram for {col}")
        plt.show()

        sns.boxplot(x=df[col])
        plt.title(f"Boxplot for {col}")
        plt.show()

    for col in cat_cols:
        sns.countplot(x=df[col])
        plt.title(f"Bar chart for {col}")
        plt.show()


if __name__ == "__main__":
    import pandas as pd
    import numpy as np

    np.random.seed(42)  # For reproducibility
    data = {
        "A": np.random.randint(1, 100, 20),
        "B": np.random.randint(1, 100, 20),
        "C": np.random.randint(1, 100, 20),
        "D": np.random.randint(1, 100, 20),
        "E": np.random.randint(1, 100, 20),
    }
    df = pd.DataFrame(data)
    visualize_data(df)

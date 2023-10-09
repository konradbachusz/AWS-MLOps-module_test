import matplotlib.pyplot as plt
import seaborn as sns


def correlation_analysis(df):
    corr_matrix = df.corr()
    plt.figure(figsize=(12, 8))
    sns.heatmap(corr_matrix, annot=True, cmap="coolwarm")
    plt.title("Correlation Matrix")
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
    correlation_analysis(df)

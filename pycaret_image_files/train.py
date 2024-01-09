import importlib
import pandas as pd


def training_data(train_data: pd.DataFrame, target: str,
                  algorithm_choice: str
                  ):
    # Import Pycaret library depending on the algorithm choice
    pycaret = importlib.import_module(f"pycaret.{algorithm_choice}")

    # Initialize data in PyCaret with all the defined parameters
    pycaret.setup(data=train_data, target=target, session_id=123)

    # Train and evaluate the performance of all estimators available in the
    # model library using cross-validation.
    bestModel = pycaret.compare_models()
    return bestModel

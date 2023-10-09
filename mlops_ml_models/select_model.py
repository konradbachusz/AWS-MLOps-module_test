from sklearn.linear_model import LinearRegression
from sklearn.linear_model import Ridge
from sklearn.linear_model import Lasso
from sklearn.svm import SVR
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.neighbors import KNeighborsRegressor
from sklearn.ensemble import AdaBoostRegressor
import logging

logging.basicConfig(level=logging.INFO)


def select_model(model_name: str):
    model_dict = {
        "linearregression": LinearRegression(),
        "ridge": Ridge(),
        "lasso": Lasso(),
        "svr": SVR(),
        "decisiontreeregressor": DecisionTreeRegressor(),
        "randomforestregressor": RandomForestRegressor(),
        "kneighborsregressor": KNeighborsRegressor(),
        "adaboostregressor": AdaBoostRegressor(),
    }
    specified_model = model_dict.get(model_name)

    if specified_model is not None:
        logging.info(f"Using {type(specified_model).__name__}")
        return specified_model
    raise ValueError("Invalid model type.")

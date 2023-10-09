import pytest
from mlops_ml_models.select_model import select_model
from sklearn.linear_model import LinearRegression, Lasso, Ridge
from sklearn.svm import SVR
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.neighbors import KNeighborsRegressor
from sklearn.ensemble import AdaBoostRegressor

scenarios = [
    ("linearregression", LinearRegression),
    ("ridge", Ridge),
    ("lasso", Lasso),
    ("svr", SVR),
    ("decisiontreeregressor", DecisionTreeRegressor),
    ("randomforestregressor", RandomForestRegressor),
    ("kneighborsregressor", KNeighborsRegressor),
    ("adaboostregressor", AdaBoostRegressor),
]


@pytest.mark.parametrize("user_input,expected_model", scenarios)
def test_select_model_with_valid_name(user_input, expected_model):
    model = select_model(user_input)
    assert isinstance(model, expected_model)


def test_select_model_with_invalid_name():
    with pytest.raises(ValueError):
        select_model("invalid_model_name")

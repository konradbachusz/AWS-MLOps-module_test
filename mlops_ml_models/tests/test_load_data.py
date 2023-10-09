from mlops_ml_models.load_data import load_data
import pandas as pd
import pytest
from unittest.mock import patch


@pytest.fixture
def mock_df() -> pd.DataFrame:
    return pd.DataFrame({
        'col1': [1, 2, 3],
        'col2': ['A', 'B', 'C'],
        'col3': [4.5, 5.5, 6.5]
    })


def test_load_data(mock_df: pd.DataFrame) -> None:
    with patch('pandas.read_csv', return_value=mock_df):
        result = load_data("mlops_ml_models/tests/resources/sample.csv")
        
    pd.testing.assert_frame_equal(result, mock_df)
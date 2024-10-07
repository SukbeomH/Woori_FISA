# train.py
from typing import List

import numpy as np
import pandas as pd
from sklearn.compose import ColumnTransformer
from sklearn.impute import SimpleImputer
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import MinMaxScaler

def load_data() -> tuple[pd.DataFrame, np.ndarray]:
    df = pd.read_csv("./data/train.csv")

    y = np.log1p(df["SalePrice"].to_numpy())
    X = df.drop(["Id", "Alley", "PoolQC", "Fence",
                "MiscFeature", "SalePrice"], axis=1)
    return X, y

def identify_column_types(X: pd.DataFrame) -> tuple[List, List]:
    num_cols = X.select_dtypes("number").columns.tolist()
    cat_cols = X.select_dtypes("object").columns.tolist()

    return num_cols, cat_cols

def make_preprocess_pipeline(num_cols, cat_cols) -> ColumnTransformer:
    num_processor = Pipeline(steps=[
        ("imputer", SimpleImputer(strategy="most_frequent")),
        ("scaler",  MinMaxScaler())
    ])

    cat_processor = Pipeline(steps=[
        ("imputer", SimpleImputer(strategy="constant",
                                  fill_value="None"))
    ])

    preprocessor = ColumnTransformer([
        ("num", num_processor, num_cols),
        ("cat", cat_processor, cat_cols)
    ])

    return preprocessor

X, y = load_data()

num_cols, cat_cols = identify_column_types(X)

preprocessor = make_preprocess_pipeline(num_cols, cat_cols)

X_ = pd.DataFrame(preprocessor.fit_transform(X, y),
                  columns=num_cols+cat_cols)
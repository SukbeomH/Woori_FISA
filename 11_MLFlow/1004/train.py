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

    y = np.log1p(df["SalePrice"].ravel())
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

# optuna_catboost.py

import catboost
import optuna

class Objective(object):
    def __init__(self, pool):
        self.pool = pool

    def __call__(self, trial):
        pool = self.pool
        
        max_depth = trial.suggest_int("max_depth", 3, 10)
        learning_rate = trial.suggest_float("learning_rate", 0.05, 0.3)
        subsample = trial.suggest_float("subsample", 0.75, 1)
        l2_leaf_reg = trial.suggest_float("l2_leaf_reg", 1e-5, 1e-1, log=True)
        
        params = {"loss_function": "RMSE",
                  "depth": max_depth,
                  "learning_rate": learning_rate,
                  "subsample": subsample,
                  "l2_leaf_reg": l2_leaf_reg}
        
        cv_result = catboost.cv(pool=pool,
                                params=params,
                                num_boost_round=1000,
                                nfold=5,
                                seed=0,
                                early_stfopping_rounds=30,
                                verbose=False)
        
        rmsle = cv_result["test-RMSE-mean"].min()
        
        return rmsle

pool = catboost.Pool(X_, label=y, cat_features=cat_cols)
objective = Objective(pool)
study = optuna.create_study(
    study_name="house_price_prediction",
    direction="minimize",
    pruner=optuna.pruners.HyperbandPruner(max_resource="auto")
    )
    
    
## Callback 적용
from optuna.integration.mlflow import MLflowCallback

def make_mlflow_callback():
    cb = MLflowCallback(
        tracking_uri="mlruns",
        metric_name="RMSLE"
    )
    return cb

mlflow_cb = make_mlflow_callback()
study.optimize(objective, n_trials=5, callbacks=[mlflow_cb])

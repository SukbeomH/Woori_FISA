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
study.optimize(objective, n_trials=50, callbacks=[mlflow_cb])

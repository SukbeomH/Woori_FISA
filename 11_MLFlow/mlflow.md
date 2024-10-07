```
 conda create --name mlflow
 conda activate mlflow
 pip install -U mlflow optuna
 conda install -c conda-forge jupyter ipykernel
 python -m ipykernel install --user --name mlflow --display-name "MLFLOW"
 pip install catboost optuna-integration[mlflow]
```

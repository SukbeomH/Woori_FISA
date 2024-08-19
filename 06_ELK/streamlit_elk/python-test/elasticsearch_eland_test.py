# conda create --name myenv python=3.11
# conda activate myenv
# python elasticsearch_eland_test.py
import eland as ed

df = ed.DataFrame(es_client="http://localhost:9200",
    es_index_pattern="kibana_sample_data_flights")

print(df.head())


# pip install eland jupyterlab ipykernel
# python -m ipykernel install --user --name=myenv --display-name "Python (myenv)"
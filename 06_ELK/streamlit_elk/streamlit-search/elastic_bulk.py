from elasticsearch import Elasticsearch
from elasticsearch import helpers
import pandas as pd
import json

def get_stock_info():
    base_url =  "http://kind.krx.co.kr/corpgeneral/corpList.do"    
    method = "download"
    url = "{0}?method={1}".format(base_url, method)   
    df = pd.read_html(url, header=0, encoding='euc-kr')[0]
    df['종목코드']= df['종목코드'].apply(lambda x: f"{x:06d}")     
    return df

df = get_stock_info()

json_str = df.to_json(orient='records')

json_records = json.loads(json_str)

es = Elasticsearch("http://localhost:9200", http_compress=True)
index_name = 'stock_info'
doctype = 'stock_record'
es.indices.delete(index=index_name, ignore=[400, 404])
es.indices.create(index=index_name, ignore=400)
action_list = []
for row in json_records:
    record ={
        '_op_type': 'index',
        '_index': index_name,
        '_source': row
    }
    action_list.append(record)
helpers.bulk(es, action_list)
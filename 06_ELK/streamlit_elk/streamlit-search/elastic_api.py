from datetime import datetime
from elasticsearch import Elasticsearch
from elasticsearch_dsl import Search

client = Elasticsearch('http://localhost:9200')

def search_index(index_name, field_name, match_name):
    s = Search(index=index_name).using(client).query("multi_match", fields=field_name, query=match_name)
    print(s.to_dict())
    response = s.execute()
    return response

def search_index_with_date_range(index_name, field_name, match_name, start_date, end_date):
    s = Search(index=index_name).using(client).query("multi_match", fields=field_name, query=match_name)
    s = s.filter('range', timestamp={'gte': start_date, 'lte': end_date})
    response = s.execute()
    return response


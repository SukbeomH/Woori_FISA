# https://elasticsearch-dsl.readthedocs.io/en/latest/search_dsl.html
# https://danthetech.netlify.app/Backend/advanced-tutorial-of-elasticsearch-dsl
from datetime import datetime
from elasticsearch import Elasticsearch
from elasticsearch_dsl import Search

client = Elasticsearch('http://localhost:9200')

# 1. 인덱스, DOC 생성
INDEX = 'test-index'
doc = {
    'author': '김연지',
    'text': '첫번째 글입니다',
    'timestamp': datetime.now(),
}
resp = client.index(index=INDEX, id=1, document=doc)
print(resp['result'])

# 2. 인덱스 조회
s = Search(using=client)
s = Search(index=INDEX).using(client).query("match", author="김연지")
print(s.to_dict())
response = s.execute()
print('인덱스 조회 결과', response[0].to_dict())
print()

# 2. 다중 조건으로 조회
# {"multi_match": {"query": "김연지", "fields": ["text", "auhtor"]}}
s = s.query("multi_match", query='김연지', fields=['text', 'author'])
print(s.to_dict())
response = s.execute()
print('MultiMatch로 조회 결과', response)

# https://www.elastic.co/guide/en/elasticsearch/client/python-api/master/examples.html
from datetime import datetime
from elasticsearch import Elasticsearch

es = Elasticsearch('http://localhost:9200')

# 1. 인덱스, DOC 생성
INDEX = 'test-index'

doc = {
    'author': '김연지',
    'text': '첫번째 글입니다',
    'timestamp': datetime.now(),
}
resp = es.index(index=INDEX, id=1, document=doc)
print(resp['result'])
# 생성한 index 는 다음 방식으로 확인할 수 있다.
# !curl -XGET localhost:9200/_cat/indices?v
# 지우는 법은 아래와 같다.
# es.indices.delete(index=INDEX)

# 검색
# Query 만드는 방식이 다양하다.
# 'match' 방식을 통해 완전 일치는 아니지만, 최대한 유사한 것을 찾는다.
# 형태를 지켜야 하며, 'text' 라는 Key 는 데이터를 저장할 때 사용했던 Key 다.
body = {
        "query": {
            "match": {
                "author": "김연지"
                #'text': '첫번째'
                    }
                }
            }

res = es.search(index=INDEX, body=body)
print('match 쿼리 확인', res)
# 실제로 적용할 때는, Test Dataset 의 question 들을 가져와서 search 하면 끝
# 검색 결과는 점수가 높은 순으로 정렬되어 반환된다

# 2. 인덱스 조회
# -1. 간략 조회
resp = es.get(index="test-index", id=1)
print(resp['_source'])

# -2. 특정 조건으로 조회
resp = es.search(index="test-index", query={"match_all": {}})
print("Got %d Hits:" % resp['hits']['total']['value'])
for hit in resp['hits']['hits']:
    print("%(timestamp)s %(author)s: %(text)s" % hit["_source"])


# 3. 인덱스 수정
doc = {
    'author': '김연지2',
    'text': '첫번째 글입니다',
    'timestamp': datetime.now(),
}
resp = es.index(index="test-index", id=1, document=doc)
print(resp['result'])
# print(resp.keys())
# print(resp['_shards'])

resp = es.get(index="test-index", id=1)
print(resp['_source'])

# 4. 인덱스 삭제
resp = es.delete(index="test-index", id=1)
print(resp['result'])


# server2라는 폴더에 아래 파일을 flask_server2.py라는 이름으로 작성 후 실행
# pip install flask
from flask import Flask

app = Flask(__name__)

@app.route('/hello')
def hello():
    return 'hello world!'

@app.route('/bye')
def bye():
    return 'bye world!'

if __name__ == '__main__':
    app.run(debug=True)
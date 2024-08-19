# server1라는 폴더에 아래 파일을 fastapi_server1.py라는 이름으로 작성 후 실행
# pip install fastapi uvicorn
# uvicorn fastapi_server1:app --log-level info  1> "server1.log"
from fastapi import FastAPI

app = FastAPI()

@app.get("/deposit/{amount}")
async def deposit(amount: int):
    return f"{amount}원 입금"

@app.get("/withdraw/{amount}")
async def withdraw(amount: int):
    return f"{amount}원 출금"


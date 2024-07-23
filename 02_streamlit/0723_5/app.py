import streamlit as st
import pandas as pd
import FinanceDataReader as fdr
import datetime
from io import BytesIO
import plotly.graph_objects as go

# 최초 변수
search = False
today = datetime.date.today()
start_year = datetime.date(today.year - 5, today.month, today.day)

# 사이드바 제작
with st.sidebar:
    st.header("회사 이름과 기간을 입력하세요")
    stock_name = st.text_input(label="회사이름", value="삼성전자")
    date_range = st.date_input(
            label="시작일 - 종료일",
            value=(start_year, today),
            min_value=start_year,
            max_value=today,
        )
    search = st.button("주가 데이터 확인")
    
# caching
# 인자가 바뀌지 않는 함수 실행 결과를 저장 후 크롬의 임시 저장 폴더에 저장 후 재사용
@st.cache_data
def get_stock_info():
    base_url = "http://kind.krx.co.kr/corpgeneral/corpList.do"
    method = "download"
    url = "{0}?method={1}".format(base_url, method)
    df = pd.read_html(url, header=0, encoding='cp949')[0]
    df["종목코드"] = df["종목코드"].apply(lambda x: f"{x:06d}")
    df = df[["회사명", "종목코드"]]
    return df

def get_ticker_symbol(company_name):
    df = get_stock_info()
    code = df[df["회사명"] == company_name]["종목코드"].values
    ticker_symbol = code[0]
    return ticker_symbol

# 검색 했을 때만 실행되도록
if search:
    # 코드 조각 추가
    ticker_symbol = get_ticker_symbol(stock_name)
    start_p = date_range[0]
    end_p = date_range[1] + datetime.timedelta(days=1)
    df = fdr.DataReader(f"KRX:{ticker_symbol}", start_p, end_p)
    df.index = df.index.date
    st.subheader(f"[{stock_name}] 주가 데이터")
    fig = go.Figure(
        data=[
            go.Candlestick(
                x=df.index,
                open=df["Open"],
                high=df["High"],
                low=df["Low"],
                close=df["Close"],
            )
        ]
    )
    
    # 검색 시 나타나는 데이터
    st.dataframe(df.tail(7))
    st.plotly_chart(fig, use_container_width=True)
    
    # 바이너리 형태로, 데이터를 파일로 변환
    excel_data = BytesIO()      
    df.to_excel(excel_data, index=False)
    csv_file = df.to_csv(index=False).encode("utf-8")
    
    # 데이터 다운로드를 위한 버튼 (수평으로 배치)
    col1, col2 = st.columns(2)
    col1.download_button(
        label="엑셀 파일 다운로드",
        data=excel_data,
        file_name="stock_data.xlsx",
        mime="text/xlsx",
        key="download-xlsx",
        )
    col2.download_button(
        label="CSV 파일 다운로드",
        data=csv_file,
        file_name="stock_data.csv",
        mime="text/csv",
        key="download-csv",
    )
else:
    # 검색하지 않은 상황에서만 나오는 문구 설정
    st.header("무슨 주식을 사야 부자가 되려나...")

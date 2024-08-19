import streamlit as st
import pandas as pd
import datetime
from io import BytesIO
import pandas as pd
from elastic_api import search_index, search_index_with_date_range

st.title("엘라스틱서치에 저장된 인덱스 조회") 
st.markdown(
    """     <style>
    [data-testid="stSidebar"][aria-expanded="true"] > div:first-child{width:250px;}     </style>
    """, unsafe_allow_html=True )

st.sidebar.header("조회하고 싶은 인덱스명을 입력하세요")
index_name = st.sidebar.text_input('인덱스명', value="stock_info").lower()

field_name = st.sidebar.text_input('필드명', value="회사명")

match_name = st.sidebar.text_input('조회하려는 내용', value="삼성전자")
clicked1 = st.sidebar.button("해당 정보 확인")

date_range = st.sidebar.date_input("도큐먼트 생성일",
                 [datetime.date(2019, 1, 1), datetime.date(2024, 1, 3)]) 
clicked2 = st.sidebar.button("생성일 확인")


if(clicked1 == True):
    result = search_index(index_name, field_name, match_name)     
    # st.write(result.to_dict())
    st.write(result.to_dict()["hits"]["hits"])

    source_data = [entry["_source"] for entry in result.to_dict()["hits"]["hits"]]
    df = pd.DataFrame(source_data)
    st.dataframe(df)



if(clicked2 == True):    
    start_p = date_range[0]               
    end_p = date_range[1] + datetime.timedelta(days=1) 
    result = search_index_with_date_range(index_name, field_name, match_name, start_date=start_p, end_date=end_p)     
    st.write(result.to_dict()["hits"]["hits"])
    source_data = [entry["_source"] for entry in result.to_dict()["hits"]["hits"]]
    df = pd.DataFrame(source_data)
    st.dataframe(df)
    
    csv_data = df.to_csv()  
    excel_data = BytesIO()      
    df.to_excel(excel_data)     
    columns = st.columns(2) 
    with columns[0]:
        st.download_button("CSV 파일 다운로드", csv_data, file_name='stock_data.csv')   
    with columns[1]:
        st.download_button("엑셀 파일 다운로드", 
        excel_data, file_name='stock_data.xlsx')

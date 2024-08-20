import streamlit as st
import pandas as pd
from io import BytesIO
from elastic_api import search_index

# 카드 ID를 사용하여 이미지 URL을 생성하는 함수
def extract_image_url(card_id):
    return f"https://woori-fisa-bucket.s3.ap-northeast-2.amazonaws.com/index_img/bcc_{card_id:03d}.png"

st.title("🔎 검색한 카드 정보")
st.markdown(
    """<style>
    [data-testid="stSidebar"][aria-expanded="true"] > div:first-child{width:250px;} </style>""",
    unsafe_allow_html=True
)

st.sidebar.header("조회하고 싶은 인덱스명을 입력하세요")
index_name = st.sidebar.text_input('인덱스명', value="card_info").lower()
field_name = st.sidebar.text_input('필드명', value="card_name")
match_name = st.sidebar.text_input('조회하려는 내용', value="카드")
clicked1 = st.sidebar.button("검색한 정보 보러가기 🎇")

if clicked1:
    result = search_index(index_name, field_name, match_name)
    hits = result.to_dict()["hits"]["hits"]
    
    if hits:
        source_data = [entry["_source"] for entry in hits]
        df = pd.DataFrame(source_data)
        
        # 국내 연회비를 기준으로 정렬 (내림차순)
        df = df.sort_values(by='domestic_year_cost', ascending=False)
        
        df_name_type = df[df.columns.tolist()]
        st.write("Card Name and Type:")
        st.dataframe(df_name_type)
        
        # 카드 ID를 추출하여 이미지 URL을 생성하고 DataFrame에 추가
        if 'id' in df.columns:
            df['card_image_url'] = df['id'].apply(lambda x: extract_image_url(x))
        else:
            st.error("카드 ID 필드를 찾을 수 없습니다.")
        
        # 카드 정보를 스크롤 가능한 영역에 출력
        st.write("### 검색된 카드 정보")
        with st.expander("연회비 순으로 카드 정보 펼치기 😎", expanded=True):
            for _, row in df.iterrows():
                st.write("---")  # 각 카드 사이에 구분선
                col1, col2 = st.columns([1, 2])  # 왼쪽: 이미지, 오른쪽: 카드 정보
                
                with col1:
                    st.image(row.get('card_image_url', ''), width=200)  # 이미지 크기는 필요에 따라 조정
                    
                with col2:
                    st.subheader(row.get('card_name', 'No Name'))
                    
                    # 카드 정보 출력
                    st.write("### 연회비")
                    st.write(f"- 국내 연회비: {row.get('domestic_year_cost', 'No Cost')}")
                    st.write(f"- 해외 연회비: {row.get('abroad_year_cost', 'No Cost')}")
                    
                    st.write("### 주요 혜택")
                    categories = row.get('category', [])
                    sum = ""
                    for cat in categories:
                        if cat.get('class') != '유의사항':
                            st.write(f"- {cat.get('class', 'No Class')}: {cat.get('benefit', 'No Benefit')}")
                            sum += f" {cat.get('class', 'No Class')}"
                    
                    st.write("### 요약 정보")
                    # 카드를 요약하는 로직
                    summary = f"이 카드는 {row.get('abroad_year_cost', 'No Cost')}의 연회비와 {sum} 혜택을 제공합니다."
                    st.write(summary)
        
        # 카드 링크를 포함하는 CSV 파일 생성
        csv_data = df[['card_name', 'id', 'card_image_url', 'card_type', 'domestic_year_cost', 'abroad_year_cost', 'previous_month_performance', 'category']].to_csv(index=False)
        excel_data = BytesIO()
        df.to_excel(excel_data, index=False)
        excel_data.seek(0)  # Ensure that the BytesIO stream is at the start
        
        columns = st.columns(2)
        with columns[0]:
            st.download_button("CSV 파일 다운로드", csv_data, file_name='card_data.csv', mime='text/csv')
        with columns[1]:
            st.download_button("엑셀 파일 다운로드", excel_data, file_name='card_data.xlsx', mime='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    else:
        st.write("쿼리 결과가 없습니다.")
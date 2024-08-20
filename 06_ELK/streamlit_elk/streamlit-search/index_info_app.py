import streamlit as st
import pandas as pd
import datetime
from io import BytesIO
from elastic_api import search_index, search_index_with_date_range

# 카드 ID를 사용하여 이미지 URL을 생성하는 함수
def extract_image_url(card_id):
    return f"https://woori-fisa-bucket.s3.ap-northeast-2.amazonaws.com/index_img/bcc_{card_id:03d}.png"

# 타이틀과 스타일 적용
st.title("🔎 검색한 카드 정보")
st.markdown(
    """
    <style>
    [data-testid="stSidebar"][aria-expanded="true"] > div:first-child{width:250px;}
    .st-bq {background-color: #f0f2f6; padding: 10px; border-radius: 5px;}
    .stButton>button {background-color: #4CAF50; color:white; padding: 10px 24px; font-size: 16px;}
    </style>
    """,
    unsafe_allow_html=True
)

st.sidebar.header("조회하고 싶은 인덱스명을 입력하세요")
index_name = st.sidebar.text_input('인덱스명', value="card_info").lower()
field_name = st.sidebar.text_input('필드명', value="card_name")
match_name = st.sidebar.text_input('조회하려는 내용', value="카드")
clicked1 = st.sidebar.button("해당 정보 확인 🎇")

# 검색 버튼 클릭 시 동작
if clicked1:
    with st.spinner("🔍 검색 중... 잠시만 기다려 주세요!"):
        result = search_index(index_name, field_name, match_name)
    hits = result.to_dict()["hits"]["hits"]
    
    if hits:
        st.success("✅ 검색 완료! 결과를 확인하세요.")

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
        with st.expander("💰 연회비 순으로 카드 정보 펼치기", expanded=False):
            for _, row in df.iterrows():
                st.write("---")  # 각 카드 사이에 구분선
                col1, col2 = st.columns([1, 2])  # 왼쪽: 이미지, 오른쪽: 카드 정보

    
                with col1:
                    # 이미지에 링크를 걸어 클릭 시 해당 URL로 이동
                    card_image_url = row.get('card_image_url', '')
                    card_link = row.get('card_link', '')
                    
                    if card_image_url and card_link:
                        st.markdown(f'''
                            <a href="{card_link}" target="_blank">
                                <img src="{card_image_url}" width="200">
                            </a>
                        ''', unsafe_allow_html=True)
                    else:
                        st.image(row.get('card_image_url', ''), width=200)

                
                with col2:
                    st.subheader(f"🎯 {row.get('card_name', 'No Name')}")
                    
                    # 카드 정보 출력
                    st.write("### 💳 연회비")
                    st.write(f"- 국내 연회비: **{row.get('domestic_year_cost', 'No Cost')}** 원")
                    st.write(f"- 해외 연회비: **{row.get('abroad_year_cost', 'No Cost')}** 원")
                    
                    st.write("### 🎁 주요 혜택")
                    categories = row.get('category', [])
                    sum = ""
                    for cat in categories:
                        if cat.get('class') != '유의사항':
                            st.write(f"- {cat.get('class', 'No Class')}: {cat.get('benefit', 'No Benefit')}")
                            sum += f" {cat.get('class', 'No Class')}"
                    
                    # st.write("### 기타 사항")
                    # 여기에 기타 사항에 대한 로직을 추가할 수 있습니다.
                    
                    st.write("### 📝 요약 정보")
                    # 카드를 요약하는 로직
                    summary = f"이 카드는 **{row.get('abroad_year_cost', 'No Cost')}**의 연회비와 {sum.strip()} 혜택을 제공합니다."
                    st.write(summary)
        
        # 카드 링크를 포함하는 CSV 파일 생성
        csv_data = df[['card_name', 'id', 'card_image_url', 'card_type', 'domestic_year_cost', 'abroad_year_cost', 'previous_month_performance', 'category']].to_csv(index=False)
        excel_data = BytesIO()
        df.to_excel(excel_data, index=False)
        excel_data.seek(0)  # Ensure that the BytesIO stream is at the start
        
        columns = st.columns(2)
        with columns[0]:
            st.download_button("CSV 파일 다운로드 📥", csv_data, file_name='card_data.csv', mime='text/csv')
        with columns[1]:
            st.download_button("엑셀 파일 다운로드 📥", excel_data, file_name='card_data.xlsx', mime='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    else:
        st.write("⚠️ 쿼리 결과가 없습니다.")
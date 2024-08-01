import os
import pandas as pd
import streamlit as st
import requests
import pydeck as pdk
import dotenv

# .env 파일을 읽어서 환경변수로 설정
dotenv.load_dotenv()

url = f'http://openapi.seoul.go.kr:8088/{os.getenv("OPEN_API_KEY")}/json/bikeStationMaster/1/1000/'


res = requests.get(url, timeout=10)
res.encoding = "utf-8"
data = res.json()  # json의 dict화
# print(data)

# 필요한 데이터 추출
bike_data = data["bikeStationMaster"]["row"]

# 데이터프레임 생성
df = pd.DataFrame(bike_data)


# with st.sidebar:

#     menu = ['Home', 'EDA', 'ML', 'About']
#     choice = st.sidebar.selectbox('메뉴', menu)

#     if choice == menu[0] :
#         pass
#     choice = option_menu("Menu", ["대여소 정보 조회", "거리 계산"],
#                          icons=['bi bi-bicycle', 'bi bi-bicycle'],
#                          menu_icon="bi bi-menu-button", default_index=0,
#                          styles={
#         "container": {"padding": "4!important", "background-color": "#fafafa"},
#         "icon": {"color": "black", "font-size": "25px"},
#         "nav-link": {"font-size": "16px", "text-align": "left", "margin":"0px", "--hover-color": "#fafafa"},
#         "nav-link-selected": {"background-color": "#08c7b4"},
#     }
#     choice[1]
#     )


def createPage():
    # Streamlit 앱 설정
    new_title = '<p style="font-family:sans-serif; color:#08c7b4; font-size: 35px;"><strong>서울특별시 자전거 대여소 정보</strong></p>'
    st.markdown(new_title, unsafe_allow_html=True)

    st.write("특정 구를 검색하여 해당 구의 자전거 대여소 정보를 확인하세요.")

    # 사용자 입력 받기
    district = st.text_input("구를 입력하세요 (예: 마포구)")

    # 사용자 입력에 따라 필터링
    if district:
        filtered_df = df[df["ADDR1"].str.contains(district)]

        # 유효한 좌표만 남기기 (위도와 경도가 0이 아닌 값)
        filtered_df = filtered_df[
            (filtered_df["LAT"].astype(float) != 0)
            & (filtered_df["LOT"].astype(float) != 0)
        ]

        if not filtered_df.empty:
            st.write(f"'{district}'의 자전거 대여소 정보")
            st.dataframe(filtered_df)

            # 지도 시각화
            st.write(f"'{district}'의 자전거 대여소 위치")

            # 좌표 데이터 추출 및 변환
            filtered_df["LAT"] = filtered_df["LAT"].astype(float)
            filtered_df["LOT"] = filtered_df["LOT"].astype(float)

            # 중앙 좌표 계산
            center_lat = filtered_df["LAT"].mean()
            center_lon = filtered_df["LOT"].mean()

            # pydeck을 이용한 지도 시각화
            st.pydeck_chart(
                pdk.Deck(
                    map_style="mapbox://styles/mapbox/streets-v11",
                    initial_view_state=pdk.ViewState(
                        latitude=center_lat,
                        longitude=center_lon,
                        zoom=13,
                        pitch=0,
                    ),
                    layers=[
                        pdk.Layer(
                            "ScatterplotLayer",
                            data=filtered_df,
                            get_position="[LOT, LAT]",
                            get_color="[200, 30, 0, 160]",
                            get_radius=200,
                        ),
                    ],
                )
            )
        else:
            st.write(f"'{district}'에 대한 자전거 대여소 정보를 찾을 수 없습니다.")
    else:
        # st.write("구 이름을 입력하세요.")
        pass

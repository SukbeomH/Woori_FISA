import os
import pandas as pd
import streamlit as st
import requests
import geopy.distance  # conda install geopy -y
import dotenv

# .env 파일을 읽어서 환경변수로 설정
dotenv.load_dotenv()

url = f'http://openapi.seoul.go.kr:8088/{os.getenv("OPEN_API_KEY")}/json/bikeStationMaster/1/1000/'


def createPage():

    res = requests.get(url, timeout=10)
    res.encoding = "utf-8"
    data = res.json()  # json의 dict화

    # 필요한 데이터 추출
    bike_data = data["bikeStationMaster"]["row"]

    # 데이터프레임 생성
    df = pd.DataFrame(bike_data)

    # Streamlit 앱 설정
    # st.title('대여소 간 거리 계산이 필요하신가요?')
    new_title = '<p style="font-family:sans-serif; color:#42208C; font-size: 35px;"><strong>대여소 간 거리 계산이 필요하신가요?</strong></p>'
    st.markdown(new_title, unsafe_allow_html=True)

    # 현재/ 도착위치
    startloc = st.text_input("현재 위치를 입력하세요.")
    arrivalloc = st.text_input("도착 위치를 입력하세요.")

    if "filtered_df" not in st.session_state:
        st.session_state.filtered_df = pd.DataFrame()
    if "filtered_df2" not in st.session_state:
        st.session_state.filtered_df2 = pd.DataFrame()

    def filter_data():
        st.session_state.filtered_df = df[df["ADDR1"].str.contains(startloc)]
        st.session_state.filtered_df2 = df[df["ADDR1"].str.contains(arrivalloc)]

        # 유효한 좌표만 남기기 (위도와 경도가 0이 아닌 값)
        st.session_state.filtered_df = st.session_state.filtered_df[
            (st.session_state.filtered_df["LAT"].astype(float) != 0)
            & (st.session_state.filtered_df["LOT"].astype(float) != 0)
        ]
        st.session_state.filtered_df2 = st.session_state.filtered_df2[
            (st.session_state.filtered_df2["LAT"].astype(float) != 0)
            & (st.session_state.filtered_df2["LOT"].astype(float) != 0)
        ]

        st.session_state.filtered_df["LAT"] = st.session_state.filtered_df[
            "LAT"
        ].astype(float)
        st.session_state.filtered_df["LOT"] = st.session_state.filtered_df[
            "LOT"
        ].astype(float)

        st.session_state.filtered_df2["LAT"] = st.session_state.filtered_df2[
            "LAT"
        ].astype(float)
        st.session_state.filtered_df2["LOT"] = st.session_state.filtered_df2[
            "LOT"
        ].astype(float)

    if st.button("조회"):
        filter_data()

    if (
        not st.session_state.filtered_df.empty
        and not st.session_state.filtered_df2.empty
    ):
        # st.write(f"'{startloc}' 주변 대여소")
        # st.dataframe(st.session_state.filtered_df)

        # st.write(f"'{arrivalloc}' 주변 대여소")
        # st.dataframe(st.session_state.filtered_df2)

        start_station = st.selectbox(
            "출발 대여소를 선택하세요", st.session_state.filtered_df["ADDR1"]
        )
        end_station = st.selectbox(
            "도착 대여소를 선택하세요", st.session_state.filtered_df2["ADDR1"]
        )

        start_lat = st.session_state.filtered_df[
            st.session_state.filtered_df["ADDR1"] == start_station
        ].iloc[0]["LAT"]
        start_lon = st.session_state.filtered_df[
            st.session_state.filtered_df["ADDR1"] == start_station
        ].iloc[0]["LOT"]

        end_lat = st.session_state.filtered_df2[
            st.session_state.filtered_df2["ADDR1"] == end_station
        ].iloc[0]["LAT"]
        end_lon = st.session_state.filtered_df2[
            st.session_state.filtered_df2["ADDR1"] == end_station
        ].iloc[0]["LOT"]

        # 두 지점의 위도, 경도를 입력받아 거리를 계산합니다.
        def get_distance(lat1: float, lon1: float, lat2: float, lon2: float) -> float:
            """두 지점의 위도, 경도를 입력받아 거리를 계산합니다.

            Args:
                lat1 (float): 지점1 위도
                lon1 (float): 지점1 경도
                lat2 (float): 지점2 위도
                lon2 (float): 지점2 경도

            Returns:
                float: 두 지점 사이의 거리 (단위: km)
            """
            coords_1 = (lat1, lon1)
            coords_2 = (lat2, lon2)

            return geopy.distance.geodesic(coords_1, coords_2).km

        if st.button("거리 계산"):
            loc = get_distance(start_lat, start_lon, end_lat, end_lon)
            st.write(f"출발지와 도착지 사이의 거리는 {loc:.2f} km 입니다.")
    else:
        # st.write("구 이름을 입력하세요.")
        pass

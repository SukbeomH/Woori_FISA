import pandas as pd
import streamlit as st
import requests
import pydeck as pdk

url = "http://openapi.seoul.go.kr:8088/4246436f506768743130386a71417977/json/bikeStationMaster/1/1000/"

response = requests.get(url)
response.encoding = "utf-8"
data = response.json()  # json의 dict화

# 필요한 데이터 추출
bike_data = data["bikeStationMaster"]["row"]

# 데이터프레임 생성
df = pd.DataFrame(bike_data)

# Streamlit 앱 설정
st.title("서울특별시 자전거 대여소 정보")
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
    st.write("구 이름을 입력하세요.")


import geopy.distance  # conda install geopy -y


# 두 지점의 위도, 경도를 입력받아 거리를 계산합니다.
def get_distance(lat1, lon1, lat2, lon2):
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

    return geopy.distance.geodesic(coords_1, coords_2).m


import os


# 주소를 받아 위도 경도로 변환하는 함수
def convert_address_to_lat_lon(address):
    """주소를 받아 위도 경도로 변환하는 함수

    Args:
        address (str): 주소

    Returns:
        tuple: (위도, 경도)
    """
    apiurl = "https://api.vworld.kr/req/address?"
    params = {
        "service": "address",
        "request": "getcoord",
        "address": {address},
        "format": "json",
        "type": "PARCEL",
        "key": os.getenv("VWORLD_API_KEY"),
    }
    return requests.get(apiurl, params=params).json()


print(convert_address_to_lat_lon("마포구 상암동 1605"))

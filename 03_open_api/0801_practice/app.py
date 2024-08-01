import os
import requests
import dotenv
import pandas as pd
import geopy.distance  # conda install geopy -y
import streamlit as st
import pydeck as pdk

# .env 파일을 읽어서 환경변수로 설정
dotenv.load_dotenv()


# 공공자전거 따릉이 대여소 정보 조회
def get_bike_station_data(start_num: int, end_num: int) -> dict:
    """시작 번호와 끝 번호 사이의 공공자전거 따릉이 대여소 정보를 조회합니다.

    Args:
        start_num (INT): 시작 번호
        end_num (INT): 끝 번호

    Returns:
        json: 공공자전거 따릉이 대여소 정보(대여소_ID, 주소1, 주소2, 위도, 경도)
    """
    url = f'http://openapi.seoul.go.kr:8088/{os.getenv("OPEN_API_KEY2")}/json/bikeStationMaster/{start_num}/{end_num}/'
    response = requests.get(url)
    return response.json()


# csv 파일에 추가
def validate_to_csv(data_: dict, file_path: str) -> None:
    """데이터를 csv 파일에 추가합니다.

    Args:
            data (json): 추가할 데이터
            file_path (str): 파일 경로
    """
    # 데이터프레임 생성
    df = pd.DataFrame(data_["bikeStationMaster"]["row"])

    # 데이터프레임에서 위도 경도가 0인 데이터 제거
    df = df[(df["LAT"].astype(float) != 0) & (df["LOT"].astype(float) != 0)]

    # csv 파일에 추가
    # 파일이 없으면 생성, 있으면 삭제 후 생성
    if not os.path.exists(file_path):
        df.to_csv(file_path, index=False)
    else:
        df.to_csv(file_path, mode="a", header=False, index=False)
    return


# start_num = 1 부터 end_num = 3300 까지의 정보 300개씩 조회
def get_all_bike_station_data() -> None:
    start_num = 1
    end_num = 300
    file_path = "./bike_station_info.csv"

    while end_num < 3300:
        start_num += 300
        end_num += 300
        validate_to_csv(get_bike_station_data(start_num, end_num), file_path)
    return


# 두 지점의 위도, 경도를 입력받아 거리를 계산합니다.
def get_distance(lat1: float, lon1: float, lat2: float, lon2: float) -> float:
    """두 지점의 위도, 경도를 입력받아 거리를 계산합니다.

    Args:
        lat1 (float): 지점1 위도
        lon1 (float): 지점1 경도
        lat2 (float): 지점2 위도
        lon2 (float): 지점2 경도

    Returns:
        float: 두 지점 사이의 거리 (단위: m)
    """
    coords_1 = (float(lat1), float(lon1))
    coords_2 = (float(lat2), float(lon2))

    return geopy.distance.geodesic(coords_1, coords_2).m


# 주소를 받아 위도 경도로 변환하는 함수
def convert_address_to_lat_lon(address: str) -> tuple:
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
        "type": "ROAD",
        "key": os.getenv("VWORLD_API_KEY"),
    }
    res = requests.get(apiurl, params=params)
    return tuple(res.json()["response"]["result"]["point"])


# 내 위치와 가장 가까운 따릉이 대여소 정보 조회
def closest_station_info(lat: float, lon: float) -> dict:
    """내 위치와 가장 가까운 따릉이 대여소 정보를 조회합니다.

    Args:
            lat (float): 내 위치 위도
            lon (float): 내 위치 경도

    Returns:
            json: 가장 가까운 따릉이 대여소 정보(대여소_ID, 주소1, 주소2, 위도, 경도, 거리)
    """
    # csv 파일 읽기
    df = pd.read_csv("./bike_station_info.csv")

    # # 각 대여소와의 거리 계산
    df["distance"] = df.apply(
        lambda x: get_distance(lat, lon, x["LAT"], x["LOT"]),
        axis=1,
    )

    # 가장 가까운 대여소 정보 조회
    closest_station = df.loc[df["distance"].idxmin()]

    return closest_station.to_dict()


# DataFrame의 열을 순회하며 검증
def check_column(df: pd.DataFrame) -> None:
    """DataFrame의 열을 순회하며 검증합니다.

    Args:
        df (pd.DataFrame): DataFrame
    """
    for col in df.columns:
        print(f"Column: {col}")
        print(df[col].head())
    return


# 모든 따릉이 대여소 정보 조회
get_all_bike_station_data()

# 변수 초기화
start_lat, start_lon, end_lat, end_lon = None, None, None, None
start_station_info, end_station_info = {}, {}

# Try Except 구문으로 에러 처리
try:
    # Streamlit Input으로 출발지 주소를 입력받아 위도 경도로 변환
    st.write("출발지 주소를 도로명 주소로 입력하세요.")
    start_address = st.text_input("출발지 주소")
    if start_address:
        start_lat, start_lon = convert_address_to_lat_lon(start_address)

    # Streamlit Input으로 도착지 주소를 입력받아 위도 경도로 변환
    st.write("도착지 주소를 도로명 주소로 입력하세요.")
    end_address = st.text_input("도착지 주소")
    if end_address:
        end_lat, end_lon = convert_address_to_lat_lon(end_address)

    # 각 위치와 가장 가까운 따릉이 대여소 정보 조회
    if start_lat and start_lon:
        start_station_info = closest_station_info(start_lat, start_lon)
    if end_lat and end_lon:
        end_station_info = closest_station_info(end_lat, end_lon)

    if start_station_info and end_station_info:
        st.write(
            f"출발지와 가장 가까운 따릉이 대여소는 {start_station_info['STATION_NAME']} 입니다."
        )
        st.write(
            f"도착지와 가장 가까운 따릉이 대여소는 {end_station_info['STATION_NAME']} 입니다."
        )
        # Streamlit Button을 누르면 출발지와 도착지 사이의 거리를 계산하여 출력
        if st.button("거리 계산"):
            total_distance = get_distance(start_lat, start_lon, end_lat, end_lon)
            st.write(f"출발지와 도착지 사이의 거리는 {total_distance:.2f}m 입니다.")

        # 지도에서 출발지, 도착지, 가장 가까운 따릉이 대여소 위치를 표시
        if st.button("가까운 대여소 찾기"):
            # 지도에 표시할 데이터
            data = {
                "start": {
                    "LAT": start_lat,
                    "LON": start_lon,
                    "NAME": "출발지",
                },
                "end": {
                    "LAT": end_lat,
                    "LON": end_lon,
                    "NAME": "도착지",
                },
                "start_station": {
                    "LAT": start_station_info["LAT"],
                    "LON": start_station_info["LOT"],
                    "NAME": start_station_info["STATION_NAME"],
                },
                "end_station": {
                    "LAT": end_station_info["LAT"],
                    "LON": end_station_info["LOT"],
                    "NAME": end_station_info["STATION_NAME"],
                },
            }

            # 지도 표시
            st.pydeck_chart(
                pdk.Deck(
                    map_style="mapbox://styles/mapbox/light-v9",
                    initial_view_state=pdk.ViewState(
                        latitude=start_lat,
                        longitude=start_lon,
                        zoom=12,
                        pitch=50,
                    ),
                    layers=[
                        pdk.Layer(
                            "ScatterplotLayer",
                            data=pd.DataFrame([data["start"]]),
                            get_position=["LON", "LAT"],
                            get_color="[200, 30, 0, 160]",
                            get_radius=200,
                        ),
                        pdk.Layer(
                            "ScatterplotLayer",
                            data=pd.DataFrame([data["end"]]),
                            get_position=["LON", "LAT"],
                            get_color="[30, 0, 200, 160]",
                            get_radius=200,
                        ),
                        pdk.Layer(
                            "ScatterplotLayer",
                            data=pd.DataFrame([data["start_station"]]),
                            get_position=["LON", "LAT"],
                            get_color="[0, 200, 30, 160]",
                            get_radius=200,
                        ),
                        pdk.Layer(
                            "ScatterplotLayer",
                            data=pd.DataFrame([data["end_station"]]),
                            get_position=["LON", "LAT"],
                            get_color="[200, 30, 0, 160]",
                            get_radius=200,
                        ),
                    ],
                )
            )
except Exception as e:
    st.write("에러가 발생했습니다.")
    st.write(e)

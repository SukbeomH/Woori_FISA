import os
import requests
import dotenv
import pandas as pd
import geopy.distance  # conda install geopy -y

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
    url = f'http://openapi.seoul.go.kr:8088/{os.getenv("OPEN_API_KEY")}/json/bikeStationMaster/{start_num}/{end_num}/'
    response = requests.get(url, timeout=10)
    return response.json()


# csv 파일에 추가
def append_to_csv(data: dict, file_path: str) -> None:
    """데이터를 csv 파일에 추가합니다.

    Args:
            data (json): 추가할 데이터
            file_path (str): 파일 경로
    """
    # 데이터프레임 생성
    df = pd.DataFrame(data["bikeStationMaster"]["row"])

    # csv에 저장, 파일이 없으면 생성
    if not os.path.exists(file_path):
        df.to_csv(file_path, index=False)
    else:
        # 있으면 파일 삭제
        os.remove(file_path)
        df.to_csv(file_path, index=False)


# start_num = 1 부터 end_num = 3300 까지의 정보 100개씩 조회
def get_all_bike_station_data() -> None:
    start_num = 1
    end_num = 100
    file_path = "./bike_station_info.csv"

    while start_num <= 3300:
        data = get_bike_station_data(start_num, end_num)
        append_to_csv(data, file_path)
        start_num += 100
        end_num += 100


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
        "type": "PARCEL",
        "key": os.getenv("VWORLD_API_KEY"),
    }
    res = requests.get(apiurl, params=params, timeout=10)
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

    # 거리 계산
    df["distance"] = df.apply(
        lambda x: get_distance(lat, lon, x["LAT"], x["LOT"]), axis=1
    )

    # 가장 가까운 대여소 정보 조회
    closest_station = df.loc[df["distance"].idxmin()]

    return closest_station.to_dict()


get_all_bike_station_data()
print(closest_station_info(37.5666103, 126.9783882))

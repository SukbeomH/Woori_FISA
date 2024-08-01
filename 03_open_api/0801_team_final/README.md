### Members

- [@eunchaipark](https://github.com/eunchaipark)
- [@awesome98](https://github.com/awesome98)
- [@yeji63](https://github.com/yeji63)
- [@dongmiii](https://github.com/dongmiii)
- [@eunhyea](https://github.com/eunhyea)
- [@SukbeomH](https://github.com/SukbeomH)

# streamlit_practice :: 따릉이 데이터 시각화

- `streamlit`을 활용하여 따릉이 데이터를 시각화
- `pandas` 데이터 전처리, 데이터프레임 생성
- `pydeck` 지도 시각화
- `geopy` 거리 계산, 좌표 정보 활용
- `requests` API 요청

## Example Page

[streamlit_cycle](https://practice001.streamlit.app/)

## 따릉이 데이터 시각화
- 따릉이 데이터를 활용하여 시각화를 진행합니다.
- 데이터는 **서울 열린 데이터 광장**에서 제공하는 따릉이 데이터를 활용합니다.

---

## 주요 기능
- 따릉이 대여소의 **위치를 지도에 시각화**합니다.
- 사용자가 입력한 위치로부터 **가장 가까운** 따릉이 대여소를 찾아줍니다.
- Streamlit의 **세션 관리**로 인한 새로고침 시 정보 증발을 방지하고, 사용자가 입력한 위치 정보를 유지합니다.
- 없어진 대여소를 제외하고 전처리를 진행합니다.
- 중복 API 요청을 방지하기 위해 **로컬에 데이터를 저장**합니다.

## 개선 사항
- **다크모드 지원**
  - 사이드바의 다크모드 시 글자가 보이지 않는 현상을 개선합니다.
- 대여소 **정보 표시**
  - 대여소 정보를 마커 클릭 시 표시하도록 개선합니다.
  - 자전거 실시간 현황을 표시하도록 개선합니다.
- 기존 서비스를 참고하여 추가적인 기능을 개발합니다.
  - 대여소 **정보를 표시**하는 기능을 추가합니다.
  - 대여 빈도를 통한 **혼잡도, 인기도 등을 시각화**합니다.

---

## 데이터 소개

- 데이터 주소 : [서울 열린 데이터 광장](https://data.seoul.go.kr/dataList/OA-21235/S/1/datasetView.do)
- 따릉이 데이터는 서울시 자전거 대여소별 대여정보를 제공합니다.
- 폐쇄된 대여소의 경우, 좌표 정보가 제공되지 않으므로 (0, 0)으로 표기되어 있습니다.
  - 이러한 대여소는 전처리 과정에서 필터링하여 제외하였습니다.

## 시각화 및 활용
- pydeck을 활용하여 지도 시각화를 진행합니다.
- 대여소의 좌표정보를 이용해서 사용자가 기입한 위치로 부터 가까운 대여소를 찾아주는 기능을 제공합니다.
  - 좌표 간의 거리 계산의 경우, geopy의 geodesic 함수를 활용하였습니다.

## 세팅 방법
```bash
$ git clone {repository} {directory}
$ pip install -r requirements.txt
$ streamlit run main.py
```

## 참고
- [서울 열린 데이터 광장](https://data.seoul.go.kr/dataList/OA-21235/S/1/datasetView.do)
- [pydeck](https://deckgl.readthedocs.io/en/latest/)
- [geopy](https://geopy.readthedocs.io/en/stable/)
- [requests](https://docs.python-requests.org/en/master/)



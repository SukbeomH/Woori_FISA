## Jupyter Notebook in Docker Container
- 1.55 GB 정도의 용량을 차지함
- 한글 폰트 설정
- 한글이 깨지지 않도록 설정 (matplotlib, konlpy 설치)
- sample.ipynb 파일을 실행하여 한글이 잘 나오는지 확인
- mecab (Korean tokenizer) 의 경우 설치가 안되어 있음
  - mecab 설치는 [konlpy](https://konlpy.org/en/latest/install/) 참고

## Execute
```bash
docker build -t jupyter_kor -f dockerfile .
docker images
docker run --name jupyter_kor -p 8888:8888 jupyter_kor
```

## Dockerfile

```dockerfile
FROM quay.io/jupyter/base-notebook:notebook-7.2.1
EXPOSE 8888

# change active user to root
USER root 

# install fonts-nanum
RUN  sed -i 's/archive.ubuntu.com/ftp.daumkakao.com/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y fonts-nanum*
# install g++, openjdk-7, curl
RUN  apt-get install -y g++ openjdk-7* curl &&\
    apt-get clean

# # Setup mecab (Korean tokenizer)
# RUN bash <(curl -s https://raw.githubusercontent.com/konlpy/konlpy/master/scripts/mecab.sh)

# install fontconfig (for fc-cache)
RUN apt-get install -y fontconfig
# update font cache and remove cache
RUN fc-cache -fv && \
    rm -fr ~/.cache/matplotlib

# install matplotlib, konlpy
RUN pip install --upgrade pip && \
  pip install matplotlib konlpy

# set font
COPY font.py /home/jovyan/work/font.py
RUN python /home/jovyan/work/font.py
RUN chmod 777 /home/jovyan/work/font.py

# Copy the sample.ipynb file
COPY sample.ipynb /home/jovyan/work/sample.ipynb
RUN chmod 777 /home/jovyan/work/sample.ipynb

# Set the working directory
WORKDIR /home/jovyan/work

# change active user to jovyan
USER jovyan

# CMD ["jupyter", "notebook"]
CMD ["jupyter", "lab"]
```

## font.py

```python
import matplotlib.pyplot as plt
import matplotlib as mpl
from matplotlib import rc, font_manager

font_fname = "/usr/share/fonts/truetype/nanum/NanumGothic.ttf"
prop = font_manager.FontProperties(fname=font_fname)
mpl.rcParams["font.family"] = "NanumGothic"
mpl.rcParams["axes.unicode_minus"] = False

font_list = font_manager.findSystemFonts(fontpaths=None, fontext="ttf")
# font_list
```

## sample.ipynb

```python
# 한글 되는지 확인하는 코드

import matplotlib.pyplot as plt
from matplotlib import font_manager, rc

font_path = (
    "/usr/share/fonts/truetype/nanum/NanumGothic.ttf"  # 시스템에 설치된 폰트 경로
)
font = font_manager.FontProperties(fname=font_path).get_name()
rc("font", family=font)

# 데이터 생성
x = [1, 2, 3, 4, 5]
y = [1, 4, 9, 16, 25]

# 그래프 그리기
plt.plot(x, y)
plt.title("한글 제목")
plt.xlabel("X축")
plt.ylabel("Y축")
plt.show()
```


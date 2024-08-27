# blog/urls.py

from django.urls import path
from . import views

urlpatterns = [
    # blog 앱 내부의 경로를 지정할 부분
    path('', views.index), # 없는 경로를 호출하고 있음
    path('post-list', views.PostList.as_view())
]
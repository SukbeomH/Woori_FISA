from django.urls import path
from . import views

urlpatterns = [
    # blog 앱 내부의 경로를 지정할 부분
    path('login/', views.user_login), # localhost:8000/account/login/ 경로, 경로를 호출하면 실행할 함수의 위치
]
from django.urls import path
# from . import views
from django.contrib.auth import views as auth_views

app_name = 'account'

urlpatterns = [
    # blog 앱 내부의 경로를 지정할 부분
    # path('login/', views.user_login), # localhost:8000/account/login/ 경로, 경로를 호출하면 실행할 함수의 위치
    
    path('login/', auth_views.LoginView.as_view(), name='login'),
    path('logout/', auth_views.LogoutView.as_view(), name='logout'),
]
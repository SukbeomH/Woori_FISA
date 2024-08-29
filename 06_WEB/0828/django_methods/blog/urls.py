from django.urls import path
from . import views

app_name = 'blog_app'

urlpatterns = [
    # blog 앱 내부의 경로를 지정할 부분
    # path('', views.index), # localhost:8000/blog 경로, 경로를 호출하면 실행할 함수의 위치
    path('post-list', views.PostList.as_view(), name='post_list'),
    path('', views.about_me, name='about_me'),
    path('<int:pk>', views.PostDetail.as_view()), # <자료형:필드명> 
    path('create-post/', views.PostCreate.as_view())
]
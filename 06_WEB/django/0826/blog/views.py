from django.shortcuts import render
from django.views.generic import ListView
from .models import Post

# Create your views here.
def index(request):
    posts = Post.objects.all() # 1. 쿼리로 데이터를 모두 가져옵니다
    # 가져온 데이터는 어디에 뿌려야 하나요? Templates로 보내야겠죠
    return render(
        request,
        'blog/index.html',
        {
            'posts':posts,
        }
    )
    
class PostList(ListView):   # post_list.html, post-list
    model = Post 
    template_name = 'blog/post_list.html' 
    ordering = '-pk' 
    context_object_name = 'posts'
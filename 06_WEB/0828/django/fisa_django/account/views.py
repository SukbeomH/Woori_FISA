from django.http import HttpResponse
from django.shortcuts import render
from .forms import LoginForm
from django.contrib.auth import authenticate, login

# Create your views here.
def user_login(request):
    # 요청의 방법 확인 POST 
    if request.methods == "POST":
        # 폼에서 데이터를 받아서 유효성 검사
        form = LoginForm(request.POST)
        if form.is_valid():
            # 비우고
            cleaned = form.cleaned_data
            # 입력받은 username, password를 DB와 일치하는지 확인
            user = authenticate(request, username=cleaned['username'], password=cleaned['password'])
            if user is not None:
                login(request=user)
                if user.is_active:
                    # 입력받은 user가 일치하면 response를 전달. 로그인 되셨습니다!
                    response = HttpResponse('로그인 되셨습니다!')
                
                    return response
                else:
                    response = HttpResponse('인증불가')
                
                    return response
                    
            else:
                # user가 None이면 사용불가
                response = HttpResponse('사용불가')
                
                return response
                pass
        else:
            # user가 일치하지 않으면 잘못입력하셨습니다.
            response = HttpResponse('잘못입력하셨습니다.')
                
            return response
    else:
        form = LoginForm()
        
    return render(request, 'account/login.html', {'form': form})
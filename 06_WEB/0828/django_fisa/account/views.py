from django.shortcuts import render
from .forms import LoginForm
from django.contrib.auth import authenticate, login
from django.http import HttpResponse
# Create your views here.

def user_login(request): # 주소줄로 요청을 받아서 일할거야
    # 요청의 방법 확인 POST 
    if request.method == 'POST':
        # 폼에서 데이터를 받아서 유효성 검사
        form = LoginForm(request.POST)
        if form.is_valid():
            # 비우고
            cd = form.cleaned_data 
            # 입력받은 username, password를 DB와 일치하는지 확인
            user = authenticate(request, username=cd['username'], password=cd['password'])
            if user is not None:
                if user.is_active:
                    login(request, user)

                    response = HttpResponse('인증 성공ㄴ') # 응답 객체 생성
                    # 입력받은 user가 일치하면 response를 전달 로그인 되셨습니다!
                    return response
                else:
                    # is_active가 False라서
                    return HttpResponse('사용 불가')
            else:
                # 없는 사용자 정보라서 failed
                return HttpResponse('로그인 정보가 틀립니다.')

        # user가 일치하지 않으면 잘못입력하셨습니다.
    else:
        form = LoginForm()
    return render(request, 'account/login.html', {'form': form})
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<h1>My Board </h1> 
<!--  login & logout 처리 -->
<div>
<!-- 로그인 창 생성 -->
  <c:if test = "${empty loginUser }">
    <c:if test ="${empty loginmsg }"></c:if>
      ${loginmsg }
    <form method = "post" action="/user/login">
      <input type = "text" name = "id"> 
      <input type = "password" name = "pass">
      <input type = "submit">
    </form>
    <a href="/user/join"><button>회원가입</button></a>

  </c:if>
  
<!-- 로그아웃 창 생성 -->
  <c:if test="${!empty loginUser }">
    ${loginUser.name }님 반갑습니다. <a href= "/user/logout" >로그아웃</a>
  <a href="/board/regist">[게시글 등록]</a>
    </c:if>
  <a href="/board/list">[게시글 목록]</a>
</div>

<hr>
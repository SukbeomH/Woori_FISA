<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="/WEB-INF/view/include/header.jsp"%>
	<h1>회원 가입</h1>
	<!-- 사용자로 부터 정보를 받아야함 form 필요 -->
	<form action="/user/join" method="post">
		<input type="text" name="id" placeholder="사용자 ID">
		<c:if test="${!empty msg }">
			${msg }
		</c:if>
		<br>
		<input type="text" name="name" placeholder="사용자 이름">
		<br>
		<input type="password" name="pass" placeholder="사용자 비번">
		<br>
		<input type="text" name="grade" placeholder="사용자 등급" value="GUEST">
		<br>
		<input type="submit" value="회원 가입">
		<!-- 이 값들이 서버로 날아오면 url이 유저의 조인이고 포스트인곳으로 날아간다 -->
	</form>
</body>
</html>
<!--  다음부턴 사용자의 정보를 받아서 회원가입 처리를 해줘야함 join.jsp로 ㄱㄱ -->
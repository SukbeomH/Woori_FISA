<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
	<%@include file = "/WEB-INF/view/include/header.jsp" %>
	<h1>게시글 등록</h1>
	<form method="post"	action ="/board/regist" enctype="multipart/form-data">
		<label>작성자:<input type="text" value="${loginUser.id }" readonly= "readonly" name = "user_Id"></label><br>
		<label>글제목:<input type="text" name = "title"></label><br>
		<textarea rows="10" cols="100" name="content"></textarea><br>
		<input type="file" name="image"><br>
		<input type="submit" value="등록">
		</form>
</body>
</html>
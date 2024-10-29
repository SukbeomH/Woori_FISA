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
	<h1>글목록</h1>
	${pageInfo }
	<%-- html 주석은 jsp EL 태그를 막을 수 없습니다 --%>
	<%-- ${pageInfo.title }  --%>  



	<%-- c:forEach --%>

	<table>
		<tr><td>no</td><td>title</td><td>writer</td></tr>
		<c:forEach items="${pageInfo.content }" var="board">
			<tr>
				<td><a href="/board/detail?no=${board.no }">${board.no }</a></td>
				<td>${board.title}</td>
				<td>${board.user.name }</td>
			</tr>
		</c:forEach>

	</table>
	<form action="/board/list"method="get">
		<input type="text" name="page" value="${pageInfo.number +1 }">/${pageInfo.totalPages }
		<input type="submit" value="이동">
	</form>
	
</body>
</html>
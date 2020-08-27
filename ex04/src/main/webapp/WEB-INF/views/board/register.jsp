<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Register</h1>

<form  action="/board/register" method="post">
	<label>Title</label><br>
	<input type="text" name="title"><br>
	
	<label>Text area</label><br>
	<textarea rows="3" name="content"></textarea><br>
	
	<label>Writer</label><br>
	<input name="writer"><br>
	
	<button type="submit">Submit button</button>
	<button type="reset">Reset button</button><br>
</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<h1>Modify Page</h1>

<form role="form" action="/board/modify" method="post">
	<!-- p319 -->
	<input type='hidden' name='pageNum' value='${cri.pageNum }'>
	<input type='hidden' name='amount' value='${cri.amount }'>
	<input type='hidden' name='type' value='${cri.type }'>
	<input type='hidden' name='keyword' value='${cri.keyword }'>
	
	<label>Bno</label><br>
	<input type="text" name="bno" value='${board.bno}' readonly=readonly"><br>
	
	<label>Title</label><br>
	<input type="text" name="title" value='<c:out value="${board.title}"/>' ><br>
	
	<label>Text area</label><br>
	<textarea rows="3" name="content"  ><c:out value='${board.content}' /> </textarea><br>
	
	<label>Writer</label><br>
	<input name="writer" value='<c:out value="${board.title}"/>'  ><br>
	
	<label>RegDate</label><br>
	<input name="regDate" value='<fmt:formatDate pattern="yyyy/MM/dd"  value="${board.regdate}"/>'  readonly="readonly"><br>
	
	<label>Update Date</label><br>
	<input name="updateDate" value='<fmt:formatDate pattern="yyyy/MM/dd"  value="${board.updateDate}"/>'  readonly="readonly"><br>
	
	<button type="submit" data-oper="modify">Modify</button>
	<button type="submit" data-oper="remove">Remove</button><br>
	<button type="submit" data-oper="list">List</button><br>
</form>

<script>
$(document).ready(function(){
	
	var formObj = $("form");
	
	$('button').on("click", function(e){
		e.preventDefault();
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation === 'remove'){
			formObj.attr("action", "/board/remove");
		} else if(operation === 'list'){
			formObj.attr("action", "/board/list").attr("method", "get");
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			var typeTag = $("input[name='type']").clone();
			
			formObj.empty(); // form태그 안에 있는 input태그들이 파라미터로 다 넘어가지 않도록 비운다.
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
		}
		formObj.submit();
	});
});
</script>
</body>
</html>
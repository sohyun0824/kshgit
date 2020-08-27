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
<script src="/resources/js/reply.js"></script>
</head>
<body>
<h1>Register</h1>

<label>Bno</label><br>
<input type="text" name="bno" value='${board.bno}' readonly=readonly"><br>

<label>Title</label><br>
<input type="text" name="title" value='<c:out value="${board.title}"/>' readonly=readonly"><br>

<label>Text area</label><br>
<textarea rows="3" name="content"  readonly=readonly"><c:out value='${board.content}' /> </textarea><br>

<label>Writer</label><br>
<input name="writer" value='<c:out value="${board.title}"/>'  readonly=readonly"><br>

<%-- <button type="button" onclick="location.href='/board/modify?bno=<c:out value="${board.bno }"/>'">Modify button</button> --%>
<button type="button" data-oper='modify'>Modify button</button>
<button type="button" data-oper='list'>List button</button><br>

<form id="operForm" action="/board/modify" method="get">
	<input type="hidden" id="bno" name="bno" value='${board.bno}'>
	<input type="hidden" name="pageNum" value='${cri.pageNum}'>
	<input type="hidden" name="amount" value='${cri.amount}'>
	<input type="hidden" name="keyword" value='${cri.keyword}'>
	<input type="hidden" name="type" value='${cri.type}'>
</form>

<!-- p265 -->
<script>
$(document).ready(function(){
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action", "/board/modify").submit();
	})
	
	$("button[data-oper='list']").on("click", function(e){
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list");
		operForm.submit();
	})
	
})
</script>
</body>
</html>
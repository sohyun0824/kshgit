<%@page import="java.net.URLEncoder"%>
<%@page import="shop.member.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	
	MemberDTO dto = (MemberDTO)request.getAttribute("dto");
	String return_url = (String)request.getAttribute("return_url");
	//System.out.println(return_url);

	if(dto != null){
		double percent = 0;
		
		// 일반회원 0.5  프렌즈 1  화이트 3  라벤더 5  퍼플 7  더퍼플 7
		switch(dto.getGrade()){
		case "일반":
			percent = 0.005;
			break;
		case "프렌즈":
			percent = 0.01;
			break;
		case "화이트":
			percent = 0.03;
			break;
		case "라벤더":
			percent = 0.05;
			break;
		case "퍼플": case "더퍼플":
			percent = 0.07;
			break;
		}
		
		session.setAttribute("percent", percent);
		session.setAttribute("member", dto);
		
		//response.sendRedirect(return_url);			// redirect는 파라미터에 있는 한글이 깨짐... URLEncoder.encode()로 하려면 파라미터만 따로 빼서 해야함
		%>
		<script>
			location.href = "<%= return_url %>";
		</script>
		<%
	} else{
		%>
		<script>
			alert("아이디 또는 비밀번호 오류입니다.");
			location.href = "../member/login.do";
		</script>
		<%
	}
%>
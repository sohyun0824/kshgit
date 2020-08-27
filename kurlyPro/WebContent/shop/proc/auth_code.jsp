<%@page import="com.util.JdbcUtil"%>
<%@page import="com.util.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");

	String mode = request.getParameter("mode");
	String mobile = request.getParameter("mobile");
	
	// 휴대폰번호 뒷번호를 인증번호로,,?
	String auth_code = mobile.substring(9);
	JSONObject data = new JSONObject();
	String message = null;
	
	// DB에 이미 등록된 핸드폰 번호면 1, 새로운 번호면 0
	int result = 0;
	
	String sql = "select count(*) from member where tel = ? ";
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try(Connection conn = ConnectionProvider.getConnection()){
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, mobile);
		rs = pstmt.executeQuery();
		if(rs.next()){
			result = rs.getInt(1);
		}
	} catch(Exception e){
		e.printStackTrace();
	} finally{
		JdbcUtil.close(rs);
		JdbcUtil.close(pstmt);
	}
	
	if(mode.equalsIgnoreCase("get_auth_code")){	// 인증번호 받기 요청
		if(result == 1){
			message = "이미 회원가입된 번호입니다. 입력한 번호를 확인해 주세요.\n회원가입을 하신 적이 없다면 고객센터로 문의해 주세요.";
		} else{
			message = "인증번호가 생성되었습니다.\n인증번호: " + auth_code;			
		}
		data.put("message", message);
		data.put("count_time", 180);
		data.put("result", result);
	} else if(mode.equalsIgnoreCase("check_auth_code")){	// 인증번호 확인 요청
		String pAuth_code = request.getParameter("auth_code");
		if(!pAuth_code.equals(auth_code)){
			message = "인증번호를 다시 확인해주세요.";
			result = 1;
		}
		data.put("message", message);
		data.put("result", result);
	}
		
%>
<%= data %>
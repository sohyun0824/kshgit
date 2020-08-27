<%@page import="com.util.JdbcUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.util.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");

	String inputID = request.getParameter("inputID");
	JSONObject data = new JSONObject();
	String msg = null;
	int result = 0;
	
	// 실제 DB에 있는지 확인
	String sql = "select count(*) from member where m_id = ? ";
	//System.out.println(sql);
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try(Connection conn = ConnectionProvider.getConnection()){
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, inputID);
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
	
	if(result == 0){
		msg = "사용 가능한 아이디입니다.";
	} else{
		msg = "이미 등록된 아이디입니다.";
	}
	
	data.put("msg", msg);
	data.put("result", result);
%>
<%= data %>
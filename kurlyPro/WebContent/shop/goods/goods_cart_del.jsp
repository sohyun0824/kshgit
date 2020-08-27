<%@page import="com.util.ConnectionProvider"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.util.JdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String sql = "delete from basket where basket_no = ?";
	Connection conn = null;
	PreparedStatement pstmt = null;
	int result = -1;
	JSONObject data = null;
	
	try {
		conn = ConnectionProvider.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("basket_no"));
		result = pstmt.executeUpdate();
		data = new JSONObject();
		data.put("result", result);
	} catch (Exception e) {
		e.printStackTrace();
	}finally {
		JdbcUtil.close(pstmt);
		JdbcUtil.close(conn);
	}
%>
<%= data %>
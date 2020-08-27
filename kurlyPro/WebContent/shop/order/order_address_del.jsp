<%@page import="com.util.JdbcUtil"%>
<%@page import="com.util.ConnectionProvider"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String sql = "delete delivery_info where delivery_code= ? ";
Connection conn = null;
PreparedStatement pstmt = null;
int result = -1;
JSONObject data = null;

try {
	conn = ConnectionProvider.getConnection();
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, request.getParameter("delivery_code"));
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
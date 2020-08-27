<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.util.JdbcUtil"%>
<%@page import="java.sql.SQLException"%>
<%@page import="shop.order.model.DeliveryDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.util.ConnectionProvider"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String sql = "select * from delivery_info where delivery_code = ? ";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
JSONObject data = null;

try {
	conn = ConnectionProvider.getConnection();
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, request.getParameter("delivery_code"));
	rs = pstmt.executeQuery();
	if(rs.next()) {
		data = new JSONObject();
		data.put("delivery_code", rs.getString("delivery_code"));
		data.put("address", rs.getString("address"));
		data.put("delivery_type", rs.getString("delivery_type"));
		data.put("receiver", rs.getString("receiver"));
		data.put("receiver_tel", rs.getString("receiver_tel"));
		data.put("loc", rs.getString("loc"));
		data.put("loc_detail", rs.getString("loc_detail"));
		data.put("front_door", rs.getString("front_door"));
		data.put("entering_detail", rs.getString("entering_detail"));
		data.put("delivered_msg", rs.getString("delivered_msg"));
		data.put("m_id", rs.getString("m_id"));
		data.put("is_basic", rs.getInt("is_basic"));
	}
	
} catch (Exception e) {
	e.printStackTrace();
}finally {
	JdbcUtil.close(pstmt);
	JdbcUtil.close(conn);
}
%>
<%= data %>
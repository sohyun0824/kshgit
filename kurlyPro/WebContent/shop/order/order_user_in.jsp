<%@page import="com.util.JdbcUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.util.ConnectionProvider"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String sql = " insert into user_info (user_no, user_name, user_tel, user_email, m_id) "
		+ " values ( 'AA'||LPAD(seq_user_info.nextval,5,'0'), ?, ?, ?, ? ) ";
Connection conn = null;
PreparedStatement pstmt = null;
int result  = 0;
JSONObject data = null;

try {
	conn = ConnectionProvider.getConnection();
	pstmt =  conn.prepareStatement(sql);
	pstmt.setString(1, request.getParameter("name"));
	pstmt.setString(2, request.getParameter("tel"));
	pstmt.setString(3, request.getParameter("email"));
	pstmt.setString(4, request.getParameter("m_id"));
	
	result = pstmt.executeUpdate();
} catch (SQLException e) {
	e.printStackTrace();
}

sql = " select  'AA'||LPAD(seq_user_info.currval,5,'0') from dual";
ResultSet rs = null;
try {
	data = new JSONObject();
	pstmt =  conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	if(rs.next()) {
		data.put("user_no", rs.getString(1));
	}
} catch (SQLException e) {
	e.printStackTrace();
} finally {
	JdbcUtil.close(rs);
	JdbcUtil.close(pstmt);
}
%>
<%= data %>
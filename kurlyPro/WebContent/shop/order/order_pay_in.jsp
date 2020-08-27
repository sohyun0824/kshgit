<%@page import="com.util.JdbcUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.util.ConnectionProvider"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String sql = " insert into pay_list (pay_code, pay_amount, pay_date, del_fee, use_point, use_coupon, add_point, discount, payment_no) "
		+ " values ( 'AA'||LPAD(seq_pay_list.nextval,5,'0'), ?, sysdate, ?, ?, ?, ?, ?, ? ) ";
Connection conn = null;
PreparedStatement pstmt = null;
int result  = 0;
JSONObject data = null;

try {
	conn = ConnectionProvider.getConnection();
	pstmt =  conn.prepareStatement(sql);
	pstmt.setString(1, request.getParameter("pay_amount"));	// pay_amount 결제금액
	pstmt.setString(2, request.getParameter("del_fee"));		// del_fee 배송비
	pstmt.setString(3, request.getParameter("use_point"));	// use_point
	pstmt.setString(4, request.getParameter("use_coupon"));	// use_coupon 
	pstmt.setString(5, request.getParameter("add_point"));	// add_point
	pstmt.setString(6, request.getParameter("discount"));	// discount
	pstmt.setString(7, request.getParameter("payment_no"));	// payment_no 결제수단 번호
	
	result = pstmt.executeUpdate();
} catch (SQLException e) {
	e.printStackTrace();
}

sql = " select  'AA'||LPAD(seq_pay_list.currval,5,'0') from dual";
ResultSet rs = null;
try {
	data = new JSONObject();
	pstmt =  conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	if(rs.next()) {
		data.put("pay_code", rs.getString(1));
	}
} catch (SQLException e) {
	e.printStackTrace();
} finally {
	JdbcUtil.close(rs);
	JdbcUtil.close(pstmt);
}
%>
<%= data %>
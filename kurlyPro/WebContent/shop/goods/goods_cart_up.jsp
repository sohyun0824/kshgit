<%@page import="com.util.ConnectionProvider"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.util.JdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%

String sql = "update basket b "
		+ " set cnt=cnt+? "
		+ ", price=price+?*(select price from goods where goods_no=b.goods_no)  "
		+ " where basket_no = ?";

Connection conn = null;
PreparedStatement pstmt = null;
int result = -1;
ResultSet rs = null;
JSONObject data = null;

try {
	conn = ConnectionProvider.getConnection();
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(request.getParameter("val")));
	pstmt.setInt(2, Integer.parseInt(request.getParameter("val")));
	pstmt.setString(3, request.getParameter("basket_no"));
	result = pstmt.executeUpdate();
} catch (Exception e) {
	e.printStackTrace();
}


sql = "select cnt, price from basket where basket_no = ? ";

try {
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, request.getParameter("basket_no"));
	rs = pstmt.executeQuery();
	rs.next();
	int cnt = rs.getInt("cnt");
	int price = rs.getInt("price");
	data = new JSONObject();
	data.put("cnt", cnt);
	data.put("price", price);
} catch (Exception e) {
	e.printStackTrace();
}finally {
	JdbcUtil.close(rs);
	JdbcUtil.close(pstmt);
	JdbcUtil.close(conn);
}

%>
<%= data %>
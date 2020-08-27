<%@page import="com.util.JdbcUtil"%>
<%@page import="com.util.ConnectionProvider"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");

	String group_no = request.getParameter("group_no");

	String sql = "select * from goods where group_no = ? ";
	// goods_no, name, price, soldout, stock, group_no
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	JSONObject data = new JSONObject();
	JSONArray goodsList = null; 
	
	try{
		conn = ConnectionProvider.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, group_no);
		rs = pstmt.executeQuery();
		if(rs.next()){
			goodsList = new JSONArray();
			do{
				JSONObject goodsData = new JSONObject();
				goodsData.put("goods_no", rs.getString("goods_no"));
				goodsData.put("name", rs.getString("name"));
				goodsData.put("price", rs.getInt("price"));
				goodsData.put("soldout", rs.getInt("soldout"));
				goodsData.put("stock", rs.getInt("stock"));
				goodsList.add(goodsData);
			} while(rs.next());
		}
	} catch(Exception e){
		e.printStackTrace();
	}
	
	sql = "select name, discount from goods_group where group_no = ? ";
	
	String name = null;
	int discount = 0;
	
	try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, group_no);
		rs = pstmt.executeQuery();
		if(rs.next()){
			name = rs.getString("name");
			discount = rs.getInt("discount");
		}
	} catch(Exception e){
		e.printStackTrace();
	}
	
	JdbcUtil.close(rs);
	JdbcUtil.close(pstmt);
	JdbcUtil.close(conn);
	
	data.put("name", name);
	data.put("discount", discount);
	data.put("goodsList", goodsList);
%>
<%= data %>
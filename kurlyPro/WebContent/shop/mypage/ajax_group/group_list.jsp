<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.Array"%>
<%@ page trimDirectiveWhitespaces="true" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.util.ConnectionProvider"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String group_no = request.getParameter("group_no");
	// System.out.print(group_no);
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	JSONObject jsonData = new JSONObject();  // {} json 객체
	JSONArray jsonGoodsList = new JSONArray();   //  [] json 배열
	   
	String sql = "select gg.name gr_name, g.name g_name, g.goods_no goods_no, g.price g_price " + 
			", g.price * (100-gg.discount)*0.01 discount, g.group_no gr_no, g.soldout soldout " +
			"from goods g join goods_group gg on g.group_no = gg.group_no " +
			"where g.group_no = ?";
	
	try{
		conn = ConnectionProvider.getConnection();
	    pstmt = conn.prepareStatement(sql);
	    
	    // 전달받은 상품그룹번호 설정
	    pstmt.setString(1, group_no);
	    
	    rs = pstmt.executeQuery();
	    
	    while(rs.next()){
	    	String gr_name = rs.getString("gr_name");
	    	String g_name = rs.getString("g_name");
	    	String goods_no = rs.getString("goods_no");
	    	int g_price = rs.getInt("g_price");
	    	int discount = rs.getInt("discount");
	    	String gr_no = rs.getString("gr_no");
	    	int soldout = rs.getInt("soldout");
	    	
	    	JSONObject jsonGoods = new JSONObject();
	    	
	    	jsonGoods.put("gr_name", gr_name);
	    	jsonGoods.put("g_name", g_name);
	    	jsonGoods.put("goods_no", goods_no);
	    	jsonGoods.put("g_price", g_price);
	    	jsonGoods.put("discount", discount);
	    	jsonGoods.put("gr_no", gr_no);
	    	jsonGoods.put("soldout", soldout);
	    	
	    	jsonGoodsList.add(jsonGoods);
	    	
	    }
	    // { "goods" : [ {"gr_name" : ...}, {"g_name" : ...}, {"goods_no" : ...} ] }
	    jsonData.put("goods",jsonGoodsList );

	} catch(Exception e){
		   e.printStackTrace();
	   }finally{
		   pstmt.close();
		   rs.close();
		   conn.close();
	   }
%>

<%= jsonData %>
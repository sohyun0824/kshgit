<%@page import="com.util.JdbcUtil"%>
<%@page import="shop.main.model.ListDTO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.util.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");

	String seq = request.getParameter("seq");	// 상위카테고리 seq

	String sql = "select * " + 
			"from ( " + 
			"    select gg.group_no, name, main_img, discount, g.price " + 
			"    from goods_group gg join (select group_no, min(price) price from goods group by group_no) g on gg.group_no = g.group_no " + 
			"    where regexp_like(child_seq, ?) " + 
			") " + 
			"where rownum <= 6 ";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	JSONObject data = new JSONObject();
	JSONArray goodsList = null; 
	String pc_name = null;
	
	try{
		conn = ConnectionProvider.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, seq);
		rs = pstmt.executeQuery();
		if(rs.next()){
			goodsList = new JSONArray();
			do{
				JSONObject goodsData = new JSONObject();
				goodsData.put("group_no", rs.getString("group_no"));
				goodsData.put("name", rs.getString("name"));
				goodsData.put("main_img", rs.getString("main_img"));
				goodsData.put("discount", rs.getInt("discount"));
				goodsData.put("price", rs.getInt("price"));
				goodsList.add(goodsData);
			} while(rs.next());
		}
	} catch(Exception e){
		e.printStackTrace();
	}
		
	sql = "select * from p_category where parent_seq = ? ";
	
	try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, seq);
		rs = pstmt.executeQuery();
		if(rs.next()){
			pc_name = rs.getString("pc_name");
		}
	} catch(Exception e){
		e.printStackTrace();
	}
	
	JdbcUtil.close(rs);
	JdbcUtil.close(pstmt);
	JdbcUtil.close(conn);
	
	data.put("goodsList", goodsList);
	data.put("pc_name", pc_name);
%>
<%= data %>
<%@page import="com.util.JdbcUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.util.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="shop.member.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	MemberDTO member = (MemberDTO)session.getAttribute("member");
	String m_id = member.getM_id();
	
	String[] goods_noArr = request.getParameterValues("goods_noArr");
	int[] cntArr = new int[goods_noArr.length];
	
	JSONObject data = new JSONObject();
	int result = 0;
	
	String sql = "select count(*) from wishlist where goods_no = ? and m_id = ? ";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		conn = ConnectionProvider.getConnection();
		for(int i=0 ; i<goods_noArr.length ; i++){
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, goods_noArr[i]);
			pstmt.setString(2, m_id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				cntArr[i] = rs.getInt(1);
			}
		}
	} catch(Exception e){
		e.printStackTrace();
	}
	
	for(int i=0 ; i<cntArr.length ; i++){
		if(cntArr[i] == 0){
			sql = "insert into wishlist(seq, m_id, goods_no) values('WL'||lpad(seq_wishlist.nextval,5,'0'), ?, ?)";
			
			try{
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, m_id);
				pstmt.setString(2, goods_noArr[i]);
				result += pstmt.executeUpdate();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	
	JdbcUtil.close(rs);
	JdbcUtil.close(pstmt);
	JdbcUtil.close(conn);
	
	data.put("result", result);
	
%>
<%= data %>
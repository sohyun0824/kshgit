<%@page import="shop.member.model.MemberDTO"%>
<%@page import="com.util.ConnectionProvider"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.util.JdbcUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	//회원이 가진 상품 목록 개수 가져오기
	MemberDTO member = (MemberDTO)session.getAttribute("member");
	String m_id = member.getM_id();
	
	String sql = "select count(*) from basket where m_id = ? ";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	JSONObject data = new JSONObject();
	int cnt = 0;
	
	try{
		conn = ConnectionProvider.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, m_id);
		rs = pstmt.executeQuery();
		if(rs.next()){
			cnt = rs.getInt(1);
		}
		
	} catch(Exception e){
		e.printStackTrace();
	} finally{
		JdbcUtil.close(rs);
		JdbcUtil.close(pstmt);
		JdbcUtil.close(conn);
	}

	data.put("cnt", cnt);
%>
<%= data %>
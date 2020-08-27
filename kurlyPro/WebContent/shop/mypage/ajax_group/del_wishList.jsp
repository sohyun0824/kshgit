<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.util.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	int result;
	JSONObject data = null;
	
	// 상품코드가 넘어오면 해당 상품을 늘사는것목록에서 삭제
	if(request.getParameter("goods_no").length() != 1){
		String sql = "delete from wishlist " +
				 "where m_id = ? and goods_no= ? ";
	
		try{
			conn = ConnectionProvider.getConnection();
		    pstmt = conn.prepareStatement(sql);	    
		    
		    // 전달받은 상품번호와 회원번호 바인딩 변수 설정	    
		    pstmt.setString(1, request.getParameter("m_id"));
		    pstmt.setString(2, request.getParameter("goods_no"));
		    
		    result = pstmt.executeUpdate();
		    
		    data = new JSONObject();
		    data.put("count", result);  // {"count":1}
		    
		    
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			   pstmt.close();
			   conn.close();
		 }
		
	// 상품코드가 *로 넘어오면 해당회원의 늘 사는것 목록을 모두 삭제
	} else if (request.getParameter("goods_no").length() == 1){
		System.out.println("test!");
		String sql = "delete from wishlist " +
				 "where m_id = ?";
	
		try{
			conn = ConnectionProvider.getConnection();
		    pstmt = conn.prepareStatement(sql);	    
		    
		    // 전달받은 상품번호와 회원번호 바인딩 변수 설정	    
		    pstmt.setString(1, request.getParameter("m_id"));
		    
		    result = pstmt.executeUpdate();
		    
		    data = new JSONObject();
		    data.put("count", result);  // {"count":1}
	    
		    
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			   pstmt.close();
			   conn.close();
		 }
	}
	
%>

<%=data %>
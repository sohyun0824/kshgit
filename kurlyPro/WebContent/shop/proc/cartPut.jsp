<%@page import="shop.member.model.MemberDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.util.JdbcUtil"%>
<%@page import="com.util.ConnectionProvider"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	MemberDTO member = (MemberDTO)session.getAttribute("member");
	String m_id = member.getM_id();

	String[] goods_noArr = request.getParameterValues("goods_noArr");
	String[] cntArr = request.getParameterValues("cntArr");
	String[] priceArr = request.getParameterValues("priceArr");
	int[] cArr = new int[goods_noArr.length];
	
	JSONObject data = new JSONObject();
	
	// 이미 있는 상품인지 확인
	String sql = "select count(*) from basket where m_id = ? and goods_no = ?";
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		conn = ConnectionProvider.getConnection();
		
		for(int i=0 ; i<goods_noArr.length ; i++){
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			pstmt.setString(2, goods_noArr[i]);
			rs = pstmt.executeQuery();
			if(rs.next()){
				cArr[i] = rs.getInt(1);
			}
		}
		
	} catch(Exception e){
		e.printStackTrace();
	}
	
	int result = 0;

	for(int i=0 ; i<cArr.length ; i++){
		if(cArr[i] == 0){
			// 아직 장바구니에 없는 상품이면 새로 insert
			sql = "insert into basket (basket_no, cnt, price, goods_no, m_id) values('B'||lpad(seq_basket.nextval,5,0), ?, ?, ?, ?)";
			
			try{
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(cntArr[i]));
				pstmt.setInt(2, Integer.parseInt(priceArr[i])*Integer.parseInt(cntArr[i]));
				pstmt.setString(3, goods_noArr[i]);
				pstmt.setString(4, m_id);
				result += pstmt.executeUpdate();
				
			} catch(Exception e){
				e.printStackTrace();
			}
			
		} else{
			// 이미 장바구니에 있는 상품이면 수량, 가격 추가
			sql = "update basket set cnt = cnt+?, price = price+? where m_id = ? and goods_no = ? ";
			
			try{
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(cntArr[i]));
				pstmt.setInt(2, Integer.parseInt(priceArr[i])*Integer.parseInt(cntArr[i]));
				pstmt.setString(3, m_id);
				pstmt.setString(4, goods_noArr[i]);
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
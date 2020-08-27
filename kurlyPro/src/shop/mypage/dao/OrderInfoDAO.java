package shop.mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import shop.mypage.model.OrderInfoDTO;

public class OrderInfoDAO {
	// 싱글톤
	private static OrderInfoDAO dao = null;
	private OrderInfoDAO() {}
	
	public static OrderInfoDAO getInstance() {
		if(dao == null) {
			dao = new OrderInfoDAO();
		}
		return dao;
	}

	public OrderInfoDTO OrderInfo(Connection conn, Long orderno) {
		System.out.println("OrderInfoDAO.OrderInfo()호출..");
		
		String sql = "select ol.order_no order_no, ui.user_name user_name, pl.pay_date pay_date, ol.status status, ol.no_goods no_goods " + 
				"from order_list ol join user_info ui on ol.user_no = ui.user_no " + 
				"                   join pay_list pl on pl.pay_code = ol.pay_code " + 
				"where ol.order_no = ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		OrderInfoDTO dto = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			// 바인딩 변수 설정
			pstmt.setLong(1, orderno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new OrderInfoDTO();
				
				dto.setOrder_no(rs.getLong("order_no"));
				dto.setPay_date(rs.getDate("pay_date"));
				dto.setStatus(rs.getString("status"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setNo_goods(rs.getString("no_goods"));
				
			}else {
				System.out.println("주문자 정보 없음..");
				return null;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
}

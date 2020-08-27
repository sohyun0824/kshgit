package shop.mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import shop.mypage.model.PayInfoDTO;

public class PayInfoDAO {
	// 싱글톤
	private static PayInfoDAO dao = null;
	private PayInfoDAO() {}
	
	public static PayInfoDAO getInstance() {
		if(dao == null) {
			dao = new PayInfoDAO();
		}
		return dao;
	}

	public PayInfoDTO PayDetail(Connection conn, Long orderno) {
		System.out.println("PayInfoDAO.PayDetail()호출..");
		
		String sql = "select order_no, discount, coupon, point, del_fee, pay_amount, add_point, sum(g_price_cnt) order_amount, pay_name " + 
				"from (" + 
				"        select ol.order_no order_no, pl.discount discount, pl.use_coupon coupon, pl.use_point point, pl.del_fee del_fee, pl.pay_amount pay_amount, pl.add_point add_point, g.price * og.cnt g_price_cnt, p.pay_name pay_name " + 
				"        from pay_list pl join order_list ol on pl.pay_code = ol.pay_code " + 
				"                         join order_goods og on ol.order_no = og.order_no " + 
				"                         join goods g on g.goods_no = og.goods_no " + 
				"						  join payment p on pl.payment_no = p.payment_no " +
				"        where ol.order_no = ? " + 
				"        ) t " + 
				"group by order_no, discount, coupon, point, del_fee, pay_amount, add_point, pay_name ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		PayInfoDTO dto = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			// 바인딩 변수 설정
			pstmt.setLong(1, orderno);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				
				dto =  new PayInfoDTO();
				
				dto.setOrder_no(rs.getLong("order_no"));
				dto.setDiscount( rs.getInt("discount") );
				dto.setPay_amount( rs.getInt("pay_amount"));
				dto.setCoupon(rs.getInt("coupon"));
				dto.setPoint(rs.getInt("point"));
				dto.setDel_fee(rs.getInt("del_fee"));
				dto.setAdd_point(rs.getInt("add_point"));
				dto.setOrder_amount(rs.getInt("order_amount"));
				dto.setPay_name(rs.getString("pay_name"));
				
			} else {
				System.out.println("결제 내역 없음..");
				return null;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	
}

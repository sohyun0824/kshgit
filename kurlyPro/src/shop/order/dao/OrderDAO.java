package shop.order.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.util.JdbcUtil;

import shop.order.model.CouponDTO;

public class OrderDAO {
	
	private static OrderDAO dao = null;
	private OrderDAO() {}
	public static OrderDAO getInstance() {
		if(dao == null) dao = new OrderDAO();
		return dao;
	}
	
	public ArrayList<CouponDTO> selectCoupon(Connection conn, String m_id) {
		String sql = "select ci.coupon_code, name, type, advantage, limited_price, expire_date " + 
				"from coupon_info ci join issued_coupon ic on ci.coupon_code=ic.coupon_code " + 
				"    join coupon c on ic.coupon_no=c.coupon_no " + 
				"where c.m_id=? and ic.used=0";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CouponDTO dto = null;
		ArrayList<CouponDTO> list = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			list = new ArrayList<CouponDTO>();
			if(rs.next()) {
				do {
					dto = new CouponDTO();
					dto.setCoupon_code(rs.getString("coupon_code"));
					dto.setName(rs.getString("name"));
					dto.setType(rs.getString("type"));
					dto.setAdvantage(rs.getInt("advantage"));
					dto.setLimited_price(rs.getInt("limited_price"));
					dto.setExpire_date(rs.getDate("expire_date"));
					list.add(dto);
				} while (rs.next());
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(conn);
		}
		
		return list;
	}
}

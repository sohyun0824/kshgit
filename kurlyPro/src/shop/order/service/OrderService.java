package shop.order.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.util.ConnectionProvider;

import shop.order.dao.OrderDAO;
import shop.order.model.CouponDTO;

public class OrderService {

	public ArrayList<CouponDTO> selectCoupon(String m_id){
		OrderDAO dao = OrderDAO.getInstance();
		try(Connection conn = ConnectionProvider.getConnection()) {
			ArrayList<CouponDTO> list = dao.selectCoupon(conn, m_id);
			return list;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
}

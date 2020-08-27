package shop.mypage.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.util.ConnectionProvider;

import shop.mypage.dao.OrderDetailDAO;
import shop.mypage.model.OrderDetailDTO;

public class GetOrderDetailService {
	// 싱글톤 객체
	private static GetOrderDetailService instance = null;

	public static GetOrderDetailService getInstance() {
		if(instance == null) {
			instance = new GetOrderDetailService();
		}
		return instance;
	}
	
	// 디폴트 생성자
	private GetOrderDetailService() {	
	}

	public ArrayList<OrderDetailDTO> viewDetail(Long orderno) {
		OrderDetailDAO dao = null;
		Connection conn = null;
		ArrayList<OrderDetailDTO> list = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			dao = OrderDetailDAO.getInstance();
			list =  dao.orderDetail(conn, orderno);
			return list;
		}catch(Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	
}

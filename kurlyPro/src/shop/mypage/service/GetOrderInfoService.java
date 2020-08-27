package shop.mypage.service;

import java.sql.Connection;

import com.util.ConnectionProvider;

import shop.mypage.dao.OrderInfoDAO;
import shop.mypage.model.OrderInfoDTO;

public class GetOrderInfoService {
	// 싱글톤 객체
	private static GetOrderInfoService instance = null;

	public static GetOrderInfoService getInstance() {
		if(instance == null) {
			instance = new GetOrderInfoService();
		}
		return instance;
	}
	
	// 디폴트 생성자
	private GetOrderInfoService() {	
	}

	public OrderInfoDTO viewOrderInfo(Long orderno) {
		System.out.println("GetOrderInfoService.viewOrderInfo요청..");
		OrderInfoDAO dao = null;
		Connection conn = null;
		OrderInfoDTO dto = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			dao = OrderInfoDAO.getInstance();
			dto =  dao.OrderInfo(conn, orderno);
			return dto;
		}catch(Exception e) {
			throw new RuntimeException(e);
		}
	}
}

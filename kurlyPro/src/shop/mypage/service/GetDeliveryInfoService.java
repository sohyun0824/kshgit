package shop.mypage.service;

import java.sql.Connection;

import com.util.ConnectionProvider;

import shop.mypage.dao.DeliveryInfoDAO;
import shop.mypage.model.DeliveryInfoDTO;

public class GetDeliveryInfoService {
	// 싱글톤 객체
	private static GetDeliveryInfoService instance = null;

	public static GetDeliveryInfoService getInstance() {
		if(instance == null) {
			instance = new GetDeliveryInfoService();
		}
		return instance;
	}
	
	// 디폴트 생성자
	private GetDeliveryInfoService() {	
	}

	public DeliveryInfoDTO viewDeliveryInfo(Long orderno) {
		System.out.println("GetDeliveryInfoService.viewDeliveryInfo요청..");
		DeliveryInfoDAO dao = null;
		Connection conn = null;
		DeliveryInfoDTO dto = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			dao = DeliveryInfoDAO.getInstance();
			dto =  dao.DeliveryInfo(conn, orderno);
			return dto;
		}catch(Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	
}

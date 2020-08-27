package shop.mypage.service;

import java.sql.Connection;

import com.util.ConnectionProvider;

import shop.mypage.dao.PayInfoDAO;
import shop.mypage.model.PayInfoDTO;

public class GetPayInfoService {
	// 싱글톤 객체
	private static GetPayInfoService instance = null;

	public static GetPayInfoService getInstance() {
		if(instance == null) {
			instance = new GetPayInfoService();
		}
		return instance;
	}
	
	// 디폴트 생성자
	private GetPayInfoService() {	
	}

	public PayInfoDTO viewPayInfo(Long orderno) {
		System.out.println("GetPayInfoService.viewPayInfo요청..");
		PayInfoDAO dao = null;
		Connection conn = null;
		PayInfoDTO dto = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			dao = PayInfoDAO.getInstance();
			dto =  dao.PayDetail(conn, orderno);
			return dto;
		}catch(Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	
}

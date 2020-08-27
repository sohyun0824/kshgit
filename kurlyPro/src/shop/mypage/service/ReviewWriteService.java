package shop.mypage.service;

import java.sql.Connection;

import com.util.ConnectionProvider;

import shop.mypage.dao.GoodsInfoDAO;
import shop.mypage.model.GoodsInfoDTO;

public class ReviewWriteService {
	// 싱글톤
	private static ReviewWriteService instance = null;

	public static ReviewWriteService getInstance() {
		if(instance == null) {
			instance = new ReviewWriteService();
		}
		return instance;
	}
	
	public ReviewWriteService() { }

	public GoodsInfoDTO getImgandName(String goods_no) {
		GoodsInfoDAO dao = null;
		Connection conn = null;
		GoodsInfoDTO dto = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			dao = GoodsInfoDAO.getInstance();
			dto = dao.GetGoodsImg(conn, goods_no);
			return dto;
		} catch(Exception e) {
			throw new RuntimeException(e);
		}
	}
}

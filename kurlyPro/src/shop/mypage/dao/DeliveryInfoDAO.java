package shop.mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import shop.mypage.model.DeliveryInfoDTO;

public class DeliveryInfoDAO {
	// 싱글톤
	private static DeliveryInfoDAO dao = null;
	
	private DeliveryInfoDAO() {}
	
	public static DeliveryInfoDAO getInstance() {
		if(dao == null) {
			dao = new DeliveryInfoDAO();
		}
		return dao;
	}

	// 주문상세내역에서 배송정보 출력하기
	public DeliveryInfoDTO DeliveryInfo(Connection conn, Long orderno) {
		System.out.println("DeliveryInfoDAO.DeliveryInfo()호출..");
		
		String sql = "select di.receiver receiver, di.receiver_tel tel, di.address address, di.delivery_type type, di.loc loc, di.front_door front_door, di.delivered_msg msg " + 
				"from order_list ol join delivery_info di on ol.delivery_code = di.delivery_code " + 
				"where ol.order_no = ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		DeliveryInfoDTO dto = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			// 바인딩 변수 설정
			pstmt.setLong(1, orderno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new DeliveryInfoDTO();
				
				dto.setReceiver(rs.getString("receiver"));
				dto.setTel(rs.getString("tel"));
				dto.setAddress(rs.getString("address"));
				dto.setType(rs.getString("type"));
				dto.setLoc(rs.getString("loc"));
				dto.setFront_door(rs.getString("front_door"));
				dto.setMsg(rs.getString("msg"));
				
			}else {
				System.out.println("배송 정보 없음..");
				return null;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	
}

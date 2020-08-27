package shop.mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import shop.mypage.model.ReviewBeforeDTO;

public class ReviewBeforeDAO {
	// 싱글톤
	private static ReviewBeforeDAO dao = null;
	private ReviewBeforeDAO() {}
		
	public static ReviewBeforeDAO getInstance() {
		if(dao == null) {
			dao = new ReviewBeforeDAO();
		}
		return dao;
	}

	public ArrayList<ReviewBeforeDTO> selectReviewBefore(Connection conn, String m_id) {
System.out.println("ReviewBeforeDAO.selectReviewBefore..");
		
		// 로그인한 회원의 작성가능한 후기 리스트 불러오기																													, (select count(*) from review_before_list) list_cnt
		String sql = "select group_no, group_name, goods_no, goods_name, main_img, cnt, order_no, delivered_date , 30 - round(sysdate-delivered_date, 0) remaining_days " + 
				"from review_before_list " + 
				"where m_id = ? and review_bool = 0 and status = '배송완료' and sysdate-delivered_date <= 30 " + 
				"order by remaining_days ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		ReviewBeforeDTO dto = null;
		ArrayList<ReviewBeforeDTO> list = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			// user_no 바인딩 변수 설정
			pstmt.setString(1, m_id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				do {
					dto =  new ReviewBeforeDTO();

					dto.setCnt(rs.getInt("cnt"));
					dto.setDelivered_date(rs.getDate("delivered_date"));
					dto.setGoods_name(rs.getString("goods_name"));
					dto.setGoods_no(rs.getString("goods_no"));
					dto.setGroup_name(rs.getString("group_name"));
					dto.setGroup_no(rs.getString("group_no"));
					dto.setMain_img(rs.getString("main_img"));
					dto.setOrder_no(rs.getLong("order_no"));
					dto.setRemaining_days(rs.getInt("remaining_days"));
					//dto.setList_cnt(rs.getInt("list_cnt"));
					
					list.add(dto);
				} while (rs.next());
			} 
//			else {
//				System.out.println("작성가능후기 없음..");
//				return null;
//			}
		}catch (SQLException e) { 
			e.printStackTrace();
		}
		return list;
	}
	
	
}

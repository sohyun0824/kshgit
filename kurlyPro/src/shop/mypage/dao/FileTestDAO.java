package shop.mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import shop.mypage.model.FileTestDTO;

public class FileTestDAO {
	// 싱글톤
	private static FileTestDAO dao = null;
	private FileTestDAO() {}
		
	public static FileTestDAO getInstance() {
		if(dao == null) {
			dao = new FileTestDAO();
		}
		return dao;
	}

	public int insertReviewed(Connection conn, FileTestDTO dto) {
		System.out.println("FileTestDAO.insertReviewed..");
		
		String sql = "insert into reviewed (reviewed_no, goods_no, order_no, title, content, name, m_id) " + 
				"values ('RV'||lpad(reviewed_sq.nextval, 5, '0'), ?, ?, ?, ?, ?, ?) ";
		
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			// 바인딩 변수 설정 (매개변수로 받아온 dto정보값 이용)
			pstmt.setString(1, dto.getGoods_no());
			pstmt.setLong(2, dto.getOrder_no());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContents());
			pstmt.setString(5, dto.getM_name());
			pstmt.setString(6, dto.getM_id());
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public int updateReviewBool(Connection conn, FileTestDTO dto) {
		System.out.println("FileTestDAO.updateReviewBool()..");
		
		String sql = "update order_goods " + 
					"set review_bool = 1 " + 
					"where order_no = ? and goods_no = ?";
		
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, dto.getOrder_no());
			pstmt.setString(2, dto.getGoods_no());
			
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public String selectReviewNo(Connection conn, FileTestDTO dto) {
		System.out.println("FileTestDAO.selectReviewNo()..");
		
		String sql = "select max(reviewed_no) review_no " + 
				"from reviewed " + 
				"where m_id = ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String review_no = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getM_id());
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			review_no = rs.getString("review_no");
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("후기글번호 가져오기 실패..");
		}
		return review_no;
	}

	public int insertImg(Connection conn, String reviewed_no, String file_name) {
		System.out.println("FileTestDAO.insertImg()..");
		
		String sql = "insert into review_img (seq, reviewed_no, img) " + 
				"values ('RI'||lpad(review_img_sq.nextval, 5, '0'), ?, ?)";
		
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, reviewed_no);
					
			pstmt.setString(2, file_name);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}

package shop.mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReviewDeleteDAO {
	// 싱글톤
	private static ReviewDeleteDAO dao = null;
	private ReviewDeleteDAO() {}
		
	public static ReviewDeleteDAO getInstance() {
		if(dao == null) {
			dao = new ReviewDeleteDAO();
		}
		return dao;
	}

	public int updateReviewBool(Connection conn, String goods_no, String orderno) {
		System.out.println("ReviewDeleteDAO.updateReviewBool()~");
		
		Long order_no = Long.parseLong(orderno);
		
		String sql = "update order_goods " + 
				"set review_bool = 0 " + 
				"where goods_no = ? and order_no = ? ";
		
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, goods_no);
			pstmt.setLong(2, order_no);
			
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public ArrayList<String> selectSystemName(Connection conn, String reviewed_no) {
		System.out.println("ReviewDeleteDAO.selectSystemName()~");
		
		String sql = "select img " + 
					"from review_img " +
					"where reviewed_no = ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> file_list = new ArrayList<String>();
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, reviewed_no);
			
			rs = pstmt.executeQuery();
			
			if (rs.next() ) {
				do {
					file_list.add(rs.getString("img"));
				} while (rs.next());
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return file_list;
	}

	public int deleteReview_Img(Connection conn, String reviewed_no) {
		System.out.println("ReviewDeleteDAO.deleteReview_Img()~");
		
		String sql = "delete from review_img "
					+ "where reviewed_no = ? ";
		
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, reviewed_no);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public int deleteReviewed(Connection conn, String reviewed_no) {
		System.out.println("ReviewDeleteDAO.deleteReviewed()..");
		
		String sql = "delete from reviewed "
					+ "where reviewed_no = ? ";
		
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, reviewed_no);
			
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}

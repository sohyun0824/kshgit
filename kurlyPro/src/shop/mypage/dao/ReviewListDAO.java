package shop.mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.util.JdbcUtil;

public class ReviewListDAO {
	private static ReviewListDAO dao = new ReviewListDAO();
	private ReviewListDAO() {}
	public static ReviewListDAO getInstance() {
		return dao;
	}
	
	public int selectCouponCnt(Connection conn, String m_id) {
		String sql = "select count(*) from coupon where m_id = ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return cnt;
	}
	public int selectKpass(Connection conn, String m_id) {
		String sql = "select count(*) from kpass_paylist where m_id = ? and ( expire_date is null or expire_date < sysdate )";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return cnt;
	}
	public int selectBeforeCnt(Connection conn, String m_id) {
		String sql = "select count(*) from review_before_list where m_id = ? and review_bool = 0 and status = '배송완료' and sysdate-delivered_date <= 30 ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return cnt;
	}
	public int selectAfterCnt(Connection conn, String m_id) {
		String sql = "select count(*) from reviewed where m_id = ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return cnt;
	}
	
	
}

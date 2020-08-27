package shop.mypage.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.util.ConnectionProvider;

import shop.mypage.dao.ReviewAfterDAO;
import shop.mypage.dao.ReviewBeforeDAO;
import shop.mypage.dao.ReviewListDAO;
import shop.mypage.model.ReviewAfterDTO;
import shop.mypage.model.ReviewBeforeDTO;

public class ReviewListService {
	private ReviewListService() {}
	private static ReviewListService service = new ReviewListService();
	public static ReviewListService getInstance() {
		return service;
	}
	
	// 로그인한 회원의 작성가능후기(오늘 - 배송완료일 <= 30일 이내인 주문내역 리스트) 가져오기
	public ArrayList<ReviewBeforeDTO> selectBeforeReview(String m_id) {
		System.out.println("GetReviewBeforeService.selectBeforeReview()..");
		ReviewBeforeDAO dao = null;
		Connection conn = null;
		ArrayList<ReviewBeforeDTO> list = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			dao = ReviewBeforeDAO.getInstance();
			list = dao.selectReviewBefore(conn, m_id);
			return list;
		} catch(Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	// 작성완료후기 목록 가져오기
	public ArrayList<ReviewAfterDTO> selectAfterReview(String m_id) {
		System.out.println("GetReviewAfterService.selectAfterReview()..");
		ReviewAfterDAO dao = null;
		Connection conn = null;
		ArrayList<ReviewAfterDTO> list = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			dao = ReviewAfterDAO.getInstance();
			list = dao.selectReviewAfter(conn, m_id);
			return list;
		} catch(Exception e) {
			throw new RuntimeException(e);
		}
	}

	public int getCouponCnt(String m_id) {
		int cnt = 0;
		
		try(Connection conn = ConnectionProvider.getConnection()){
			ReviewListDAO dao = ReviewListDAO.getInstance();
			cnt = dao.selectCouponCnt(conn, m_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	public int getKpass(String m_id) {
		int cnt = 0;
		
		try(Connection conn = ConnectionProvider.getConnection()){
			ReviewListDAO dao = ReviewListDAO.getInstance();
			cnt = dao.selectKpass(conn, m_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	public int getBeforeCnt(String m_id) {
		int cnt = 0;
		
		try(Connection conn = ConnectionProvider.getConnection()){
			ReviewListDAO dao = ReviewListDAO.getInstance();
			cnt = dao.selectBeforeCnt(conn, m_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	public int getAfterCnt(String m_id) {
		int cnt = 0;
		
		try(Connection conn = ConnectionProvider.getConnection()){
			ReviewListDAO dao = ReviewListDAO.getInstance();
			cnt = dao.selectAfterCnt(conn, m_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}
}

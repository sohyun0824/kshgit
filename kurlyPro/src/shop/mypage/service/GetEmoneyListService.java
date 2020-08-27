package shop.mypage.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.util.ConnectionProvider;

import shop.mypage.dao.EmoneyListDAO;
import shop.mypage.model.EmoneyListDTO;
import shop.mypage.model.EmoneyListView;


public class GetEmoneyListService {
	
	// 한 페이지에 출력할 상품 수 
	private static final int LIST_COUNT_PER_PAGE = 10;
	
	// 싱글톤 객체
	private static GetEmoneyListService instance = null;

	public static GetEmoneyListService getInstance() {
		if(instance == null) {
			instance = new GetEmoneyListService();
		}
		return instance;
	}
	
	// 디폴트 생성자
	private GetEmoneyListService() {	
	}
	
	// 로그인한 회원의 적립금 내역 가져오기
	public EmoneyListView emoneyList(String m_id, int currentPage) {
		System.out.println("GetEmoneyListService.EmoneyListView()호출..");
		EmoneyListDAO dao = null;
		Connection conn = null;
		ArrayList<EmoneyListDTO> list = null;
		EmoneyListView emoneyListView = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			dao = EmoneyListDAO.getInstance();
			
			int listTotalCount = dao.getTotalCount(conn);
			
			int firstRow = 0;
			int endRow = 0;
			
			if(listTotalCount > 0) {
				
				firstRow = (currentPage - 1) * LIST_COUNT_PER_PAGE + 1;
				endRow = firstRow + LIST_COUNT_PER_PAGE - 1;
				list =  dao.selectEmoneyList(conn, m_id, firstRow, endRow);
				
			}
			emoneyListView = new EmoneyListView(listTotalCount, currentPage, list, LIST_COUNT_PER_PAGE, firstRow, endRow);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return emoneyListView;
	}

	public int sumRes(String m_id) {
		EmoneyListDAO dao = null;
		Connection conn = null;
		int res = 0;
		try {
			conn = ConnectionProvider.getConnection();
			dao = EmoneyListDAO.getInstance();
			res = dao.sumRes(conn, m_id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
}

package shop.mypage.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.util.ConnectionProvider;

import shop.mypage.dao.WishListDAO;
import shop.mypage.model.OrderListView;
import shop.mypage.model.WishListDTO;

public class GetWishListService {
	// 싱글톤 객체
	private static GetWishListService instance = null;

	public static GetWishListService getInstance() {
		if(instance == null) {
			instance = new GetWishListService();
		}
		return instance;
	}
	
	// 디폴트 생성자
	private GetWishListService() {	
	}

	// 한 페이지에 출력할 상품 수 
	private static final int LIST_COUNT_PER_PAGE = 10;
	
	// 로그인한 회원의 늘 사는 것 목록 가져오기
	public OrderListView viewList(String m_id, int currentPage) {
		System.out.println("GetWishListService.viewList()호출..");
		WishListDAO dao = null;
		Connection conn = null;
		ArrayList<WishListDTO> list = null;
		OrderListView orderListView = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			dao = WishListDAO.getInstance();
			
			int listTotalCount = dao.getTotalCount(conn);
			
			int firstRow = 0;
			int endRow = 0;
			
			if(listTotalCount > 0) {
				
				firstRow = (currentPage - 1) * LIST_COUNT_PER_PAGE + 1;
				endRow = firstRow + LIST_COUNT_PER_PAGE - 1;
				list =  dao.selectWishList(conn, m_id, firstRow, endRow);
				
			}
			orderListView = new OrderListView();
			orderListView.setCurrentPage(currentPage);
			orderListView.setEndRow(endRow);
			orderListView.setFirstRow(firstRow);
			orderListView.setOrderCountPerPage(LIST_COUNT_PER_PAGE);
			orderListView.setOrderTotalCount(listTotalCount);
			orderListView.setWishList(list);
			
			if(listTotalCount == 0) {
				orderListView.setPageTotal(0);
			} else {
				int pageTotal = listTotalCount/LIST_COUNT_PER_PAGE;
				if(listTotalCount % LIST_COUNT_PER_PAGE > 0) {
					pageTotal++;
					orderListView.setPageTotal(pageTotal);
				}
			}
			
		}catch(Exception e) {
			throw new RuntimeException(e);
		}
		
		return orderListView;
	}
	
	
}

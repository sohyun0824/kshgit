package shop.mypage.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.util.ConnectionProvider;

import shop.mypage.dao.OrderListDAO;
import shop.mypage.model.OrderListDTO;
import shop.mypage.model.OrderListView;

public class GetOrderListService {
	// 싱글톤 객체
	private static GetOrderListService instance = null;

	public static GetOrderListService getInstance() {
		if(instance == null) {
			instance = new GetOrderListService();
		}
		return instance;
	}
	
	// 디폴트 생성자
	private GetOrderListService() {	
	}
	
	// 한 페이지에 출력할 상품 수 
	private static final int ORDER_COUNT_PER_PAGE = 10;

	// 로그인한 회원의 주문내역 가져오기
	public OrderListView select(int period, String m_id, int currentPage) {
		OrderListDAO dao = null;
		Connection conn = null;
		ArrayList<OrderListDTO> list = null;
		OrderListView orderListView = null;
				
		try {
			conn = ConnectionProvider.getConnection();
			dao = OrderListDAO.getInstance();
			
			int orderTotalCount = dao.getTotalCount(conn, period);
			
			int firstRow = 0;
			int endRow = 0;
			if(orderTotalCount > 0) {
				
				firstRow = (currentPage - 1) * ORDER_COUNT_PER_PAGE + 1;
				endRow = firstRow + ORDER_COUNT_PER_PAGE - 1;
				list =  dao.selectOrderList(conn, period, m_id, firstRow, endRow);
				
			}
			orderListView = new OrderListView(orderTotalCount, currentPage, list, ORDER_COUNT_PER_PAGE, firstRow, endRow);
			
		}catch(Exception e) {
			throw new RuntimeException(e);
		}
		
		return orderListView;
	}
	
}

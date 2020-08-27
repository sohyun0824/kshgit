package shop.mypage.model;

import java.util.ArrayList;

public class OrderListView {
	private int orderTotalCount;					// 총 리스트 수
	private int currentPage;						// 현재 페이지
	private ArrayList<OrderListDTO> orderList;		// List
	private int pageTotal;							// 총 페이지 수
	private int orderCountPerPage;					// 한 페이지에 출력할 상품 수
	private int firstRow;							// 한페이지 내에서 시작 번호
	private int endRow;
	private ArrayList<WishListDTO> wishList;
		
	public OrderListView(int orderTotalCount, int currentPage, ArrayList<OrderListDTO> orderList,
			int orderCountPerPage, int firstRow, int endRow) {
		super();
		this.orderTotalCount = orderTotalCount;
		this.currentPage = currentPage;
		this.orderList = orderList;
		this.orderCountPerPage = orderCountPerPage;
		this.firstRow = firstRow;
		this.endRow = endRow;
		
		setPageTotal();
	}


	private void setPageTotal() {
		if(orderTotalCount == 0) {
			pageTotal = 0;
		} else {
			pageTotal = orderTotalCount / orderCountPerPage;
			if(orderTotalCount % orderCountPerPage > 0) {
				pageTotal++;
			}
		}
	}
	
	
	public ArrayList<WishListDTO> getWishList() {
		return wishList;
	}

	public void setWishList(ArrayList<WishListDTO> wishList) {
		this.wishList = wishList;
	}

	public OrderListView() {
		super();
	}

	public int getOrderTotalCount() {
		return orderTotalCount;
	}

	public void setOrderTotalCount(int orderTotalCount) {
		this.orderTotalCount = orderTotalCount;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public ArrayList<OrderListDTO> getOrderList() {
		return orderList;
	}

	public void setOrderList(ArrayList<OrderListDTO> orderList) {
		this.orderList = orderList;
	}

	public int getPageTotal() {
		return pageTotal;
	}

	public void setPageTotal(int pageTotal) {
		this.pageTotal = pageTotal;
	}

	public int getOrderCountPerPage() {
		return orderCountPerPage;
	}

	public void setOrderCountPerPage(int orderCountPerPage) {
		this.orderCountPerPage = orderCountPerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}


	public void setFirstRow(int firstRow) {
		this.firstRow = firstRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
		
}

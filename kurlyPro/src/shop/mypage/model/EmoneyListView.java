package shop.mypage.model;

import java.util.ArrayList;

public class EmoneyListView {
	private int listTotalCount;						// 총 리스트 수
	private int currentPage;						// 현재 페이지
	private ArrayList<EmoneyListDTO> emoneyList;		// List
	private int pageTotal;							// 총 페이지 수
	private int listCountPerPage;					// 한 페이지에 출력할 상품 수
	private int firstRow;							// 한페이지 내에서 시작 번호
	private int endRow;
	
	
	public EmoneyListView(int listTotalCount, int currentPage, ArrayList<EmoneyListDTO> emoneyList,
			int listCountPerPage, int firstRow, int endRow) {
		super();
		this.listTotalCount = listTotalCount;
		this.currentPage = currentPage;
		this.emoneyList = emoneyList;
		this.listCountPerPage = listCountPerPage;
		this.firstRow = firstRow;
		this.endRow = endRow;
		
		setPageTotal();
	}
	
	private void setPageTotal() {
		if(listTotalCount == 0) {
			pageTotal = 0;
		} else {
			pageTotal = listTotalCount / listCountPerPage;
			if(listTotalCount % listCountPerPage > 0) {
				pageTotal++;
			}
		}
	}
	
	public EmoneyListView() {
		super();
		
	}
	public int getListTotalCount() {
		return listTotalCount;
	}
	public void setListTotalCount(int listTotalCount) {
		this.listTotalCount = listTotalCount;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public ArrayList<EmoneyListDTO> getEmoneyList() {
		return emoneyList;
	}
	public void setEmoneyList(ArrayList<EmoneyListDTO> emoneyList) {
		this.emoneyList = emoneyList;
	}
	public int getPageTotal() {
		return pageTotal;
	}
	public void setPageTotal(int pageTotal) {
		this.pageTotal = pageTotal;
	}
	public int getListCountPerPage() {
		return listCountPerPage;
	}
	public void setListCountPerPage(int listCountPerPage) {
		this.listCountPerPage = listCountPerPage;
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

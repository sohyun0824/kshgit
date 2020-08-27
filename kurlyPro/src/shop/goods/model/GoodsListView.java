package shop.goods.model;

import java.util.List;

public class GoodsListView {
	private int goodsTotalCount;					// 총 상품 수
	private int currentPage;						// 현재 페이지
	private List<GoodsListDTO> goodsList;	// 상품 List
	private int pageTotal;							// 총 페이지 수
	private int goodsCountPerPage;			// 한 페이지에 출력할 상품 수
	private int firstRow;							// 시작
	private int endRow;								// 끝
	
	// 생성자
	public GoodsListView(int goodsTotalCount, int currentPage, List<GoodsListDTO> goodsList, int goodsCountPerPage, int firstRow, int endRow) {
		this.goodsTotalCount = goodsTotalCount;
		this.currentPage = currentPage;
		this.goodsList = goodsList;
		this.goodsCountPerPage = goodsCountPerPage;
		this.firstRow = firstRow;
		this.endRow = endRow;
		
		setPageTotal();
	}

	private void setPageTotal() {
		if(goodsTotalCount == 0) {
			pageTotal = 0;
		} else {
			pageTotal = goodsTotalCount / goodsCountPerPage;
			if(goodsTotalCount % goodsCountPerPage > 0) {
				pageTotal++;
			}
		}
	}

	public int getGoodsTotalCount() {
		return goodsTotalCount;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public List<GoodsListDTO> getGoodsList() {
		return goodsList;
	}

	public int getPageTotal() {
		return pageTotal;
	}

	public int getGoodsCountPerPage() {
		return goodsCountPerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public int getEndRow() {
		return endRow;
	}
	
}

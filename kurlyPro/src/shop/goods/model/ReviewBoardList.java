package shop.goods.model;

import java.util.List;

public class ReviewBoardList {
	//fields
	private int reviewTotalCount;
	private int currentPage;
	private List<ReviewBoardDTO> reviewlist;
	private int pageTotal;
	private int reviewCountPerPage;
	private int firstrow;					//1~21 21~42
	private int endrow;
	
	//constructor
	public ReviewBoardList(int reviewTotalCount, int currentPage, List<ReviewBoardDTO> reviewlist, int reviewCountPerPage,
			 int firstrow, int endrow) {
		this.reviewTotalCount = reviewTotalCount;
		this.currentPage = currentPage;
		this.reviewlist = reviewlist;
		this.reviewCountPerPage = reviewCountPerPage;
		this.firstrow = firstrow;
		this.endrow = endrow;

		setPageTotal();
	}
	
	private void setPageTotal() {
		if(reviewTotalCount==0) {
			pageTotal=0;
		}else {
			pageTotal=reviewTotalCount / reviewCountPerPage;
			if(reviewTotalCount % reviewCountPerPage>0) {
				pageTotal++;
			}
		}
	}

	public int getReviewTotalCount() {
		return reviewTotalCount;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public List<ReviewBoardDTO> getReviewlist() {
		return reviewlist;
	}

	public int getPageTotal() {
		return pageTotal;
	}

	public int getReviewCountPerPage() {
		return reviewCountPerPage;
	}

	public int getFirstrow() {
		return firstrow;
	}

	public int getEndrow() {
		return endrow;
	}
	
	
}

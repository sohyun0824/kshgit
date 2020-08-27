package shop.service.model;

import java.util.List;

public class FaqListView {

	// 게시글 관련
	private int faqTotalCount; //  총 방명록 글 수
	private int currentPageNumber; // 현재 페이지 번호
	private List<FaqDTO> faqList; //현재 페이지에서 뿌릴 List  ArrayList<BoardDTO> list
	private int pageTotalCount; // 총페이지 수
	private int faqCountPerPage; // 한 페이지에 출력할 방명록 글 수
	private int firstRow;  // 시작
	private int endRow;  // 끝
	private String searchWord;
	
	// 블럭 관련
	/*
	 * private int currentBlock; // 현재 블럭 private int rangeBlock; // 총 블럭수 private
	 * int rangeSize=5; //블럭 당 페이지수 private int prevPage; // 이전 페이지 private int
	 * nextPage; // 다음 페이지
	 */
	
	public FaqListView(int faqTotalCount, int currentPageNumber, List<FaqDTO> faqList, int faqCountPerPage,
			int firstRow, int endRow, String searchWord) {
		
		this.faqTotalCount = faqTotalCount;
		this.currentPageNumber = currentPageNumber;
		this.faqList = faqList;
		this.faqCountPerPage = faqCountPerPage;
		this.firstRow = firstRow;
		this.endRow = endRow;
		this.searchWord = searchWord;
		
		// 총 페이지수를 계산하는 메소드
		calculatePageTotalCount();
	}
	
	private void calculatePageTotalCount() {
		if (faqTotalCount == 0) {
			pageTotalCount = 0;
		} else {
			pageTotalCount = faqTotalCount / faqCountPerPage;
			if (faqTotalCount % faqCountPerPage > 0) {
				pageTotalCount++;
			}
		}
	}

	public int getFaqTotalCount() {
		return faqTotalCount;
	}

	public int getCurrentPageNumber() {
		return currentPageNumber;
	}

	public List<FaqDTO> getFaqList() {
		return faqList;
	}

	public int getPageTotalCount() {
		return pageTotalCount;
	}

	public int getFaqCountPerPage() {
		return faqCountPerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public String getSearchWord() {
		return searchWord;
	}
	
}

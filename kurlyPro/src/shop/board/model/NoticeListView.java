package shop.board.model;

import java.util.List;

public class NoticeListView {

	// 게시글 관련
	private int noticeTotalCount; //  총 방명록 글 수
	private int currentPageNumber; // 현재 페이지 번호
	private List<NoticeDTO> noticeList;
	private int pageTotalCount; // 총페이지 수
	private int noticeCountPerPage; // 한 페이지에 출력할 방명록 글 수
	private int firstRow;  // 시작
	private int endRow;  // 끝
	// 검색조건&검색어
	private String searchWord;
	private String searchCondition;
	
	// 블럭 관련
	/*
	 * private int currentBlock; // 현재 블럭 private int rangeBlock; // 총 블럭수 private
	 * int rangeSize=5; //블럭 당 페이지수 private int prevPage; // 이전 페이지 private int
	 * nextPage; // 다음 페이지
	 */	

	public NoticeListView(int noticeTotalCount, int currentPageNumber, List<NoticeDTO> noticeList,
			int noticeCountPerPage, int firstRow, int endRow, String searchWord, String searchCondition) {
		this.noticeTotalCount = noticeTotalCount;
		this.currentPageNumber = currentPageNumber;
		this.noticeList = noticeList;
		this.noticeCountPerPage = noticeCountPerPage;
		this.firstRow = firstRow;
		this.endRow = endRow;
		this.searchWord = searchWord;
		this.searchCondition = searchCondition;
		
		// 총 페이지수를 계산하는 메소드
		calculatePageTotalCount();
	}
	
	private void calculatePageTotalCount() {
		if (noticeTotalCount == 0) {
			pageTotalCount = 0;
		} else {
			pageTotalCount = noticeTotalCount/noticeCountPerPage;
			if (noticeTotalCount % noticeCountPerPage > 0) {
				pageTotalCount++;
			}
		}
	}

	public int getNoticeTotalCount() {
		return noticeTotalCount;
	}

	public int getCurrentPageNumber() {
		return currentPageNumber;
	}

	public List<NoticeDTO> getNoticeList() {
		return noticeList;
	}

	public int getPageTotalCount() {
		return pageTotalCount;
	}

	public int getNoticeCountPerPage() {
		return noticeCountPerPage;
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

	public String getSearchCondition() {
		return searchCondition;
	}
	
}

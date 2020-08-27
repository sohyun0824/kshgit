package shop.mypage.model;

import java.util.List;

public class MypageQnaListView {
	private int qnaTotalCount; // 총 방명록 글 수 
	private int currentPageNumber; // 현재 페이지 번호
	private List<MypageQnaDTO> qnaList;
	private int pageTotalCount; // 총페이지 수
	private int qnaCountPerPage; // 한 페이지에 출력할 방명록 글 수
	private int firstRow;  // 시작
	private int endRow;  // 끝 
	
	
	// 생성자
	public MypageQnaListView(
		
		List<MypageQnaDTO> qnaList,
		int qnaTotalCount,
		int currentPageNumber,
		int qnaCountPerPage, // 한 페이지에 출력할 방명록 글 수
		int firstRow,
		int endRow
		
		) {
		
		this.qnaList = qnaList;
		this.qnaTotalCount = qnaTotalCount;
		this.currentPageNumber =currentPageNumber;
		this.qnaCountPerPage = qnaCountPerPage;
		this.firstRow = firstRow;
		this.endRow = endRow;
		
		calculatePageTotalCount();
		}
		
		private void calculatePageTotalCount() {
	
		if (qnaTotalCount == 0) {
			pageTotalCount = 0;
		} else {
			pageTotalCount = qnaTotalCount / qnaCountPerPage;
			if (qnaTotalCount % qnaCountPerPage > 0) {
				pageTotalCount++;
			}
		}
		
	}// calculate

		public int getQnaTotalCount() {
			return qnaTotalCount;
		}

		public int getCurrentPageNumber() {
			return currentPageNumber;
		}

		public List<MypageQnaDTO> getQnaList() {
			return qnaList;
		}

		public int getPageTotalCount() {
			return pageTotalCount;
		}

		public int getQnaCountPerPage() {
			return qnaCountPerPage;
		}

		public int getFirstRow() {
			return firstRow;
		}

		public int getEndRow() {
			return endRow;
		}
}

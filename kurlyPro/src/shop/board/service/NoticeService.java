package shop.board.service;

import java.sql.Connection;
import java.util.Collections;
import java.util.List;

import com.util.ConnectionProvider;
import com.util.JdbcUtil;

import shop.board.dao.NoticeDAO;
import shop.board.model.NoticeDTO;
import shop.board.model.NoticeListView;

public class NoticeService {

	// 싱글톤
	private static NoticeService instance = new NoticeService();
	public static NoticeService getInstance() {
		return instance;
	}
	
	private NoticeService() {}

	// 상수 선언 : 한 페이지에 뿌릴 방명록 개수
	private static final int NOTICE_COUNT_PER_PAGE=10;
	
	// 현재 페이지 번호 + 검색조건????
	public NoticeListView getNoticeList(int pageNumber, String searchCondition, String searchWord) {

		Connection conn = null;
		int currentPageNumber = pageNumber;
		try {
			
			// DBConn.getConnection();
			conn = ConnectionProvider.getConnection();
			
			// dao 객체 생성
			NoticeDAO noticeDAO = NoticeDAO.getInstance();
			
			// 총 방명록 수
			int noticeTotalCount = noticeDAO.selectCount(conn, searchCondition, searchWord);
			
			List<NoticeDTO> noticeList = null;
			int firstRow = 0;
			int endRow = 0;
			if (noticeTotalCount > 0 ) {
				
				firstRow = (pageNumber-1)*NOTICE_COUNT_PER_PAGE +1;
				endRow = firstRow + NOTICE_COUNT_PER_PAGE-1;
				// dao.selectList() 해당페이지의 방며록을 select
				noticeList=noticeDAO.selectList(conn,firstRow,endRow, searchCondition, searchWord);
				
			}else {

				currentPageNumber=0;
				noticeList = Collections.emptyList();
		
			}
			
			return new NoticeListView(noticeTotalCount, currentPageNumber, noticeList, NOTICE_COUNT_PER_PAGE, firstRow, endRow, searchWord, searchCondition);
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(conn);
		}
		return null;
	}

	// 공지사항 상세보기 + 조회수 추가??
	// 리스트에 담아서 보낼 필요없이 seq넘버만 보내면 됨
	public NoticeDTO getNoticeContent(String currentSeq) {
		
		Connection conn = null;
		NoticeDTO noticeDetail = null;
		NoticeDAO noticeDAO = NoticeDAO.getInstance();
		try {
			conn = ConnectionProvider.getConnection();
			
			//지정한 번호의 게시글을 가져옴
			noticeDetail = noticeDAO.selectContent(conn,currentSeq);
			//조회수 증가
			conn.setAutoCommit(false);
			noticeDAO.increaseReadCount(conn, currentSeq);
			conn.commit();			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(conn);
		}
		return noticeDetail;
	}
	
	
}

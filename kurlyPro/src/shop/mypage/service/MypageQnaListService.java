package shop.mypage.service;

import java.sql.Connection;
import java.util.Collections;
import java.util.List;

import com.util.ConnectionProvider;

import shop.mypage.dao.MypageQnaDAO;
import shop.mypage.model.MypageQnaDTO;
import shop.mypage.model.MypageQnaListView;

public class MypageQnaListService {
	// 싱글톤
	private static MypageQnaListService listService = new MypageQnaListService();
	public static MypageQnaListService getInstance() {
		return listService;
	}
	private MypageQnaListService() {}
	
	// 한 페이지에 뿌릴 방명록 개수 입력 코딩
	private static final int QNA_COUNT_PER_PAGE=10;
	
	// 리스트에 담아서 필요한 값들, 현재 페이지 번호 등등...
	public MypageQnaListView getQnaList(int pageNumber, String m_id) {
		Connection conn = null;
		int currentPageNumber = pageNumber;
		try {
			conn = ConnectionProvider.getConnection(); // 커넥션 연결
			MypageQnaDAO qnaDAO = MypageQnaDAO.getInstance(); //객체 생성
			int qnaTotalCount = qnaDAO.selectCount(conn, m_id); // 총 방명록 수
			
			List<MypageQnaDTO>qnaList=null;
			int firstRow = 0;
			int endRow = 0;
			if (qnaTotalCount>0) {
				
				firstRow = (pageNumber-1)*QNA_COUNT_PER_PAGE+1;
				endRow = firstRow + QNA_COUNT_PER_PAGE-1;
				qnaList=qnaDAO.qnaList(conn,firstRow,endRow, m_id);
				
			}else {
				currentPageNumber=0;
				qnaList = Collections.emptyList();
			}
			//
			return new MypageQnaListView(
					qnaList,
					qnaTotalCount,
					currentPageNumber,
					QNA_COUNT_PER_PAGE,
					firstRow,
					endRow
				);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	return null;
	}
}

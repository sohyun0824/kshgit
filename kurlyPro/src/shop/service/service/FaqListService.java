package shop.service.service;

import java.sql.Connection;
import java.util.Collections;
import java.util.List;

import com.util.ConnectionProvider;
import com.util.JdbcUtil;

import shop.service.dao.FaqDAO;
import shop.service.model.FaqDTO;
import shop.service.model.FaqListView;

public class FaqListService {

	// 싱글톤
	private static FaqListService instance = new FaqListService();
	public static FaqListService getInstance() {
		return instance;
	}
	
	private FaqListService() {}

	// 상수 선언 : 한 페이지에 뿌릴 방명록 개수
	private static final int FAQ_COUNT_PER_PAGE=10;
	
	// 현재 페이지 번호, 카테고리, 검색단어
	public FaqListView getFaqList(int pageNumber, String sitemcd, String searchWord) {
		Connection conn = null;
		int currentPageNumber = pageNumber;
		try {
			
			// DBConn.getConnection();
			conn = ConnectionProvider.getConnection();
			
			// dao 객체 생성
			FaqDAO faqDAO = FaqDAO.getInstance();
			
			// 총 방명록 수
			int faqTotalCount = faqDAO.selectCount(conn,sitemcd, searchWord);
			
			List<FaqDTO> faqList = null;
			int firstRow = 0;
			int endRow = 0;
			if (faqTotalCount > 0 ) {
				
				firstRow = (pageNumber-1)*FAQ_COUNT_PER_PAGE +1;
				endRow = firstRow + FAQ_COUNT_PER_PAGE-1;
				// dao.selectList() 해당페이지의 방며록을 select
				faqList=faqDAO.selectList(conn,firstRow,endRow, sitemcd, searchWord);
				
			}else {
					
					currentPageNumber=0;
					faqList = Collections.emptyList();
			
			}
			// 정보가 들어오자마자 객체 생성해서 정보를 넘김
			return new FaqListView(faqTotalCount, currentPageNumber, faqList, FAQ_COUNT_PER_PAGE, firstRow, endRow, searchWord);
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(conn);
		}
		return null;
	}
	
	
}

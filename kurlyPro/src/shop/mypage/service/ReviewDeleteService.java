package shop.mypage.service;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;

import com.util.ConnectionProvider;

import shop.mypage.dao.ReviewDeleteDAO;

public class ReviewDeleteService {
	// 싱글톤
	private static ReviewDeleteService instance = null;
	public ReviewDeleteService() { }
	
	public static ReviewDeleteService getInstance() {
		if(instance == null) {
			instance = new ReviewDeleteService();
		}
		return instance;
	}

	public void reviewDelete(String goods_no, String m_id, String order_no, String reviewed_no, String saveDirectory1) {
		System.out.println("ReviewDeleteService.reviewDelete()호출...");
		
		ReviewDeleteDAO dao = null;
		Connection conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			dao = ReviewDeleteDAO.getInstance();
			
			// order_goods테이블에 후기작성여부 컬럼을 0으로 update
			int result1 = dao.updateReviewBool(conn, goods_no, order_no);
			
			// 실제로 저장된  파일 삭제
			String saveDirectory = saveDirectory1;
			
			// reviewed_no로 review_img테이블에 저장된 filesystemname리스트 얻어오기
			ArrayList<String> fileSystemName = dao.selectSystemName(conn, reviewed_no);
			
			// 얻어온 파일명으로 실제경로 생성해서 파일 삭제 리스트의 크기만큼 반복
			for (int i = 0; i < fileSystemName.size(); i++) {
				String realPath = String.format("%s%s%s", saveDirectory, File.separator, fileSystemName.get(i));
				System.out.println("첨부된 파일 " + i+1 + "번째 실제 저장 경로 : " + realPath);
				File attachedFile = new File(realPath);
				if(attachedFile.exists()) attachedFile.delete();
			}
			
			// reviewed_img테이블에 데이터 delete
			int result3 = dao.deleteReview_Img(conn, reviewed_no);
			
			// reviewed테이블에서 해당 후기글 delete
			int result2 = dao.deleteReviewed(conn, reviewed_no);
						
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}

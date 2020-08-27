package shop.mypage.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.util.ConnectionProvider;

import shop.mypage.dao.FileTestDAO;
import shop.mypage.model.FileTestDTO;

public class ReviewInsertService {
	// 싱글톤
	private static ReviewInsertService instance = null;

	public static ReviewInsertService getInstance() {
		if(instance == null) {
			instance = new ReviewInsertService();
		}
		return instance;
	}
	
	public ReviewInsertService() { }

	// 후기작성하기버튼을 누르면 해당 후기글 정보를 reviewed테이블에 insert하기
	public void reviewInsert(FileTestDTO dto) {
		System.out.println("ReviewInsertService.reviewInsert() ..");
		
		FileTestDAO dao = null;
		Connection conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			dao = FileTestDAO.getInstance();
			
			// reviewed테이블과 review_img테이블에 데이터 insert
			// reviewed테이블에 후기글정보 insert(파일 제외)
			int result1 = dao.insertReviewed(conn, dto);
			
			int result2 = dao.updateReviewBool(conn, dto);
			
			int result3 = 0;
			
			// 이미지파일이 하나라도 들어있다면
			if(dto.getFile_list() != null) {
				
				// 방금 추가한 후기글의 번호 가져오기
				String reviewed_no = dao.selectReviewNo(conn, dto);
				
				// 해당 후기글번호의 첨부파일정보 insert
				// 첨부파일의 개수만큼 insert문 실행
				ArrayList<String> file_list = dto.getFile_list();
				System.out.println(file_list.size());
				for (int i = 0; i <file_list.size() ; i++) {
					result3 += dao.insertImg(conn, reviewed_no, file_list.get(i));
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}

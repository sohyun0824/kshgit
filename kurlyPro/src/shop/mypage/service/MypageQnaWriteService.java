package shop.mypage.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.util.ConnectionProvider;

import shop.mypage.dao.MypageQnaDAO;
import shop.mypage.model.MypageQnaDTO;

public class MypageQnaWriteService {
	// 싱글톤 객체
	public static MypageQnaWriteService instance = null;
	public static MypageQnaWriteService getInstance() {
		if (instance==null) {
			instance=new MypageQnaWriteService();
		}
		return instance;
	}

	// 디폴트 생성자
	private MypageQnaWriteService() {
		
	}

	// 글쓰기 버튼을 누르면 해당 글 정보를 personalq 테이블에 insert하기
	public void qnaInsert(MypageQnaDTO dto) {
		MypageQnaDAO dao =null;
		Connection conn = null;
		// 
		try {
			conn = ConnectionProvider.getConnection();
			dao = MypageQnaDAO.getInstance();
			//personalq테이블, personalq_file 테이블에 데이터 insert
			//personal테이블에 글쓰기정보 insert(파일제외)
		
			int result = dao.insertQna(conn, dto);
			int result2 = 0; // ???
			// 파일이 하나라도 첨부되면?
			if (dto.getFile_list() != null) {
			// 방금 추가한 글 번호 가져오기
			String pq_code = dao.selectPqcode(conn, dto);
				
			// 해당 1:1문의 글 번호 첨부파일정보 insert
			// 첨부파일의 개수만큼 insert문 실행
			ArrayList<String> file_list = dto.getFile_list();
			for (int i = 0; i < file_list.size(); i++) {
				result2 += dao.insertImg(conn, pq_code, file_list.get(i));
			}	
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

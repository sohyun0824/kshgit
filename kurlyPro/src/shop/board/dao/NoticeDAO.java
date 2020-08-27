package shop.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.util.JdbcUtil;

import shop.board.model.NoticeDTO;

public class NoticeDAO {

	// 유일한 객체를 정적필드에 저장 (싱글톤)
	private static NoticeDAO noticedao = new NoticeDAO();
	
	// 유일한 객체에 접근할 수 있는 정적 메서드 정의
	public static NoticeDAO getInstance() {
		return noticedao;
	}
	
	// 생성자를 private으로 설정해서 외부에서 접근하지 못함
	private NoticeDAO() {}

	// 공지사항 게시글 수
	public int selectCount(Connection conn, String searchCondition, String searchWord) throws SQLException {
		String sql = " select  count (*)  " + 
				" from ( " + 
				"    select rownum no, t.*  " + 
				"    from (" + 
				"        select seq, title,  write_date, readed, content " + 
				"        from notice " + 
				"        order by seq desc " + 
				"        ) t " ;
				
		switch(searchCondition) {
		case "1":
			sql += ""; break;
		case "2":
			sql += " where regexp_like(title,?,'i') "; break;
		case "3":
			sql += " where regexp_like(content,?,'i') "; break;
		case "4":
			sql += " where regexp_like(title,?,'i')  or regexp_like(content,?,'i') "; break;
		}
		
		sql += "    ) b ";
		//System.out.println( sql  );
		
		PreparedStatement pstmt = null;
		ResultSet rs =  null;
		
			try {
				
					// Statement 생성
					pstmt = conn.prepareStatement(sql);
					
					if ("4".equals(searchCondition)) {
						pstmt.setString(1, searchWord);
						pstmt.setString(2, searchWord);
					}else if("2".equals(searchCondition) || "3".equals(searchCondition)){
						pstmt.setString(1, searchWord);
					}
					
					// 쿼리 실행
					rs =  pstmt.executeQuery();
					rs.next();
					return rs.getInt(1);
				
			} finally {
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
		}
	}

	// 페이징 처리 + 리스트 가져오기
	public List<NoticeDTO> selectList(Connection conn, int firstRow, int endRow, String searchCondition, String searchWord) throws SQLException {
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		try {
			String sql =	"select b.*  " + 
					" from ( " + 
					"    select rownum no, t.* " + 
					"    from (" + 
					"        select seq, title,  write_date, readed, content " + 
					"        from notice " + 
					"        order by seq desc" + 
					"        ) t " ;
			
			switch(searchCondition) {
			case "1":
				sql += ""; break;
			case "2":
				sql += " where regexp_like(title,?,'i') "; break;
			case "3":
				sql += " where regexp_like(content,?,'i') "; break;
			case "4":
				sql += " where regexp_like(title,?,'i')  or  regexp_like(content,?,'i') "; break;
			}
					
			sql += "      ) b " + 
					"    where b.no between ? and ? ";
			
		//System.out.println( sql  );
			
			pstmt = conn.prepareStatement(sql);
			
			
			if ("4".equals(searchCondition)) {
				pstmt.setString(1, searchWord);
				pstmt.setString(2, searchWord);
				pstmt.setInt(3, firstRow );
				pstmt.setInt(4, endRow );
			}else if("2".equals(searchCondition) || "3".equals(searchCondition)){
				pstmt.setString(1, searchWord);
				pstmt.setInt(2, firstRow );
				pstmt.setInt(3, endRow );
			} else {
				pstmt.setInt(1, firstRow );
				pstmt.setInt(2, endRow );
			}
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				List<NoticeDTO> noticeList = new ArrayList<>();
				do {
					 noticeList.add(makeListFromResultSet(rs));
					
					/*
					 * if (searchCondition=="1" && !searchWord.equals("*")) { String title =
					 * rs.getString("title"); title=title.replace(searchWord,
					 * String.format("<span class=searchWord>%s</span>", searchWord)); }
					 */
					
				} while (rs.next());
				return noticeList;
			} else {
				return Collections.emptyList();
			}
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	//컬럼을 가져오는 것을 반복하는 것을 (dto에 담아서) 함수로 만들어서 함수로 불러오겠다.
	private NoticeDTO makeListFromResultSet(ResultSet rs) throws SQLException {
		// 게시판에 필요한 컬럼들
		NoticeDTO dto = new NoticeDTO();
		dto.setSeq(rs.getString("seq"));
		dto.setTitle(rs.getString("title"));
		dto.setWrite_date(rs.getDate("write_date"));
		dto.setReaded(rs.getInt("readed"));
		dto.setContent(rs.getString("content"));
		return dto;
	}

	public NoticeDTO selectContent(Connection conn, String seq) throws SQLException {
		String sql= "select seq, title, write_date, readed, content"
				+ " , 'N' || lpad(substr(a.seq, 2) - 1, 5, 0) as preSeq "
				+ " , 'N' || lpad(substr(a.seq, 2) + 1, 5, 0)as nextSeq " + 
				"     ,(select max(seq) from notice) as maxSeq" + 
				"     ,(select min(seq) from notice) as minSeq" + 
				"     ,(select title from notice where seq = 'N' || lpad(substr(a.seq, 2) - 1, 5, 0)) as preTitle " + 
				"     ,(select title from notice where seq = 'N' || lpad(substr(a.seq, 2) + 1, 5, 0)) as nextTitle " + 
				"  from notice a" + 
				" where seq=? "
				+ "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NoticeDTO dto = null;
		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, seq);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = makeDetailFromResultSet(rs);
			}
			
			return dto;
			
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}

	private NoticeDTO makeDetailFromResultSet(ResultSet rs) throws SQLException {
		// 공지사항 상세보기에 필요한 컬럼&쿼리에 필요한 함수
		NoticeDTO dto = new NoticeDTO();
		dto.setSeq(rs.getString("seq"));
		dto.setTitle(rs.getString("title"));
		dto.setWrite_date(rs.getDate("write_date"));
		dto.setReaded(rs.getInt("readed"));
		dto.setContent(rs.getString("content"));
		dto.setPreSeq(rs.getString("preSeq"));
		dto.setNextSeq(rs.getString("nextSeq"));
		dto.setMaxSeq(rs.getString("maxSeq"));
		dto.setMinSeq(rs.getString("minSeq"));
		dto.setPreTitle(rs.getString("preTitle"));
		dto.setNextTitle(rs.getString("nextTitle"));
		return dto;
	}

	// 특정 seq에 해당하는 게시글 조회수 증가
	public int increaseReadCount(Connection conn, String seq) throws SQLException {
		String sql= "update notice "+
				 " set readed = readed+1 "+
				 " where seq = ? ";
				 
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, seq);
			result = pstmt.executeUpdate();
		}finally {
			JdbcUtil.close(pstmt);
		}
		return result;
	}	
	
}

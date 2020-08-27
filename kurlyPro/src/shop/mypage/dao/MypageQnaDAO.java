package shop.mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.util.JdbcUtil;

import shop.mypage.model.MypageQnaDTO;

public class MypageQnaDAO {
	private static MypageQnaDAO qnaDao = null;
	public static MypageQnaDAO getInstance() {
		if (qnaDao==null) {
			qnaDao=new MypageQnaDAO();
		}
		return qnaDao;	
	}
	//
	private MypageQnaDAO() {}
	
	// 전체 게시글 수
	public int selectCount(Connection conn, String m_id) throws SQLException {
		String sql= 	"select  count(*) " + 
				"from (    " + 
				"    select rownum no, t.* " + 
				"    from (   " + 
				"        select PQ_CODE, TITLE, name, ORDER_NO, CONTENT, WRITE_DATE, IS_ANSWER, STEP, REF, M_ID " + 
				"        from personalq join personalq_type on personalQ.pq_type=personalQ_type.pq_type " + 
				"        where m_id = ? " + 
				"        order by pq_code desc " + 
				"    ) t " + 
				") b " + 
				"order by pq_code desc" ;
		
		PreparedStatement pstmt = null;
		ResultSet rs =  null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			rs.next();
			return rs.getInt(1);
			
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	// 1:1문의 페이징 처리
	public List<MypageQnaDTO> qnaList(Connection conn, int firstRow, int endRow, String m_id) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			String sql= 	"select *   " + 
					"from (    " + 
					"    select rownum no, t.*   " + 
					"    from (   " + 
					"        select c.PQ_CODE, TITLE, d.NAME, ORDER_NO, CONTENT, WRITE_DATE, IS_ANSWER, STEP, REF, M_ID   " + 
					"        from personalq c join personalq_type d on c.pq_type=d.pq_type  " + 
					"        where m_id = ? " + 
					"        order by c.pq_code desc " + 
					"    ) t    " + 
					") b   " + 
					"where b.no between ? and ?  " + 
					"order by pq_code desc" ;
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			pstmt.setInt(2, firstRow );
			pstmt.setInt(3, endRow );
			rs = pstmt.executeQuery();
			if (rs.next()) {
				List<MypageQnaDTO> qnaList = new ArrayList<>();
				do {
					//DB에 저장돼있는 첨부파일 목록 -> 가져와서 ARRAYLIST에 담고 -> LIST 세팅 -> 
					// LIST.ADD(DTO) 에 담아서  LIST를 가져오면  
					
					//
					MypageQnaDTO dto = makefaqListFromResultSet(rs);
					
					// 이미지리스트 select
					//ArrayList<String> fileList = getFileList(conn, dto.getPq_code());
					ArrayList<String> file_list =getFile_list(conn, dto.getPq_code());
					
					dto.setFile_list(file_list);
					qnaList.add(dto);
				
				} while (rs.next());
				return qnaList;
			} else {
				return Collections.emptyList();
			}
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	private MypageQnaDTO makefaqListFromResultSet(ResultSet rs) throws SQLException {
		// 컬럼을 가져오는 것을 반복하는 것을 (dto에 담아서) 함수로 만들어서 함수로 불러오겠다.
		MypageQnaDTO dto = new MypageQnaDTO();
		dto.setPq_code(rs.getString("pq_code"));
		dto.setTitle(rs.getString("title"));	
		dto.setName(rs.getString("name"));		
		dto.setOrder_no(rs.getLong("order_no"));		
		dto.setContent(rs.getString("content"));	
		dto.setWrite_date(rs.getDate("write_date"));			
		dto.setIs_answer(rs.getInt("is_answer"));	
		dto.setStep(rs.getInt("step"));	
		dto.setRef(rs.getString("ref"));	
		dto.setM_id(rs.getString("m_id"));
		//
		return dto;
	}
	
	// 이미지에 해당하는 게시글에 가져오는 코딩처리  ->>> 게시글에 해당하는 이미지들 가져오기!	
	private ArrayList<String> getFile_list(Connection conn, String pq_code) {
		String sql = " select * from personalq_file where pq_code = ? ";
		PreparedStatement pstmt = null;
		ResultSet rs = null;	
		ArrayList<String> list = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pq_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<String>();
				do {
					// pq_file 컬럼 list에 추가 
					list.add(rs.getString("pq_file"));
				} while (rs.next());
						
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		//if( list == null ) System.out.println("list null");
		//else  System.out.println("----------------- " +   list.size() +" ----------------------");
		return list;
	}
	
	// 글쓰기 등록
	public int insertQna(Connection conn, MypageQnaDTO dto) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		
		if (dto.getRef() == "" || dto.getRef() == null) {
	
			// 새글 쓰기
			// Name: personalq.PQ_TYPE, 
			String sql =  	" insert into personalq  "
								+ " (PQ_CODE, TITLE, PQ_TYPE, ORDER_NO, CONTENT,  STEP, ref, M_ID)  " 
								+ "  values( 'N' || lpad(seq.nextval, 5, 0),?,?, 12345678912345, ?, 0  "
								+ " ,'N' || lpad(seq.currval, 5, 0), ?)  ";

			try {
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, dto.getTitle());
					pstmt.setString(2, dto.getPq_type());
					//pstmt.setLong(3, dto.getOrder_no());
					pstmt.setString(3, dto.getContent());
					pstmt.setString(4, dto.getM_id());
					//pstmt.setInt(4, dto.getStep());
					//pstmt.setString(6, dto.getM_id());
					
					result = pstmt.executeUpdate();
					
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				// ???
				try {	pstmt.close();} catch (SQLException e) {e.printStackTrace();}
				//try {	rs.close();} catch (SQLException e) {e.printStackTrace();}
			}
		}else {  
			// 답글
			// 부모 step보다 큰 step+1
			String sql = " update personalq "
							+ " set step = step +1 "
							+ " where ref = ? and step > ? ";
			try {		
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getRef());
				pstmt.setInt(2, dto.getStep());
			
			}catch (SQLException e) {
				e.printStackTrace();
			}finally {
				try {	pstmt.close();} catch (SQLException e) {e.printStackTrace();}
				try {	rs.close();} catch (SQLException e) {e.printStackTrace();}
			}
		}//else
			
		return result;
	}
	
	public String selectPqcode(Connection conn, MypageQnaDTO dto) {
		System.out.println("selectPqcode() 호출..");
		
		String sql = 	" select max(pq_code) pq_code" + 
							" from personalq " + 
							" where m_id = ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String pq_code = null;
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getM_id());
			rs = pstmt.executeQuery();
			rs.next();
			
			pq_code = rs.getString("pq_code");
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("후기글번호 가져오기 실패..");
		}
		return pq_code;
	}
	
	// 이미지
	public int insertImg(Connection conn, String pq_code, String pq_file) {
		System.out.println("DAO.insertImg()호출..");
		
		String sql = " insert into personalq_file (seq, pq_code, pq_file) " + 
				" values ('R'||lpad(pqfilqSeq.nextval, 5, '0'), ?, ?) ";
		
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pq_code);
			pstmt.setString(2, pq_file);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	

	
}

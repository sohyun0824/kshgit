package shop.service.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.util.JdbcUtil;

import shop.service.model.FaqDTO;

public class FaqDAO {

	// 유일한 객체를 정적필드에 저장
	// 싱글톤
	private static FaqDAO faqDao = new FaqDAO();
	
	// 유일한 객체에 접근할 수 있는 정적 메서드 정의
	public static FaqDAO getInstance() {
			return faqDao;
		}
	
	// private 생성자 (new 객체 생성 x)
	// why ??
	private FaqDAO() {}

	public int selectCount(Connection conn, String sitemcd, String searchWord) throws SQLException {
		// 전체 게시글 수 
		// 카테고리 선택 시 페이징 처리 코딩		
		String sql = " select count(*)   " + 
				"	 from ( " + 
				"    select rownum no, t.*                               " + 
				"	 from ( " + 
				"            select seq, name, title, content, write_date " + 
				"			 from faq join faq_type on faq.type_no=faq_type.type_no " ;
			
		switch (sitemcd) {
				
				case "00":
					sql += " " ;
					break; 
				case "01":
					sql +=" where regexp_like(name, '회원문의') ";
					break;
				case "02":
					sql +=" where regexp_like(name, '주문/결제') ";
					break;
				case "03":
					sql +=" where regexp_like(name, '취소/교환/반품') ";
					break;
				case "04":
					sql +=" where regexp_like(name, '배송문의') ";
					break;
				case "05":
					sql +=" where regexp_like(name, '쿠폰/적립금') ";
					break;
				case "06":
					sql +=" where regexp_like(name, '서비스 이용 및 기타') ";
					break;
			}
				
		sql +=  "	 order by seq desc  ) t " +
					"   where regexp_like(title, ?, 'i') or regexp_like(content, ?, 'i')  " + 
					"	 ) b" ;
		
		//String sql = 	"select count (*) " + 
		//		"	from ( " + 
		//		"    select rownum no, t.*                              " + 
		//		"	 from ( " + 
		//		"            select seq, name, title, content, write_date" + 
		//		"			 from faq join faq_type on faq.type_no=faq_type.type_no " + 
		//		"		  ) t " + 
		//		"	 ) b " + 
		//		" order by seq desc "	;
		
		// System.out.println("#1 정상적으로 호출됨");	
		
		PreparedStatement pstmt = null;
		ResultSet rs =  null;
		
		try {
			
			// Statement 생성
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchWord);
			pstmt.setString(2, searchWord);
			// 쿼리 실행
			rs =  pstmt.executeQuery();
			rs.next();
			return rs.getInt(1);
			
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
	}

	// 페이징 처리  + 리스트
	// 카테고리 선택 시 해당 게시글 가져오는 코딩
	// 검색어까지???
	public List<FaqDTO> selectList(Connection conn, int firstRow, int endRow, String sitemcd, String searchWord) throws SQLException {
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		try {
			String sql =	"  select *   " + 
								"  from ( " + 
								"    select rownum no, t.*                               " + 
								"	 from (" + 
								"            select seq, name, title, content, write_date" + 
								"			 from faq join faq_type on faq.type_no=faq_type.type_no  	" ;
							
			switch (sitemcd) {
				case "00":
					sql += " " ;
					break; 
				case "01":
					sql +=" where regexp_like(name, '회원문의') ";
					break;
				case "02":
					sql +=" where regexp_like(name, '주문/결제') ";
					break;
				case "03":
					sql +=" where regexp_like(name, '취소/교환/반품') ";
					break;
				case "04":
					sql +=" where regexp_like(name, '배송문의') ";
					break;
				case "05":
					sql +=" where regexp_like(name, '쿠폰/적립금') ";
					break;
				case "06":
					sql +=" where regexp_like(name, '서비스 이용 및 기타') ";
					break;
			}
								
			sql +=  "	order by seq desc  ) t " + 
						"   where regexp_like(title, ?, 'i') or regexp_like(content, ?, 'i')  " + 
						"	 ) b"+
						"   where b.no between  ? and ? " +
						"   order by seq desc ";
			
			//System.out.println( sql  );
				
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchWord);
			pstmt.setString(2, searchWord);
			pstmt.setInt(3, firstRow );
			pstmt.setInt(4, endRow );
			rs = pstmt.executeQuery();
			if (rs.next()) {
				List<FaqDTO> faqList = new ArrayList<>();
				do {
					 faqList.add(makefaqListFromResultSet(rs));
				} while (rs.next());
				return faqList;
			} else {
				return Collections.emptyList();
			}
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	private FaqDTO makefaqListFromResultSet(ResultSet rs) throws SQLException {
		// 컬럼을 가져오는 것을 반복하는 것을 (dto에 담아서) 함수로 만들어서 함수로 불러오겠다.
		FaqDTO dto = new FaqDTO();
		dto.setSeq(rs.getString("seq"));
		dto.setName(rs.getString("name"));
		dto.setTitle(rs.getString("title"));
		dto.setContent(rs.getString("content"));
		dto.setWrite_date(rs.getDate("write_date"));
		return dto;
	}
	
}

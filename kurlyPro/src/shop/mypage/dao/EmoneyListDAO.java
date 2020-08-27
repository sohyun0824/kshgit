package shop.mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.util.JdbcUtil;

import shop.mypage.model.EmoneyListDTO;


public class EmoneyListDAO {
	
	// 싱글톤
	private static EmoneyListDAO dao = null;
	private EmoneyListDAO() {}
	
	public static EmoneyListDAO getInstance() {
		if(dao == null) {
			dao = new EmoneyListDAO();
		}
		return dao;
	}
		
	
	public int getTotalCount(Connection conn) {
		String sql = "select count(*) from point ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int totalCount = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalCount = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return totalCount;
	}

	public ArrayList<EmoneyListDTO> selectEmoneyList(Connection conn, String m_id, int firstRow, int endRow) {
		System.out.println("EmoneyListDAO.selectEmoneyList!!!");
		
		String sql = "select a.* " + 
				"from( " + 
					"select rownum no, seq, balance_date, content, expire_date, balance_point, res, m_id, (select sum(balance_point) from point where m_id = ? ) sum " + 
					"from point " + 
					"where m_id = ? " + 
				") a " + 
				"where no between ? and ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		EmoneyListDTO dto = null;
		ArrayList<EmoneyListDTO> list = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			// user_no 바인딩 변수 설정
			pstmt.setString(1, m_id);
			pstmt.setString(2, m_id);
			pstmt.setInt(3, firstRow);
			pstmt.setInt(4, endRow);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				list = new ArrayList<>();
				do {
					dto = new EmoneyListDTO();
					
					dto.setBalance_date(rs.getDate("balance_date"));
					dto.setBalance_point(rs.getInt("balance_point"));
					dto.setContent(rs.getString("content"));
					dto.setExpire_date(rs.getDate("expire_date"));
					dto.setM_id(rs.getString("m_id"));
					dto.setRes(rs.getInt("res"));
					dto.setSeq(rs.getString("seq"));
					dto.setSum(rs.getInt("sum"));
					
					list.add(dto);
				} while (rs.next());
			}
		}catch(Exception e) {
			System.out.println("적립금내역 가져오기 실패..");
			e.printStackTrace();
		}
		return list;
	}

	public int sumRes(Connection conn, String m_id) {
		String sql = "select sum(res) res from point where m_id = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int res = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			
			// user_no 바인딩 변수 설정
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			
			rs.next();
			res = rs.getInt("res");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
}

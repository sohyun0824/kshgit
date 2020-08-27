package shop.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.util.JdbcUtil;

import shop.member.model.MemberDTO;

public class MemberDAO {
	
	private static MemberDAO dao = new MemberDAO();
	
	private MemberDAO() {}

	public static MemberDAO getInstance() {
		return dao;
	}

	public int insertMember(Connection conn, MemberDTO dto) {
		String sql = "insert into member (m_id, pwd, name, email, tel, gender, birthday, recommend_id, event_name, sms_agr, email_agr) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getM_id());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getTel());
			pstmt.setString(6, dto.getGender());
			pstmt.setDate(7, dto.getBirthday());
			pstmt.setString(8, dto.getRecommend_id());
			pstmt.setString(9, dto.getEvent_name());
			pstmt.setInt(10, dto.getSms_agr());
			pstmt.setInt(11, dto.getEmail_agr());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
		}
		
		return result;
	}

	public int chkLogin(Connection conn, String id, String pw) {
		String sql = "select count(*) from member where m_id = ? and pwd = ? ";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return result;
	}

	public MemberDTO selectMember(Connection conn, String id) {
		String sql = "select * from member where m_id = ? ";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDTO dto = new MemberDTO();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setM_id(rs.getString("m_id"));
				dto.setPwd(rs.getString("pwd"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setTel(rs.getString("tel"));
				dto.setGender(rs.getString("gender"));
				dto.setBirthday(rs.getDate("birthday"));
				dto.setRecommend_id(rs.getString("recommend_id"));
				dto.setEvent_name(rs.getString("event_name"));
				dto.setSms_agr(rs.getInt("sms_agr"));
				dto.setEmail_agr(rs.getInt("email_agr"));
				dto.setGrade(rs.getString("grade"));
				dto.setTotal_point(rs.getInt("total_point"));
				dto.setJoin_date(rs.getDate("join_date"));
				dto.setExpire_date(rs.getDate("expire_date"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return dto;
	}

	

}

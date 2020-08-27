package shop.member.service;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.NamingException;

import com.util.ConnectionProvider;

import shop.member.dao.MemberDAO;
import shop.member.model.MemberDTO;

public class LoginService {

	public int chkLogin(String id, String pw) {
		MemberDAO dao = MemberDAO.getInstance();
		int result = 0;
		
		try(Connection conn = ConnectionProvider.getConnection()) {
			// id 존재여부 + 비밀번호 일치여부
			result = dao.chkLogin(conn, id, pw);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public MemberDTO selectMember(String id) {
		MemberDAO dao = MemberDAO.getInstance();
		MemberDTO dto = null;
		
		try(Connection conn = ConnectionProvider.getConnection()) {
			dto = dao.selectMember(conn, id);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return dto;
	}

}

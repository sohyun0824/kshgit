package shop.member.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.NamingException;

import com.util.ConnectionProvider;

import shop.member.dao.MemberDAO;
import shop.member.model.MemberDTO;

public class JoinService {

	public int join(MemberDTO dto) {
		MemberDAO dao = MemberDAO.getInstance();
		int result = 0;
		
		try(Connection conn = ConnectionProvider.getConnection()) {			
			result = dao.insertMember(conn, dto);
			
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}

package shop.main.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.util.ConnectionProvider;

import shop.main.dao.MainListDAO;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.model.ListDTO;

public class MainListService {

	public ArrayList<CCategoryDTO> selectCCategory() {
		ArrayList<CCategoryDTO> list = null;
		
		MainListDAO dao = MainListDAO.getInstance();
		
		try(Connection conn = ConnectionProvider.getConnection()) {
			list = dao.selectCCategory(conn);
			
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public ArrayList<PCategoryDTO> selectPCategory() {
		ArrayList<PCategoryDTO> list = null;
		
		MainListDAO dao = MainListDAO.getInstance();
		
		try(Connection conn = ConnectionProvider.getConnection()) {
			list = dao.selectPCategory(conn);
			
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public ArrayList<ListDTO> selectGoodsList(String option) {
		ArrayList<ListDTO> list = null;
		
		MainListDAO dao = MainListDAO.getInstance();
		
		try(Connection conn = ConnectionProvider.getConnection()) {
			list = dao.selectGoodsList(conn, option);
			
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
			
		return list;
	}
	
}

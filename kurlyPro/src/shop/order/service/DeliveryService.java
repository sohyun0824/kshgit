package shop.order.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.util.ConnectionProvider;

import shop.order.dao.DeliveryDAO;
import shop.order.model.DeliveryDTO;

public class DeliveryService {

	public DeliveryDTO basicDeliveryInfo(String m_id){
		DeliveryDAO dao = DeliveryDAO.getInstance();
		try(Connection conn = ConnectionProvider.getConnection()) {
			DeliveryDTO dto = dao.basicDeliveryInfo(conn, m_id);
			return dto;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public ArrayList<DeliveryDTO> selectDeliveryInfo(String m_id){
		DeliveryDAO dao = DeliveryDAO.getInstance();
		try(Connection conn = ConnectionProvider.getConnection()) {
			ArrayList<DeliveryDTO> list = dao.selectDeliveryInfo(conn, m_id);
			return list;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public int insertDeliveryInfo(DeliveryDTO dto) {
		DeliveryDAO dao = DeliveryDAO.getInstance();
		try(Connection conn = ConnectionProvider.getConnection()) {
			int result = dao.insertDeliveryInfo(conn, dto);
			return result;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public int setDefaultDeliveryInfo(String m_id) {
		DeliveryDAO dao = DeliveryDAO.getInstance();
		try(Connection conn = ConnectionProvider.getConnection()) {
			int result = dao.setDefaultDeliveryInfo(conn, m_id);
			return result;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}

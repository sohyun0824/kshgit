package shop.order.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.util.JdbcUtil;

import shop.order.model.DeliveryDTO;

public class DeliveryDAO {
	private static DeliveryDAO dao = null;
	private DeliveryDAO() {}
	public static DeliveryDAO getInstance() {
		if(dao == null) dao = new DeliveryDAO();
		return dao;
	}
	
	public DeliveryDTO basicDeliveryInfo(Connection conn, String m_id) {
		String sql = "select * from delivery_info where m_id = ? and is_basic = 1 ";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DeliveryDTO dto = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new DeliveryDTO();
				dto.setDelivery_code(rs.getString("delivery_code"));
				dto.setAddress(rs.getString("address"));
				dto.setDelivery_type(rs.getString("delivery_type"));
				dto.setReceiver(rs.getString("receiver"));
				dto.setReceiver_tel(rs.getString("receiver_tel"));
				dto.setLoc(rs.getString("loc"));
				dto.setLoc_detail(rs.getString("loc_detail"));
				dto.setFront_door(rs.getString("front_door"));
				dto.setEntering_detail(rs.getString("entering_detail"));
				dto.setDelivered_msg(rs.getString("delivered_msg"));
				dto.setM_id(m_id);
				dto.setIs_basic(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return dto;
	}
	
	public ArrayList<DeliveryDTO> selectDeliveryInfo(Connection conn, String m_id) {
		String sql = "select * from delivery_info where m_id = ? order by is_basic desc ";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DeliveryDTO dto = null;
		ArrayList<DeliveryDTO> list = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			list = new ArrayList<DeliveryDTO>();
			if(rs.next()) {
				do {
					dto = new DeliveryDTO();
					dto.setDelivery_code(rs.getString("delivery_code"));
					dto.setAddress(rs.getString("address"));
					dto.setDelivery_type(rs.getString("delivery_type"));
					dto.setReceiver(rs.getString("receiver"));
					dto.setReceiver_tel(rs.getString("receiver_tel"));
					dto.setLoc(rs.getString("loc"));
					dto.setLoc_detail(rs.getString("loc_detail"));
					dto.setFront_door(rs.getString("front_door"));
					dto.setEntering_detail(rs.getString("entering_detail"));
					dto.setDelivered_msg(rs.getString("delivered_msg"));
					dto.setM_id(m_id);
					dto.setIs_basic(rs.getInt("is_basic"));
					list.add(dto);
				} while(rs.next());
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return list;
	}
	
	public int insertDeliveryInfo(Connection conn, DeliveryDTO dto) {
		String sql = " insert into delivery_info (delivery_code, address, delivery_type, receiver, receiver_tel, loc, loc_detail, front_door, entering_detail, delivered_msg, m_id, is_basic) " + 
				" values ('AA'||LPAD(seq_delivery_info.nextval,5,'0'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
		PreparedStatement pstmt = null;
		int result  = 0;
		try {
			pstmt =  conn.prepareStatement(sql);
			pstmt.setString(1, dto.getAddress());
			pstmt.setString(2, dto.getDelivery_type());
			pstmt.setString(3, dto.getReceiver());
			pstmt.setString(4, dto.getReceiver_tel());
			pstmt.setString(5, dto.getLoc());
			pstmt.setString(6, dto.getLoc_detail());
			pstmt.setString(7, dto.getFront_door());
			pstmt.setString(8, dto.getEntering_detail());
			pstmt.setString(9, dto.getDelivered_msg());
			pstmt.setString(10, dto.getM_id());
			pstmt.setInt(11, dto.getIs_basic());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
		}
		return result;
	}
	
	public int setDefaultDeliveryInfo(Connection conn, String m_id) {
		String sql = "update delivery_info set is_basic=0 where m_id= ? ";
		PreparedStatement pstmt = null;
		int result  = 0;
		try {
			pstmt =  conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
		}
		return result;
	}
}

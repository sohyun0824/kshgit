package shop.order.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.util.JdbcUtil;

import shop.goods.model.GoodsCartDTO;
import shop.order.model.OrderListDTO;

public class OrderEndDAO {
	private static OrderEndDAO dao = null;
	private OrderEndDAO() {}
	public static OrderEndDAO getInstance() {
		if(dao == null) dao = new OrderEndDAO();
		return dao;
	}
	
	public int insertOrderGoods(Connection conn, String basket_no, String order_no) {
		String sql = " select goods_no, cnt from basket where basket_no = ? ";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GoodsCartDTO dto = null;
		int result = 0;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, basket_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new GoodsCartDTO();
				dto.setGoods_no(rs.getString("goods_no"));
				dto.setCnt(rs.getInt("cnt"));
			}
			pstmt.clearParameters();
		} catch (SQLException e) {
			System.out.println("OrderEndDAO insertOrderGoods select Error...");
			e.printStackTrace();
		} 
		
//		sql = " insert into order_goods (seq, order_no, goods_no, cnt) "
//				+ " values ('AA'||LPAD(seq_order_goods.nextval,5,'0'), ?, ?, ?) ";

		sql = " insert into order_goods (order_no, goods_no, cnt) "
				+ " values (?, ?, ?) ";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order_no);
			pstmt.setString(2, dto.getGoods_no());
			pstmt.setInt(3, dto.getCnt());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("OrderEndDAO insertOrderGoods insert Error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(conn);
		}
		
		return result;
	}
	
	public int deleteBasketGoods(Connection conn, String basket_no) {
		String sql = " delete from basket where basket_no = ? ";
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, basket_no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("OrderEndDAO insertOrderGoods delete Error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(conn);
		}
		
		return result;
	}
	
	public String insertOrderList(Connection conn, OrderListDTO dto) {
		String sql = " insert into order_list (order_no, status, order_date, delivered_date, no_goods, user_no, delivery_code, pay_code) "
				+ " values (to_number(to_char(sysdate,'yyyymmdd')||LPAD(seq_order_no.nextval,6,'0')), '입금확인', sysdate, null, ?, ?, ?, ?) ";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String order_no = "";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNo_goods());
			pstmt.setString(2, dto.getUser_no());
			pstmt.setString(3, dto.getDelivery_code());
			pstmt.setString(4, dto.getPay_code());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("OrderEndDAO insertOrderList Error...");
			e.printStackTrace();
		}
		
		sql = "select to_char(sysdate,'yyyymmdd')||LPAD(seq_order_no.currval,6,'0') seq from dual ";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				order_no = rs.getString("seq");
			}
		} catch (SQLException e) {
			System.out.println("OrderEndDAO insertOrderList Error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(conn);
		}

		return order_no;
	}
	
	public int updateEmoney(Connection conn, String m_id, int emoney) {
		String sql = "update member set is_basic=0 where m_id= ? ";
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

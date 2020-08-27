package shop.order.service;

import java.sql.Connection;

import com.util.ConnectionProvider;

import shop.order.dao.OrderEndDAO;
import shop.order.model.OrderListDTO;

public class OrderEndService {

	public int insertOrderGoods(String basket_no, String order_no){
		OrderEndDAO dao = OrderEndDAO.getInstance();
		int result = -1;
		try(Connection conn = ConnectionProvider.getConnection()) {
			result = dao.insertOrderGoods(conn, basket_no, order_no);
		} catch (Exception e) {
			System.out.println("OrderEndService Error...");
			throw new RuntimeException(e);
		}
		return result;
	}
	
	public int deleteBasketGoods(String basket_no) {
		OrderEndDAO dao = OrderEndDAO.getInstance();
		int result = -1;
		try(Connection conn = ConnectionProvider.getConnection()) {
			result = dao.deleteBasketGoods(conn, basket_no);
		} catch (Exception e) {
			System.out.println("OrderEndService Error...");
			throw new RuntimeException(e);
		}
		return result;
	}
	
	public String insertOrderList(OrderListDTO dto){
		OrderEndDAO dao = OrderEndDAO.getInstance();
		String order_no = "";
		try(Connection conn = ConnectionProvider.getConnection()) {
			order_no = dao.insertOrderList(conn, dto);
		} catch (Exception e) {
			System.out.println("OrderEndService Error...");
			throw new RuntimeException(e);
		}
		return order_no;
	}
	
}

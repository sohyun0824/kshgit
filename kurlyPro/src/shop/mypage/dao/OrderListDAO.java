package shop.mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

import com.util.JdbcUtil;

import shop.mypage.model.OrderListDTO;

public class OrderListDAO {
	// 싱글톤
	private static OrderListDAO dao = null;
	private OrderListDAO() {}
	
	public static OrderListDAO getInstance() {
		if(dao == null) {
			dao = new OrderListDAO();
		}
		return dao;
	}

	public int getTotalCount(Connection conn, int period) {
		String sql = "select count(*) from order_list ";
		
		int year = Calendar.getInstance().get(Calendar.YEAR);
		
		if (period == year) {
			sql += " where EXTRACT(year from order_date) = EXTRACT(YEAR FROM SYSDATE) ";
		}else if (period == year-1) {
			sql += " where EXTRACT(year from order_date) = EXTRACT(YEAR FROM SYSDATE)-1 ";
		} else if (period == year-2){
			sql += "where EXTRACT(year from order_date) = EXTRACT(YEAR FROM SYSDATE)-2 ";
		}
		
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

	public ArrayList<OrderListDTO> selectOrderList(Connection conn, int period, String m_id, int firstRow, int endRow) {
		System.out.println("OrderListDAO.selectOrderList..");
		
		// 로그인한 회원의 user_no로 주문번호, 결제금액, 주문날짜, 상태, 상품명 가지고 오도록 수정해야함

		int year = Calendar.getInstance().get(Calendar.YEAR);
		
		String sql = "select a.* " + 
				" from( " + 
				"    select ol.order_no, status, order_date, pay_amount, gg.group_no, gg.name group_name " + 
				"    from order_list ol join order_goods og on ol.order_no = og.order_no " + 
				"                       join goods g on og.goods_no = g.goods_no " + 
				"                       join pay_list pl on pl.pay_code = ol.pay_code " + 
				"                        join goods_group gg on gg.group_no = g.group_no " + 
				"    where ol.user_no in (select user_no " + 
				"                        from user_info u join member m on u.m_id = m.m_id " + 
				"                        where m.m_id= ? ) ";
				
		
		if (period == year) {
			sql += " and EXTRACT(year from ol.order_date) = EXTRACT(YEAR FROM SYSDATE) ";
		}else if (period == year-1) {
			sql += " and EXTRACT(year from ol.order_date) = EXTRACT(YEAR FROM SYSDATE)-1 ";
		} else if (period == year-2){
			sql += "and EXTRACT(year from ol.order_date) = EXTRACT(YEAR FROM SYSDATE)-2 ";
		}
		
		sql += "group by ol.order_no, status, order_date, pay_amount, gg.group_no, gg.name" +
				") a " + 
				" where rownum between ? and ? " + 
				" order by a.order_date desc";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		OrderListDTO dto = null;
		ArrayList<OrderListDTO> list = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			// user_no 바인딩 변수 설정
			pstmt.setString(1, m_id);
			pstmt.setInt(2, firstRow);
			pstmt.setInt(3, endRow);
			
			rs = pstmt.executeQuery();

			if(rs.next()) {
				list = new ArrayList<>();
				do {
					dto =  new OrderListDTO();

					dto.setOrder_no( rs.getLong("order_no") );
					dto.setPay_amount( rs.getInt("pay_amount"));
					dto.setStatus( rs.getString("status"));
					dto.setOrder_date( rs.getDate("order_date"));	
					dto.setGoods_name(rs.getString("group_name"));
					//dto.setMain_img(rs.getString("main_img"));
					dto.setGroup_no(rs.getString("group_no"));
					//dto.setGoods_no(rs.getString("goods_no"));
					
					list.add(dto);
				} while (rs.next());
			}
			else {
				System.out.println("검색결과없음..");
				return null;
			}
		} catch (SQLException e) { 
			e.printStackTrace();
		}
		return list;
	}
}

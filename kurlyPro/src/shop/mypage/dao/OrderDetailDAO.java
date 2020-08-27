package shop.mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import shop.mypage.model.OrderDetailDTO;

public class OrderDetailDAO {
	private static OrderDetailDAO dao = null;
	private OrderDetailDAO() {}
	
	public static OrderDetailDAO getInstance() {
		if(dao == null) {
			dao = new OrderDetailDAO();
		}
		return dao;
	}

	// 클릭한 주문번호의 상세내역(상품명, 상품그룹명, 개수, 주문상태, 주문번호, 상품가격)
	public ArrayList<OrderDetailDTO> orderDetail(Connection conn, Long orderno) {
		System.out.println("OrderDetailDAO.orderDetail호출..");
		
		String sql = "select ol.order_no order_no, status, cnt, gg.name gr_name, g.name goods_name, g.price g_price, gg.main_img main_img, gg.discount discount, g.goods_no goods_no, gg.group_no group_no " + 
				"from order_list ol join order_goods og on ol.order_no = og.order_no " + 
				"                    join goods g on g.goods_no = og.goods_no " + 
				"                    join goods_group gg  on gg.group_no = g.group_no " + 
				"where ol.order_no=?";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		OrderDetailDTO dto = null;
		ArrayList<OrderDetailDTO> list = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			// 바인딩 변수 설정
			pstmt.setDouble(1, orderno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				do {
					dto =  new OrderDetailDTO();

					dto.setOrder_no( rs.getLong("order_no") );
					dto.setStatus( rs.getString("status"));
					dto.setCnt( rs.getInt("cnt"));
					dto.setGr_name( rs.getString("gr_name"));	
					dto.setGoods_name( rs.getString("goods_name"));
					dto.setG_price( rs.getInt("g_price"));
					dto.setMain_img(rs.getString("main_img"));
					dto.setGoods_no(rs.getString("goods_no"));
					dto.setGroup_no(rs.getString("group_no"));
					dto.setDiscount(rs.getInt("discount"));
					
					list.add(dto);
				} while (rs.next());
			}
			else {
				System.out.println("상세 주문내역 없음..");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
}

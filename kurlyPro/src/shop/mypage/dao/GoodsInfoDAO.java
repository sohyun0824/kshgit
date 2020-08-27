package shop.mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import shop.mypage.model.GoodsInfoDTO;

public class GoodsInfoDAO {
	// 싱글톤
	private static GoodsInfoDAO dao = null;
	private GoodsInfoDAO() {}
		
	public static GoodsInfoDAO getInstance() {
		if(dao == null) {
			dao = new GoodsInfoDAO();
		}
		return dao;
	}

	public GoodsInfoDTO GetGoodsImg(Connection conn, String goods_no) {
		System.out.println("GoodsInfoDAO.GetGoodsImg..");
		
		String sql = "select main_img, g.goods_no goods_no, gg.name group_name, g.name goods_name, order_no " + 
				"from goods_group gg join goods g on gg.group_no = g.group_no  " + 
				"                    join order_goods og on og.goods_no = g.goods_no " + 
				"where g.goods_no=?";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GoodsInfoDTO dto = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			// 어떤 상품의 후기쓰기 버튼을 클릭하면 후기를 쓰는 페이지에 해당 상품의 이미지와 이름 출력
			pstmt.setString(1, goods_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new GoodsInfoDTO();
				
				dto.setGoods_name(rs.getString("goods_name"));
				dto.setGoods_no(rs.getString("goods_no"));
				dto.setGroup_name(rs.getString("group_name"));
				dto.setMain_img(rs.getString("main_img"));
				dto.setOrder_no(rs.getLong("order_no"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
}

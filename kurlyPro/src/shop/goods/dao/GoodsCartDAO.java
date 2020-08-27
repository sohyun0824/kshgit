package shop.goods.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.JdbcUtil;

import shop.goods.model.GoodsCartListDTO;

public class GoodsCartDAO {
	
	private static GoodsCartDAO dao = null;
	private GoodsCartDAO() {}
	public static GoodsCartDAO getInstance() {
		if(dao == null) dao = new GoodsCartDAO();
		return dao;
	}
	
	public ArrayList<GoodsCartListDTO> selectList(Connection conn, String m_id) {
		String sql = "select basket_no, gg.name group_name, g.name goods_name, cnt, discount, moomin min, "
				+ " b.price b_price, g.price g_price, g.price*decode(discount,0,0,discount/100) dc_price, g.goods_no goods_no, main_img, soldout  " 
				+ " from basket b join goods g on b.goods_no=g.goods_no "
				+ "    join goods_group gg on g.group_no=gg.group_no "
				+ " where m_id = ? ";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<GoodsCartListDTO> list = null;
		GoodsCartListDTO dto = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				list = new ArrayList<GoodsCartListDTO>();
				do {
					dto = new GoodsCartListDTO();
					dto.setBasket_no(rs.getString("basket_no"));
					dto.setGroup_name(rs.getString("group_name"));
					dto.setGoods_name(rs.getString("goods_name"));
					dto.setCnt(rs.getInt("cnt"));
					dto.setDiscount(rs.getInt("discount"));
					dto.setMin(rs.getInt("min"));
					dto.setB_price(rs.getInt("b_price"));
					dto.setG_price(rs.getInt("g_price"));
					dto.setDc_price(rs.getInt("dc_price"));
					dto.setGoods_no(rs.getString("goods_no"));
					dto.setMain_img(rs.getString("main_img"));
					dto.setSoldout(rs.getInt("soldout"));
					list.add(dto);
				}while(rs.next());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(conn);
		}
		
		return list;
	}
}

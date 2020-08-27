package shop.mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.util.JdbcUtil;

import shop.mypage.model.WishListDTO;

public class WishListDAO {
	// 싱글톤
	private static WishListDAO dao = null;
	private WishListDAO() {}
	
	public static WishListDAO getInstance() {
		if(dao == null) {
			dao = new WishListDAO();
		}
		return dao;
	}

	public int getTotalCount(Connection conn) {
		String sql = "select count(*) from wishlist ";
		
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

	public ArrayList<WishListDTO> selectWishList(Connection conn, String m_id, int firstRow, int endRow) {
		System.out.println("WishListDAO.selectWishList호출..");
		
		String sql = "select a.* " + 
				" from( " + 
				" select rownum no, m.m_id, g.goods_no goods_no, g.name goods_name, g.price price, g.soldout soldout, gg.group_no group_no, gg.name group_name, gg.main_img main_img " + 
				" from member m join wishlist w on m.m_id = w.m_id  " + 
				"              join goods g on g.goods_no = w.goods_no " + 
				"              join goods_group gg on gg.group_no = g.group_no " + 
				" where m.m_id = ? " + 
				") a " + 
				" where no between ? and ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		WishListDTO dto = null;
		ArrayList<WishListDTO> list = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			// user_no 바인딩 변수 설정
			pstmt.setString(1, m_id);
			pstmt.setInt(2, firstRow);
			pstmt.setInt(3, endRow);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				do {
					dto = new WishListDTO();
					
					dto.setGoods_no(rs.getString("goods_no"));
					dto.setGroup_name(rs.getString("group_name"));
					dto.setGroup_no(rs.getString("group_no"));
					dto.setM_id(rs.getString("m_id"));
					dto.setMain_img(rs.getString("main_img"));
					dto.setGoods_name(rs.getString("goods_name"));
					dto.setPrice(rs.getInt("price"));
					dto.setSoldout(rs.getInt("soldout"));
					
					list.add(dto);
				} while (rs.next());
			}
		}catch(Exception e) {
			System.out.println("검색결과없음..");
			e.printStackTrace();
		}
		return list;
	}
	
}

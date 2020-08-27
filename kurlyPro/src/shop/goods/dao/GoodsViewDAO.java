package shop.goods.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.JdbcUtil;

import shop.goods.model.GoodsDTO;
import shop.goods.model.GoodsInfoDTO;
import shop.goods.model.GoodsViewDTO;

public class GoodsViewDAO {
	//싱글톤
	private static GoodsViewDAO goodsViewDAO = new GoodsViewDAO();
	public static GoodsViewDAO getInstance() {
		return goodsViewDAO;
	}
	
	//생성자
	private GoodsViewDAO(){}

	public GoodsViewDTO selectgoodsview(Connection conn, String group_no) {
		String sql="select gg.group_no, name, main_img, line_discript, discount, g.price, moomin, content, img " + 
				"from goods_group gg join (select group_no, min(price) price from goods group by group_no) g on gg.group_no = g.group_no " + 
				"where gg.group_no = ? ";

		PreparedStatement pstmt = null;
		GoodsViewDTO dto = null;
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, group_no);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				dto = new GoodsViewDTO();
				dto.setGroup_no(rs.getString("group_no"));
				dto.setGroup_name(rs.getString("name"));
				dto.setLine_discript(rs.getString("line_discript"));
				dto.setMain_img(rs.getString("main_img"));
				dto.setPrice(rs.getInt("price"));
				dto.setDiscount(rs.getInt("discount"));
				dto.setMoomin(rs.getInt("moomin"));
				dto.setContent(rs.getString("content"));
				dto.setImg(rs.getString("img"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}

		return dto;
	}
	
	// 그룹에 속한 상품목록 select
	public ArrayList<GoodsDTO> selectGoodsList(Connection conn, String group_no) {
		String sql = "select * from goods where group_no = ? ";
		
		PreparedStatement pstmt = null;
		ArrayList<GoodsDTO> list = null;
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, group_no);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				list = new ArrayList<GoodsDTO>();
				do {
					GoodsDTO dto = new GoodsDTO();
					dto.setGoods_no(rs.getString("goods_no"));
					dto.setGoods_name(rs.getString("name"));
					dto.setPrice(rs.getInt("price"));
					dto.setSoldout(rs.getInt("soldout"));
					list.add(dto);
				} while(rs.next());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return list;
	}
	
	// 상품정보 select
	public List<GoodsInfoDTO> selectgoodsinfo(Connection conn, String group_no) {
		String sql="select title, content " + 
				"from goods_info  " + 
				"where group_no= ? " + 
				"order by seq ";

		PreparedStatement pstmt = null;
		GoodsInfoDTO dto = null;
		ResultSet rs = null;
		ArrayList<GoodsInfoDTO> list = null;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, group_no);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				list = new ArrayList<GoodsInfoDTO>();
				do {
					dto = new GoodsInfoDTO();
					dto.setContent(rs.getString("content")); 
					dto.setTitle(rs.getString("title")); 
					list.add(dto);
				}while(rs.next());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return list;
	}
	
	// 연관상품리스트
	public List<GoodsViewDTO> selectrelatedgoods(Connection conn, String group_no) {
		// 그룹의 하위카테고리 select
		String sql = "select child_seq seq " + 
						"from goods_group " + 
						"where group_no = ? ";

		PreparedStatement pstmt = null;
		GoodsViewDTO dto = null;
		ResultSet rs = null;
		String child_seq=null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, group_no);
			rs = pstmt.executeQuery();
			rs.next();
			child_seq = rs.getString("seq");
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);			
		}

		// 같은 하위카테고리에 있는 자신 외 다른 상품 정보들 select
		sql = "select gg.group_no, name, main_img, line_discript, discount, g.price, moomin, content, img " + 
				"from goods_group gg join (select group_no, min(price) price from goods group by group_no) g on gg.group_no = g.group_no " + 
				"where child_seq = ? and gg.group_no != ? ";

		ArrayList<GoodsViewDTO> list = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, child_seq);
			pstmt.setString(2, group_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<GoodsViewDTO>();
				do {
					dto = new GoodsViewDTO();
					dto.setGroup_no(rs.getString("group_no")); 
					dto.setGroup_name(rs.getString("name")); 
					dto.setMain_img(rs.getString("main_img"));
					dto.setPrice(rs.getInt("price")); 
					list.add(dto);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);			
		}
		
		return list;
	}

	// 상품상세 select
	public List<GoodsInfoDTO> selectgoodsdetail(Connection conn, String group_no) {
		String sql="select title, content  " + 
				"from goods_detail  " + 
				"where group_no = ?  " + 
				"order by seq ";
		
		PreparedStatement pstmt = null;
		GoodsInfoDTO dto = null;
		ResultSet rs = null;
		ArrayList<GoodsInfoDTO> list = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, group_no);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				list = new ArrayList<GoodsInfoDTO>();
				do {
					dto = new GoodsInfoDTO();
					dto.setTitle(rs.getString("title")); 
					dto.setContent(rs.getString("content")); 
					list.add(dto);
				}while(rs.next());
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}

	public int getReviewCnt(Connection conn, String group_no) {
		String sql = "select count(*) from reviewed where regexp_like(goods_no, ? ,'i')";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, group_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return cnt;
	}

	public int getQnaCnt(Connection conn, String group_no) {
		String sql = "select count(*) from goodsq where group_no = ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, group_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return cnt;
	}
	
}

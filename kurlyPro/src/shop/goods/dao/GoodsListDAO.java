package shop.goods.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.JdbcUtil;

import shop.goods.model.CategoryDTO;
import shop.goods.model.GoodsListDTO;

// 싱글톤
public class GoodsListDAO {
	private static GoodsListDAO dao = new GoodsListDAO();
	
	private GoodsListDAO() {	}
	
	public static GoodsListDAO getInstance() {
		return dao;
	}

	public ArrayList<CategoryDTO> selectCategory(Connection conn, String category) {
		String sql=" select p.parent_seq , pc_name, child_seq, cc_name " + 
				" from c_category c join p_category p on p.parent_seq =c.parent_seq " + 
				" where p.parent_seq = ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<CategoryDTO> list = null;

		if(category.length() != 1) {
			category = category.substring(0, 1);
		}
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<CategoryDTO>();
				do {
					CategoryDTO dto = new CategoryDTO();
					dto.setParent_seq(rs.getString("parent_seq"));
					dto.setPc_name(rs.getString("pc_name"));
					dto.setChild_seq(rs.getString("child_seq"));
					dto.setCc_name(rs.getString("cc_name"));
					list.add(dto);
				}while(rs.next());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return list;	
	}
	
	// 카테고리별 총 상품 수 
	public int getTotalCount(Connection conn, String category) {
		String sql = "select count(*) from goods_group "; 
		
		if(category.length() <= 2) {
			sql += "where regexp_like(child_seq, ?) ";
		} else if(category.equalsIgnoreCase("new")) {
			sql += "where reg_date > sysdate-30 ";
		} else if(category.equalsIgnoreCase("sale")) {
			sql += "where discount != 0 ";
		}
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int totalCount = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			if(category.length() <= 2) {
				pstmt.setString(1, category);				
			}
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

	// 카테고리별 상품리스트
	public ArrayList<GoodsListDTO> selectGoodsList(Connection conn, String category, String option, int firstRow, int endRow) {
		String sql="select b.* " + 
				"from( " + 
				"    select rownum no, a.* " + 
				"    from( " + 
				"        select gg.group_no, name, main_img, line_discript, discount, g.price, kurly_only, healthy, limited, child_seq, reg_date " + 
				"        from goods_group gg join (select group_no, min(price) price from goods group by group_no) g on gg.group_no = g.group_no ";
		
		if(category.length() <= 2) {
			sql += "        where regexp_like(child_seq, ?) ";
		} else if(category.equalsIgnoreCase("new")) {
			sql += "        where reg_date > sysdate-30 ";
		} else if(category.equalsIgnoreCase("sale")) {
			sql += "        where discount != 0 ";
		}
		
		switch (option) {
		case "new":
			sql += "order by reg_date desc ";
			break;
		case "low":
			sql += "order by price ";
			break;
		case "high":
			sql += "order by price desc ";
			break;
		case "sale":
			sql += "order by discount desc ";
			break;
		default:
			break;
		}
		
		sql += "    ) a " + 
				") b " + 
				"where no between ? and ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<GoodsListDTO> list = null;
	
		try {
			pstmt = conn.prepareStatement(sql);
			if(category.length() <= 2) {
				pstmt.setString(1, category);
				pstmt.setInt(2, firstRow);
				pstmt.setInt(3, endRow);				
			} else {
				pstmt.setInt(1, firstRow);
				pstmt.setInt(2, endRow);
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<GoodsListDTO>();
				do {
					GoodsListDTO dto = new GoodsListDTO();
					dto.setGroup_no(rs.getString("group_no"));
					dto.setName(rs.getString("name")); 
					dto.setMain_img(rs.getString("main_img"));
					dto.setLine_discript(rs.getString("line_discript")); 
					dto.setDiscount(rs.getInt("discount"));
					dto.setPrice(rs.getInt("price"));
					dto.setKurly_only(rs.getInt("kurly_only"));
					dto.setHealthy(rs.getInt("healthy"));
					dto.setLimited(rs.getInt("limited"));
					list.add(dto);
				}while(rs.next());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return list;
	}

	// 검색용 총 상품 수 
	public int getTotalCount_search(Connection conn, String sword) {
		String sql = "select count(*) from goods_group where regexp_like(name, ?, 'i') or regexp_like(line_discript, ? , 'i') ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int totalCount = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sword);
			pstmt.setString(2, sword);
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

	// 검색용 상품리스트
	public List<GoodsListDTO> selectGoodsList(Connection conn, String sword, int firstRow, int endRow) {
		String sql="select b.* " + 
				"from( " + 
				"    select rownum no, a.* " + 
				"    from( " + 
				"        select gg.group_no, name, main_img, line_discript, discount, g.price, kurly_only, healthy, limited, child_seq, reg_date " + 
				"        from goods_group gg join (select group_no, min(price) price from goods group by group_no) g on gg.group_no = g.group_no " + 
				"        where regexp_like(name, ?, 'i') or regexp_like(line_discript, ?, 'i') " + 
				"    ) a " + 
				") b " + 
				"where no between ? and ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<GoodsListDTO> list = null;
	
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sword);
			pstmt.setString(2, sword);
			pstmt.setInt(3, firstRow);
			pstmt.setInt(4, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<GoodsListDTO>();
				do {
					GoodsListDTO dto = new GoodsListDTO();
					dto.setGroup_no(rs.getString("group_no"));
					dto.setName(rs.getString("name")); 
					dto.setMain_img(rs.getString("main_img"));
					dto.setLine_discript(rs.getString("line_discript")); 
					dto.setDiscount(rs.getInt("discount"));
					dto.setPrice(rs.getInt("price"));
					dto.setKurly_only(rs.getInt("kurly_only"));
					dto.setHealthy(rs.getInt("healthy"));
					dto.setLimited(rs.getInt("limited"));
					list.add(dto);
				}while(rs.next());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return list;
	}
	
	
}

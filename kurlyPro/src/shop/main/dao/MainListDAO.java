package shop.main.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.util.JdbcUtil;

import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.model.ListDTO;

public class MainListDAO {
	
	private static MainListDAO dao = new MainListDAO();
	
	private MainListDAO() { }
	
	public static MainListDAO getInstance() {
		return dao;
	}

	public ArrayList<CCategoryDTO> selectCCategory(Connection conn) {
		String sql = "select * from c_category";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<CCategoryDTO> list = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<CCategoryDTO>();
				do {
					CCategoryDTO dto = new CCategoryDTO();
					dto.setChild_seq(rs.getString("child_seq"));
					dto.setCc_name(rs.getString("cc_name"));
					dto.setParent_seq(rs.getString("parent_seq"));
					list.add(dto);
				} while (rs.next());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return list;
	}

	public ArrayList<PCategoryDTO> selectPCategory(Connection conn) {
		String sql = "select * from p_category";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<PCategoryDTO> list = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<PCategoryDTO>();
				do {
					PCategoryDTO dto = new PCategoryDTO();
					dto.setParent_seq(rs.getString("parent_seq"));
					dto.setPc_name(rs.getString("pc_name"));
					list.add(dto);
				} while (rs.next());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return list;
	}

	public ArrayList<ListDTO> selectGoodsList(Connection conn, String option) {
		String sql = "select * " + 
				"from ( ";
		
		switch (option) {
		case "recommend":
			sql += "    select gg.group_no, name, main_img, discount, g.price, reg_date " + 
					"    from goods_group gg join (select group_no, min(price) price from goods group by group_no) g on gg.group_no = g.group_no " + 
					"    order by kurly_only desc, limited desc";
			break;
		case "sale":
			sql += "    select gg.group_no, name, main_img, discount, g.price " + 
					"    from goods_group gg join (select group_no, min(price) price from goods group by group_no) g on gg.group_no = g.group_no " + 
					"    where discount != 0 " + 
					"    order by discount desc";
			break;
		case "new":
			sql += "    select gg.group_no, name, main_img, discount, g.price, reg_date " + 
					"    from goods_group gg join (select group_no, min(price) price from goods group by group_no) g on gg.group_no = g.group_no " + 
					"    where reg_date > sysdate-14 " + 
					"    order by reg_date desc";
			break;
		case "hot":
			sql += "    select count(*), t.group_no, name, main_img, discount, g.price " + 
					"    from ( " + 
					"        select count(*), b.goods_no, g.group_no " + 
					"        from basket b join goods g on b.goods_no = g.goods_no " + 
					"        group by b.goods_no, g.group_no " + 
					"    ) t join goods_group gg on t.group_no = gg.group_no " + 
					"        join (select group_no, min(price) price from goods group by group_no) g on gg.group_no = g.group_no " + 
					"    group by t.group_no, name, main_img, discount, g.price " + 
					"    order by 1 desc";
			break;
		}
		
		sql += ") where rownum <= 6 ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ListDTO> list = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<ListDTO>();
				do {
					ListDTO dto = new ListDTO();
					dto.setGroup_no(rs.getString("group_no"));
					dto.setName(rs.getString("name"));
					dto.setMain_img(rs.getString("main_img"));
					dto.setDiscount(rs.getInt("discount"));
					dto.setPrice(rs.getInt("price"));
					list.add(dto);
				} while (rs.next());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return list;
	}

}

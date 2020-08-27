package shop.goods.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.ConnectionProvider;
import com.util.JdbcUtil;

import shop.goods.model.ReviewBoardDTO;

public class ReviewBoardDAO {
	
	private static ReviewBoardDAO ReviewBoardDAO = new ReviewBoardDAO();
	public static ReviewBoardDAO getInstance() {
		return ReviewBoardDAO;
	}

	private ReviewBoardDAO() {}

	public List<ReviewBoardDTO> SelectNoticeList(Connection conn) {
		String sql=" select goods_no, content, helped, readed, isnotice, name, title, write_date, reviewed_no " + 
				"from reviewed  " + 
				"where goods_no is null ";
		conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		ArrayList<ReviewBoardDTO> list=null;
		ReviewBoardDTO dto=null;

		try {
			conn=ConnectionProvider.getConnection();
			pstmt=conn.prepareStatement(sql);
			/* pstmt.setString(1, group_no); */
			rs=pstmt.executeQuery();

			if(rs.next()) {
				list= new ArrayList<ReviewBoardDTO>();

				do {
					dto= new ReviewBoardDTO();
					dto.setContent(rs.getString("content"));
					dto.setGoods_no(rs.getString("goods_no"));
					dto.setHelped(rs.getInt("helped"));
					dto.setIsnotice(rs.getInt("isnotice"));
					dto.setName(rs.getString("name"));
					dto.setReaded(rs.getInt("readed"));
					dto.setTitle(rs.getString("title"));
					dto.setWrite_date(rs.getString("write_date"));
					dto.setReviewed_no(rs.getString("reviewed_no"));
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

	public int getTotalCount(Connection conn, String group_no) {
		String sql="select count(*)  " + 
				"from reviewed r join goods g on r.goods_no = g.goods_no  " + 
				"                join goods_group gg on gg.group_no= g.group_no " + 
				"where g.group_no= ?  ";

		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int totalCount=0;
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, group_no);
			rs=pstmt.executeQuery();
			if (rs.next()) {
				//첫번째 결과값을 int로 totalCount에 대입
				totalCount=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		return totalCount;
	}

	public List<ReviewBoardDTO> selectReviewList(Connection conn, String group_no, String choose, int firstRow,
			int endRow) {
		String sql="select a.* " + 
				"    from( " + 
				"        select goods_no, content, helped, readed, isnotice, name, title, write_date, reviewed_no  " + 
				"        from reviewed   " + 
				"        where regexp_like(goods_no, ? , 'i')";

		if(choose.equals("1")) {
			sql+=" order by write_date desc ";
		}else if(choose.equals("2")){
			sql+=" order by helped desc ";
		}else {
			sql+=" order by readed desc ";
		}

		sql+= "  ) a " + 
				"    where rownum between ? and ? ";


		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList<ReviewBoardDTO> list=null;

		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, group_no);
			pstmt.setInt(2, firstRow);
			pstmt.setInt(3, endRow);
			rs=pstmt.executeQuery();

			if (rs.next()) {
				list= new ArrayList<ReviewBoardDTO>();
				do {
					ReviewBoardDTO dto= new ReviewBoardDTO();
					dto.setContent(rs.getString("content"));
					dto.setHelped(rs.getInt("helped"));
					dto.setReaded(rs.getInt("readed"));
					dto.setIsnotice(rs.getInt("isnotice"));
					dto.setWrite_date(rs.getString("write_date"));
					dto.setTitle(rs.getString("title"));
					dto.setReviewed_no(rs.getString("reviewed_no"));
					dto.setName(rs.getString("name"));
					list.add(dto);
				} while (rs.next());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}

		return list;
	}
	
}

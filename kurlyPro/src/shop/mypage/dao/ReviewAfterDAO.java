package shop.mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import shop.mypage.model.ReviewAfterDTO;

public class ReviewAfterDAO {
	// 싱글톤
	private static ReviewAfterDAO dao = null;
	private ReviewAfterDAO() {}
		
	public static ReviewAfterDAO getInstance() {
		if(dao == null) {
			dao = new ReviewAfterDAO();
		}
		return dao;
	}

	public ArrayList<ReviewAfterDTO> selectReviewAfter(Connection conn, String m_id) {
		System.out.println("ReviewAfterDAO.selectReviewAfter..");
		
		//로그인한 회원의 작성완료후기 리스트 가져오기
		String sql = "select r.reviewed_no reviewed_no, g.goods_no goods_no, r.title title, r.content content, r.helped helped, r.readed readed, r.write_date write_date, r.order_no order_no, g.name goods_name, g.group_no " +
				//	+ ", (select count(*) from reviewed join member on member.m_id = reviewed.m_id where member.m_id= ?) cnt " + 
				"from reviewed r join goods g on g.goods_no = r.goods_no " + 
				"                join member m on m.m_id = r.m_id " + 
				"where m.m_id = ? " + 
				"order by write_date desc";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		ReviewAfterDTO dto = null;
		ArrayList<ReviewAfterDTO> list = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			// user_no 바인딩 변수 설정
			pstmt.setString(1, m_id);
			//pstmt.setString(2, m_id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<ReviewAfterDTO>();
				do {
					dto = new ReviewAfterDTO();
					
					dto.setContent(rs.getString("content"));
					dto.setGoods_name(rs.getString("goods_name"));
					dto.setGoods_no(rs.getString("goods_no"));
					dto.setHelped(rs.getInt("helped"));
					dto.setOrder_no(rs.getLong("order_no"));
					dto.setReaded(rs.getInt("readed"));
					dto.setReviewed_no(rs.getString("reviewed_no"));
					dto.setTitle(rs.getString("title"));
					dto.setWrite_date(rs.getDate("write_date"));
					//dto.setCnt(rs.getInt("cnt"));
					dto.setGroup_no(rs.getString("group_no"));
					
					ArrayList<String> fileList = getFileList(conn, dto.getReviewed_no());
					System.out.println(fileList);
					dto.setFileList(fileList);
					
					list.add(dto);
				} while (rs.next());
			} else {
				System.out.println("작성완료후기 없음..");
				return null;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	private ArrayList<String> getFileList(Connection conn, String reviewed_no) {
		String sql = "select * from review_img where reviewed_no = ? ";
		PreparedStatement pstmt = null;
		ResultSet rs = null;	
		ArrayList<String> list = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reviewed_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				System.out.println("파일O");
				list = new ArrayList<String>();
				do {
					list.add(rs.getString("img"));
				} while (rs.next());
						
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
}

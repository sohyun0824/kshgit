package shop.goods.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import com.util.ConnectionProvider;

import shop.goods.dao.ReviewBoardDAO;
import shop.goods.model.ReviewBoardDTO;
import shop.goods.model.ReviewBoardList;

public class ReviewBoardService {

	public List<ReviewBoardDTO> selectNoticeList() {
		ReviewBoardDAO dao = ReviewBoardDAO.getInstance(); 

		try(Connection conn=ConnectionProvider.getConnection()) {
			List<ReviewBoardDTO> list = dao.SelectNoticeList(conn);
			return list;

		} catch (NamingException | SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	private static final int REVIEW_COUNT_PER_PAGE=5;
	
	public ReviewBoardList getReviewBoard(int currentPage, String choose, String group_no) {
		ReviewBoardList reviewlistview =null;
		ReviewBoardDAO dao= ReviewBoardDAO.getInstance();
		
		try(Connection conn=ConnectionProvider.getConnection()){
			int reviewTotalCount =dao.getTotalCount(conn, group_no);
			
			List<ReviewBoardDTO> reviewlist=null;
			int firstRow=0;
			int endRow=0;
			if(reviewTotalCount>0){
				firstRow=(currentPage - 1)*REVIEW_COUNT_PER_PAGE +1;
				endRow= firstRow + REVIEW_COUNT_PER_PAGE -1;
				reviewlist= dao.selectReviewList(conn, group_no, choose, firstRow,endRow);		
			}
			reviewlistview = new ReviewBoardList(reviewTotalCount, currentPage,reviewlist, REVIEW_COUNT_PER_PAGE, firstRow, endRow);
		}catch(NamingException | SQLException e){
			e.printStackTrace();
		}
		
		return reviewlistview;
	}

}

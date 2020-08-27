package shop.goods.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import com.util.ConnectionProvider;

import shop.goods.dao.GoodsViewDAO;
import shop.goods.model.GoodsDTO;
import shop.goods.model.GoodsInfoDTO;
import shop.goods.model.GoodsViewDTO;

public class GoodsViewService {

	public GoodsViewDTO selectgoodsview(String group_no) {
		GoodsViewDAO dao = GoodsViewDAO.getInstance();

		try(Connection conn = ConnectionProvider.getConnection()) {
			GoodsViewDTO goods= dao.selectgoodsview(conn, group_no);
			ArrayList<GoodsDTO> goodsList = dao.selectGoodsList(conn, group_no);
			int reviewCnt = dao.getReviewCnt(conn, group_no);
			int qnaCnt = dao.getQnaCnt(conn, group_no);
			
			goods.setGoodsList(goodsList);
			goods.setReviewCnt(reviewCnt);
			goods.setQnaCnt(qnaCnt);
			
			return goods;
			
		} catch (NamingException | SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		
	}
	
	public List<GoodsInfoDTO> selectgoodsinfo(String group_no) {
		GoodsViewDAO dao = GoodsViewDAO.getInstance(); 
		try(Connection conn = ConnectionProvider.getConnection()) {
			List<GoodsInfoDTO> list= dao.selectgoodsinfo(conn, group_no);
			return list;

		} catch (NamingException | SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	public List<GoodsViewDTO> selectrelatedgoods(String group_no) {
		GoodsViewDAO dao = GoodsViewDAO.getInstance(); 
		try(Connection conn = ConnectionProvider.getConnection()) {
			List<GoodsViewDTO> list= dao.selectrelatedgoods(conn, group_no);
			return list;

		} catch (NamingException | SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	public List<GoodsInfoDTO> selectgoodsdetail(String group_no) {
		GoodsViewDAO dao = GoodsViewDAO.getInstance(); 

		try(Connection conn=ConnectionProvider.getConnection()) {
			List<GoodsInfoDTO> list = dao.selectgoodsdetail(conn, group_no);
			return list;

		} catch (NamingException | SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	
}

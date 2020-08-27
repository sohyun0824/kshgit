package shop.goods.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import com.util.ConnectionProvider;

import shop.goods.dao.GoodsListDAO;
import shop.goods.model.CategoryDTO;
import shop.goods.model.GoodsListDTO;
import shop.goods.model.GoodsListView;

public class GoodsListService {

	public ArrayList<CategoryDTO> selectCategoryList(String category) {
		ArrayList<CategoryDTO> list = null;

		GoodsListDAO dao = GoodsListDAO.getInstance();

		try (Connection conn = ConnectionProvider.getConnection()) {
			list = dao.selectCategory(conn, category);

		} catch (NamingException | SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	// 한 페이지에 출력할 상품 수 
	private static final int GOODS_COUNT_PER_PAGE = 21;
	
	public GoodsListView getGoodsList(int currentPage, String category, String option) {
		GoodsListView goodsListView = null;
		GoodsListDAO dao = GoodsListDAO.getInstance();
		
		try(Connection conn = ConnectionProvider.getConnection()) {
			int goodsTotalCount = dao.getTotalCount(conn, category);
			
			List<GoodsListDTO> goodsList = null;
			int firstRow = 0;
			int endRow = 0;
			if(goodsTotalCount > 0) {
				firstRow = (currentPage - 1) * GOODS_COUNT_PER_PAGE + 1;
				endRow = firstRow + GOODS_COUNT_PER_PAGE - 1;
				goodsList = dao.selectGoodsList(conn, category, option, firstRow, endRow);
			}
			goodsListView = new GoodsListView(goodsTotalCount, currentPage, goodsList, GOODS_COUNT_PER_PAGE, firstRow, endRow);
			
		} catch (NamingException | SQLException e) {
			e.printStackTrace();
		}
		
		return goodsListView;
	}

	public GoodsListView getGoodsSearch(int currentPage, String sword) {
		GoodsListView goodsListView = null;
		GoodsListDAO dao = GoodsListDAO.getInstance();
		
		try(Connection conn = ConnectionProvider.getConnection()) {
			int goodsTotalCount = dao.getTotalCount_search(conn, sword);
			
			List<GoodsListDTO> goodsList = null;
			int firstRow = 0;
			int endRow = 0;
			if(goodsTotalCount > 0) {
				firstRow = (currentPage - 1) * GOODS_COUNT_PER_PAGE + 1;
				endRow = firstRow + GOODS_COUNT_PER_PAGE - 1;
				goodsList = dao.selectGoodsList(conn, sword, firstRow, endRow);
			}
			goodsListView = new GoodsListView(goodsTotalCount, currentPage, goodsList, GOODS_COUNT_PER_PAGE, firstRow, endRow);
			
		} catch (NamingException | SQLException e) {
			e.printStackTrace();
		}
		
		return goodsListView;
	}

}

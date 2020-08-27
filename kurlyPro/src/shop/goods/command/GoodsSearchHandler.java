package shop.goods.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.goods.model.CategoryDTO;
import shop.goods.model.GoodsListView;
import shop.goods.service.GoodsListService;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;

public class GoodsSearchHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		// 상위 하위 카테고리 가져오기
		MainListService mainService = new MainListService();
		ArrayList<CCategoryDTO> cCategoryList = mainService.selectCCategory();
		request.setAttribute("c_categoryList", cCategoryList);
		ArrayList<PCategoryDTO> pCategoryList = mainService.selectPCategory();
		request.setAttribute("p_categoryList", pCategoryList);
		
		int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page")); 
		String sword = request.getParameter("sword");
		request.setAttribute("sword", sword);
		
		GoodsListView goodsListView = null;
		try {
			GoodsListService goodsService = new GoodsListService();
			goodsListView = goodsService.getGoodsSearch(currentPage, sword);
			
			request.setAttribute("goodsListView", goodsListView);	
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "/goods/goods_search";
	}
	
}

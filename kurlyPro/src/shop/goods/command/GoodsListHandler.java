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

public class GoodsListHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		// 상위 하위 카테고리 가져오기
		MainListService mainService = new MainListService();
		ArrayList<CCategoryDTO> cCategoryList = mainService.selectCCategory();
		request.setAttribute("c_categoryList", cCategoryList);
		ArrayList<PCategoryDTO> pCategoryList = mainService.selectPCategory();
		request.setAttribute("p_categoryList", pCategoryList);
		
		String category = request.getParameter("category");
		request.setAttribute("category", category);
				
		int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page")); 
		String option = request.getParameter("option"); 
		
		GoodsListView goodsListView = null;
		
		try {
			GoodsListService goodsService = new GoodsListService();
			if(category.length() <= 2) {		
				// 카테고리별 상품조회 - 첫화면 추천순
				option = option == null ? "recommend" : request.getParameter("option");
				ArrayList<CategoryDTO> categoryList = goodsService.selectCategoryList(category);
				request.setAttribute("categoryList", categoryList);
				
			} else if(category.equalsIgnoreCase("sale")) {
				// 알뜰상품 조회 - 첫화면 혜택순
				option = option == null ? "sale" : request.getParameter("option");
			} else {
				option = option == null ? "new" : request.getParameter("option");
			}
			
			goodsListView = goodsService.getGoodsList(currentPage, category, option);
			
			request.setAttribute("option", option);
			request.setAttribute("goodsListView", goodsListView);	
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "/goods/goods_list";
		
	}

}

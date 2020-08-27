package shop.main.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.model.ListDTO;
import shop.main.service.MainListService;
import shop.member.model.MemberDTO;

public class MainListHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//System.out.println("> MainListHandler.process() 호출");
		
		// 상위 하위 카테고리 가져오기.. 이거 모든 핸들러에 있어야한다.. OMG..
		MainListService service = new MainListService();
		ArrayList<CCategoryDTO> cCategoryList = service.selectCCategory();
		request.setAttribute("c_categoryList", cCategoryList);
		ArrayList<PCategoryDTO> pCategoryList = service.selectPCategory();
		request.setAttribute("p_categoryList", pCategoryList);
		
		// 추천상품 리스트
		ArrayList<ListDTO> recommendList = service.selectGoodsList("recommend");
		request.setAttribute("recommendList", recommendList);
		
		// 알뜰상품 리스트 가져오기
		ArrayList<ListDTO> saleList = service.selectGoodsList("sale");
		request.setAttribute("saleList", saleList);
		
		// 신상품 리스트 가져오기
		ArrayList<ListDTO> newList = service.selectGoodsList("new");
		request.setAttribute("newList", newList);
		
		// 인기상품 리스트 가져오기
		ArrayList<ListDTO> hotList = service.selectGoodsList("hot");
		request.setAttribute("hotList", hotList);
		
		
		return "/main/index";
	}

}

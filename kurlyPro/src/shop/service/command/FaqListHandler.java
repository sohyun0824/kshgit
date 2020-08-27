package shop.service.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;
import shop.service.model.FaqListView;
import shop.service.service.FaqListService;

public class FaqListHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 상위 하위 카테고리 가져오기
		MainListService mainService = new MainListService();
		ArrayList<CCategoryDTO> cCategoryList = mainService.selectCCategory();
		request.setAttribute("c_categoryList", cCategoryList);
		ArrayList<PCategoryDTO> pCategoryList = mainService.selectPCategory();
		request.setAttribute("p_categoryList", pCategoryList);
		
		// 커맨드핸들러  -> 목록서비스 -> DAO
		// 현재 페이지 ( page ?? )
		String pCurrentPage = request.getParameter("page");
		int currentPage = pCurrentPage == null ? 1: Integer.parseInt(pCurrentPage);
		
		// 카테고리
		// sitemcd=4&sword=
		String sitemcd = request.getParameter("sitemcd");
		if (sitemcd == null || sitemcd.equals("")) {sitemcd="00";}
					
		// 검색조건+검색어 코딩 !!!!!
		String searchWord = request.getParameter("searchWord");
		if (searchWord==null || searchWord.equals("")) {searchWord="*";}
		
		request.setAttribute("searchWord", searchWord);
		
		// 서비스 호출
		FaqListService listService = FaqListService.getInstance();
		
		
		// viewData 모두 담아서 한번에 넘겨주겠다.
		FaqListView viewData =  listService.getFaqList(currentPage, sitemcd, searchWord );
		request.setAttribute("viewData", viewData);
		request.setAttribute("sitemcd", sitemcd);
		
		
		return "/service/faq";
	}

}

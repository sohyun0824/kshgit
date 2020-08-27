package shop.board.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.board.model.NoticeListView;
import shop.board.service.NoticeService;
import shop.controller.CommandHandler;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;

public class NoticeHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 상위 하위 카테고리 가져오기
		MainListService mainService = new MainListService();
		ArrayList<CCategoryDTO> cCategoryList = mainService.selectCCategory();
		request.setAttribute("c_categoryList", cCategoryList);
		ArrayList<PCategoryDTO> pCategoryList = mainService.selectPCategory();
		request.setAttribute("p_categoryList", pCategoryList);
		
		// 페이지
		String pCurrentPage = request.getParameter("page");
		int currentPage = pCurrentPage == null ? 1: Integer.parseInt(pCurrentPage);
		
		// 검색 조건 & 검색어
		String searchCondition = request.getParameter("searchCondition")==null?"1":request.getParameter("searchCondition");
		
		String searchWord = request.getParameter("searchWord");
		if (searchWord==null || searchWord.equals("")) {searchWord=" ";}
		if (searchCondition == null || searchCondition.equals("")  ) {searchCondition="1";}
		request.setAttribute("searchCondition", searchCondition);
		request.setAttribute("searchWord", searchWord);
				
		// 서비스 호출
		NoticeService listService = NoticeService.getInstance();
		
		NoticeListView viewData =  listService.getNoticeList(currentPage, searchCondition, searchWord);
		request.setAttribute("viewData", viewData);
		
		
		return "/board/notice";
	}

}

package shop.board.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.board.model.NoticeDTO;
import shop.board.service.NoticeService;
import shop.controller.CommandHandler;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;

public class NoticeContentHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 상위 하위 카테고리 가져오기
		MainListService mainService = new MainListService();
		ArrayList<CCategoryDTO> cCategoryList = mainService.selectCCategory();
		request.setAttribute("c_categoryList", cCategoryList);
		ArrayList<PCategoryDTO> pCategoryList = mainService.selectPCategory();
		request.setAttribute("p_categoryList", pCategoryList);
		
		//페이지
		String currentPage = request.getParameter("page");
		//공지사항 상세보기
		String currentSeq = request.getParameter("notice");
		
		NoticeService listService = NoticeService.getInstance();
		
		NoticeDTO viewData =  listService.getNoticeContent(currentSeq);
		request.setAttribute("viewData", viewData);
		request.setAttribute("currentPage", currentPage);
		
		return "/board/view";
	}

}

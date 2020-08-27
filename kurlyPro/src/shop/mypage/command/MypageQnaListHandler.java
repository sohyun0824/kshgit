package shop.mypage.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;
import shop.member.model.MemberDTO;
import shop.mypage.model.MypageQnaListView;
import shop.mypage.service.MypageQnaListService;

public class MypageQnaListHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 상위 하위 카테고리 가져오기
		MainListService mainService = new MainListService();
		ArrayList<CCategoryDTO> cCategoryList = mainService.selectCCategory();
		request.setAttribute("c_categoryList", cCategoryList);
		ArrayList<PCategoryDTO> pCategoryList = mainService.selectPCategory();
		request.setAttribute("p_categoryList", pCategoryList);
		
		String pCurrentPage = request.getParameter("page");
		int currentPage = pCurrentPage == null ? 1: Integer.parseInt(pCurrentPage);
				
		// 회원 ID 가져오기
		MemberDTO member = (MemberDTO)request.getSession().getAttribute("member");
		if(member == null) {
			return "/mypage/mypage_qna";
		}
		String m_id = member.getM_id();
		
		// 리스트서비스 호출
		MypageQnaListService listService = MypageQnaListService.getInstance();
		MypageQnaListView viewData = listService.getQnaList(currentPage, m_id);
		
		request.setAttribute("viewData", viewData);
		// 
//		MypageQnaDTO  file_list= (MypageQnaDTO)request.getAttribute("file_dto1");
//		request.setAttribute("file_list", file_list);
//		System.out.println(file_list);
		
		return "/mypage/mypage_qna";
	}

}

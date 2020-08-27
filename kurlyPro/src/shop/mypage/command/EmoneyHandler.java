package shop.mypage.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;
import shop.member.model.MemberDTO;
import shop.mypage.model.EmoneyListView;
import shop.mypage.service.GetEmoneyListService;
import shop.mypage.service.ReviewListService;

public class EmoneyHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// /shop/mypage/mypage_emoney.do?page=1
		System.out.println("EmoneyHandler호출!!");
		
		// 상위 하위 카테고리 가져오기
		MainListService mainService = new MainListService();
		ArrayList<CCategoryDTO> cCategoryList = mainService.selectCCategory();
		request.setAttribute("c_categoryList", cCategoryList);
		ArrayList<PCategoryDTO> pCategoryList = mainService.selectPCategory();
		request.setAttribute("p_categoryList", pCategoryList);	
		
		MemberDTO member = (MemberDTO)request.getSession().getAttribute("member");
		String m_id = member.getM_id();
		
		ReviewListService service = ReviewListService.getInstance();
		
		// 회원이 가진 쿠폰 수 가져오기
		int coupon = service.getCouponCnt(m_id);
		request.setAttribute("coupon", coupon);
		
		// 컬리패스 여부
		int kurlypass = service.getKpass(m_id);
		request.setAttribute("kurlypass", kurlypass);
		
		int currentPage = (request.getParameter("page") == null || request.getParameter("page")=="") ? 1 : Integer.parseInt(request.getParameter("page"));
		
		EmoneyListView emoneyListView = new EmoneyListView();
		
		GetEmoneyListService emoneyListService = GetEmoneyListService.getInstance();
		emoneyListView = emoneyListService.emoneyList(m_id, currentPage);
		
		int res = emoneyListService.sumRes(m_id);
		
		request.setAttribute("list", emoneyListView);
		request.setAttribute("res", res);
		return "/mypage/mypage_emoney";
	}
	
}

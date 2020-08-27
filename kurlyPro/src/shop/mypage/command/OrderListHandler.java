package shop.mypage.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;
import shop.member.model.MemberDTO;
import shop.mypage.model.OrderListView;
import shop.mypage.service.GetOrderListService;
import shop.mypage.service.ReviewListService;

public class OrderListHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
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
		
		// /shop/mypage/mypage_orderlist.do&page=1
		// /shop/mypage/mypage_orderlist.do?period=2020&page=1
		
		// 파라미터로 넘어온 선택기간 가져오기
		int period = (request.getParameter("period")==null || request.getParameter("period")=="") ? 0 : Integer.parseInt(request.getParameter("period"));
		// 현재 페이지 번호 가져오기
		int currentPage = (request.getParameter("page") == null || request.getParameter("page")=="") ? 1 : Integer.parseInt(request.getParameter("page"));
		// 세션에서 회원아이디 가져오기
		//String m_id = (String)request.getSession().getAttribute("m_id");
		
		// 페이지 정보 + 주문내역리스트 정보를 담을 dto
		OrderListView orderListView = null;
		
		// System.out.println("선택기간  : " + period);
		
		System.out.println("> mypage_orderlist.do 요청 : OrderListHandler.process() 호출됨...");

		GetOrderListService orderListService = GetOrderListService.getInstance();
		orderListView = orderListService.select(period, m_id, currentPage);
		
		request.setAttribute("list", orderListView);
		
		return "/mypage/mypage_orderlist";
	}

}

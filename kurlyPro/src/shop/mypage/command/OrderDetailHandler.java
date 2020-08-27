package shop.mypage.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;
import shop.member.model.MemberDTO;
import shop.mypage.model.DeliveryInfoDTO;
import shop.mypage.model.OrderDetailDTO;
import shop.mypage.model.OrderInfoDTO;
import shop.mypage.model.PayInfoDTO;
import shop.mypage.service.GetDeliveryInfoService;
import shop.mypage.service.GetOrderDetailService;
import shop.mypage.service.GetOrderInfoService;
import shop.mypage.service.GetPayInfoService;
import shop.mypage.service.ReviewListService;

public class OrderDetailHandler implements CommandHandler{

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
		
		// /shop/mypage/mypage_orderdetail.do?orderno=
		Long orderno = Long.parseLong(request.getParameter("orderno"));
		System.out.println(orderno);
		System.out.println("> mypage_orderdetail.do 요청 : OrderDetailHandler.process() 호출됨...");
		
		// 주문번호에 해당하는 상세상품내역을 가져오는 서비스
		GetOrderDetailService detailService = GetOrderDetailService.getInstance();
		ArrayList<OrderDetailDTO> list = detailService.viewDetail(orderno);
		request.setAttribute("list", list);
		
		// 주문번호에 해당하는 결제내역을 가져오는 서비스
		GetPayInfoService payInfoService = GetPayInfoService.getInstance();
		PayInfoDTO pay_dto = payInfoService.viewPayInfo(orderno);
		request.setAttribute("pay_dto", pay_dto);
		
		// 주문번호에 해당하는 주문정보를 가져오는 서비스
		GetOrderInfoService orderInfoService = GetOrderInfoService.getInstance();
		OrderInfoDTO order_dto = orderInfoService.viewOrderInfo(orderno);
		request.setAttribute("order_dto", order_dto);
		
		// 주문번호에 해당하는 배송정보를 가져오는 서비스
		GetDeliveryInfoService deliveryInfoservice = GetDeliveryInfoService.getInstance();
		DeliveryInfoDTO delivery_dto = deliveryInfoservice.viewDeliveryInfo(orderno);
		request.setAttribute("delivery_dto", delivery_dto);
		
		return "/mypage/mypage_orderdetail";
	}

}

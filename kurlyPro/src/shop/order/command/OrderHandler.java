package shop.order.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;
import shop.member.model.MemberDTO;
import shop.order.model.CouponDTO;
import shop.order.model.DeliveryDTO;
import shop.order.service.DeliveryService;
import shop.order.service.OrderService;

public class OrderHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 상위 하위 카테고리 가져오기
		MainListService service = new MainListService();
		ArrayList<CCategoryDTO> cCategoryList = service.selectCCategory();
		request.setAttribute("c_categoryList", cCategoryList);
		ArrayList<PCategoryDTO> pCategoryList = service.selectPCategory();
		request.setAttribute("p_categoryList", pCategoryList);
		
		try {
			request.setCharacterEncoding("UTF-8");
			OrderService orderService = new OrderService();
			DeliveryService deliveryService = new DeliveryService();
			MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
			
			ArrayList<CouponDTO> couponList = orderService.selectCoupon(member.getM_id());
			request.setAttribute("coupon", couponList);
			
			DeliveryDTO dto = deliveryService.basicDeliveryInfo(member.getM_id());
			request.setAttribute("basicDelivery", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/order/order";
	}
	
}

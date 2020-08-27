package shop.order.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;
import shop.order.model.OrderListDTO;
import shop.order.service.OrderEndService;

public class OrderEndHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		// 상위 하위 카테고리 가져오기
		MainListService mainservice = new MainListService();
		ArrayList<CCategoryDTO> cCategoryList = mainservice.selectCCategory();
		request.setAttribute("c_categoryList", cCategoryList);
		ArrayList<PCategoryDTO> pCategoryList = mainservice.selectPCategory();
		request.setAttribute("p_categoryList", pCategoryList);
		
		try {
			request.setCharacterEncoding("UTF-8");
			OrderEndService service = new OrderEndService();
			//MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
			System.out.println(request.getParameterMap().size());
			OrderListDTO dto = new OrderListDTO();
			dto.setNo_goods(request.getParameter("no_goods"));
			dto.setDelivery_code(request.getParameter("delivery_code"));
			dto.setUser_no(request.getParameter("user_no"));
			dto.setPay_code(request.getParameter("pay_code"));
			
			String order_no = service.insertOrderList(dto);
			request.setAttribute("order_no", order_no);
			request.setAttribute("settlement_price", request.getParameter("settlement_price"));
			request.setAttribute("add_point", request.getParameter("add_point"));
			
			String[] basket = request.getParameterValues("goodsBasketNo");
			
			for (int i = 0; i < basket.length; i++) {
				int result = service.insertOrderGoods(basket[i], order_no);
				if(result==1) service.deleteBasketGoods(basket[i]);
			}
			
		} catch (Exception e) {
			System.out.println("OrderEndHandler Error...");
			e.printStackTrace();
		}
		
		return "/order/order_end";
	}

}

package shop.order.command;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.member.model.MemberDTO;
import shop.order.model.DeliveryDTO;
import shop.order.service.DeliveryService;

public class DeliveryHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		// 배송지 창 띄우면 get, 배송지 입력 후 저장 누르면 post
		if(request.getMethod().equalsIgnoreCase("GET")) {
			DeliveryService service = new DeliveryService();
			MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
			
			ArrayList<DeliveryDTO> deliveryList = service.selectDeliveryInfo(member.getM_id());
			request.getSession().setAttribute("delivery", deliveryList);
			
			return "/order/order_address";
		}else if(request.getMethod().equalsIgnoreCase("POST")) {
			return processSubmit(request, response);
		}else {
			response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
			return null;			
		}
	}

	private String processSubmit(HttpServletRequest request, HttpServletResponse response) {
		DeliveryService service = new DeliveryService();
		MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
		DeliveryDTO dto = new DeliveryDTO();
		dto.setAddress(request.getParameter("address"));
		dto.setDelivery_type(request.getParameter("deliveryType"));
		dto.setReceiver(request.getParameter("receiverName"));
		dto.setReceiver_tel(request.getParameter("receiverTel"));
		dto.setLoc(request.getParameter("pickUpType"));
		// 받으실 장소 : 경비실 / 택배함 / 기타 장소 면 loc_detail 필수입력
		if(!dto.getLoc().equals("문 앞")) {
			dto.setLoc_detail(request.getParameter("pickUpTypeDetail"));
		}else {
			int meansType = Integer.parseInt(request.getParameter("meansType"));
			switch (meansType) {
			case 1: dto.setFront_door("공동현관 비밀번호"); 
			dto.setEntering_detail(request.getParameter("meansTypeDetail"));	
			break;
			case 2: dto.setFront_door("자유 출입 가능"); 
			break;
			case 3: dto.setFront_door("기타"); 
			dto.setEntering_detail(request.getParameter("meansTypeDetail"));	
			break;
			}
		}
		int msg = Integer.parseInt(request.getParameter("deliveryMessageSendAt"));
		dto.setDelivered_msg(msg==0? "배송직후":"오전7시");
		dto.setM_id(member.getM_id());
		if(request.getParameter("isDefault")==null) {
			dto.setIs_basic(0);
		}else {
			// 기본배송지로 저장하려면 다른 배송지들은 기본배송지 해제 시켜야 함
			service.setDefaultDeliveryInfo(member.getM_id());
			dto.setIs_basic(1);
		}
		
		try {
			int result = service.insertDeliveryInfo(dto);
			System.out.println(result);
			if(result==1) response.sendRedirect("../order/order_address.do");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

}

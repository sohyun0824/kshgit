package shop.mypage.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;
import shop.member.model.MemberDTO;
import shop.mypage.model.GoodsInfoDTO;
import shop.mypage.service.ReviewListService;
import shop.mypage.service.ReviewWriteService;

public class ReviewWriteHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		
		// /shop/goods/goods_review_write.do?goodsno=---&orderno=---
		String goods_no = request.getParameter("goodsno");
		// long order_no = Long.parseLong(request.getParameter("orderno"));
		
		System.out.println("ReviewWriteHandler..");
		
		ReviewWriteService reviewWriteService = ReviewWriteService.getInstance();
		GoodsInfoDTO dto = reviewWriteService.getImgandName(goods_no);
		request.setAttribute("dto", dto);
		
		return "/goods/goods_review_write";
	}

}

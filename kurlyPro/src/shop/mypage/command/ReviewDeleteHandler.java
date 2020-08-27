package shop.mypage.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.mypage.service.ReviewDeleteService;

public class ReviewDeleteHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// /shop/goods/goods_review_delete.do?goods_no=A005001&m_id=jisoooo1111&order_no=1593697751769&reviewed_no=RV00023
		
		System.out.println("ReviewDeleteHandler...");
		
		String goods_no = request.getParameter("goods_no");
		String m_id = request.getParameter("m_id");
		String order_no = request.getParameter("order_no");
		String reviewed_no = request.getParameter("reviewed_no");
		
		String saveDirectory = request.getRealPath("/shop/goods/review_img");
		
		ReviewDeleteService reviewDeleteService = ReviewDeleteService.getInstance();
		reviewDeleteService.reviewDelete(goods_no, m_id, order_no, reviewed_no, saveDirectory);
		
		response.sendRedirect("/kurlyPro/shop/mypage/mypage_review.do?view=after");
		
		return null;
	}

}

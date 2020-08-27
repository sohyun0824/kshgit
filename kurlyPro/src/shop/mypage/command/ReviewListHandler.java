package shop.mypage.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;
import shop.member.model.MemberDTO;
import shop.mypage.model.ReviewAfterDTO;
import shop.mypage.model.ReviewBeforeDTO;
import shop.mypage.service.ReviewListService;

public class ReviewListHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 상위 하위 카테고리 가져오기
		MainListService mainService = new MainListService();
		ArrayList<CCategoryDTO> cCategoryList = mainService.selectCCategory();
		request.setAttribute("c_categoryList", cCategoryList);
		ArrayList<PCategoryDTO> pCategoryList = mainService.selectPCategory();
		request.setAttribute("p_categoryList", pCategoryList);	
		
		// /shop/mypage/mypage_review.do?view=before
		// /shop/mypage/mypage_review.do?view=after
		String mode = request.getParameter("view") == null ? "before" : request.getParameter("view");
		MemberDTO member = (MemberDTO)request.getSession().getAttribute("member");
		String m_id = member.getM_id();
		//System.out.println(m_id);

		ReviewListService service = ReviewListService.getInstance();
		
		// 회원이 가진 쿠폰 수 가져오기
		int coupon = service.getCouponCnt(m_id);
		request.setAttribute("coupon", coupon);
		
		// 컬리패스 여부
		int kurlypass = service.getKpass(m_id);
		request.setAttribute("kurlypass", kurlypass);
		
		// 작성가능후기와 작성완료후기의 개수 각각 가져오기
		int beforeCnt = service.getBeforeCnt(m_id);
		request.setAttribute("beforeCnt", beforeCnt);
		int afterCnt = service.getAfterCnt(m_id);
		request.setAttribute("afterCnt", afterCnt);
		
		if (mode == "before") {
			System.out.println("ReviewListHandler(before)..");
			ArrayList<ReviewBeforeDTO> list = service.selectBeforeReview(m_id);
			request.setAttribute("list", list);
			return "/mypage/mypage_review";
		} else {
			System.out.println("ReviewListHandler(after).."); 
			ArrayList<ReviewAfterDTO> list = service.selectAfterReview(m_id); 
			request.setAttribute("list", list);
			return "/goods/goods_review_after";
		}
	}
	
}

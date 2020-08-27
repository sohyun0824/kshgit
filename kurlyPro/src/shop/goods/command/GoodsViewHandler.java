package shop.goods.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import shop.controller.CommandHandler;
import shop.goods.model.GoodsInfoDTO;
import shop.goods.model.GoodsViewDTO;
import shop.goods.model.ReviewBoardDTO;
import shop.goods.model.ReviewBoardList;
import shop.goods.service.GoodsViewService;
import shop.goods.service.ReviewBoardService;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;

public class GoodsViewHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 상위 하위 카테고리 가져오기
		MainListService mainService = new MainListService();
		ArrayList<CCategoryDTO> cCategoryList = mainService.selectCCategory();
		request.setAttribute("c_categoryList", cCategoryList);
		ArrayList<PCategoryDTO> pCategoryList = mainService.selectPCategory();
		request.setAttribute("p_categoryList", pCategoryList);
		
		String group_no = request.getParameter("group_no");
		request.setAttribute("group_no", group_no);
		
		String choose =request.getParameter("choose") == null ? "1" : request.getParameter("choose");
		int currentPage=request.getParameter("page") == null? 1: Integer.parseInt(request.getParameter("page"));
		
		if(request.getMethod().equalsIgnoreCase("get")) {
			System.out.println("goodsViewHandler get()");
			try {
				GoodsViewService service = new GoodsViewService();
				GoodsViewDTO goods = null;
				List<GoodsInfoDTO> goodsInfo = null;
				List<GoodsViewDTO> relatedgoods = null;
				List<GoodsInfoDTO> goodsDetail = null;
				
				// 고객후기
				ReviewBoardService service2 = new ReviewBoardService();
				List<ReviewBoardDTO> noticelist = null;
				ReviewBoardList reviewBoard = null;
				
				if(group_no != null) {
					goods= service.selectgoodsview(group_no);		// 상품상세에 뿌려지는 그룹의 메인 정보들
					goodsInfo = service.selectgoodsinfo(group_no);	// 상품정보리스트
					relatedgoods = service.selectrelatedgoods(group_no);
					goodsDetail = service.selectgoodsdetail(group_no);
					
					// 고객후기
					noticelist = service2.selectNoticeList();
					reviewBoard = service2.getReviewBoard(currentPage, choose, group_no);
				}
				request.setAttribute("goods", goods);
				request.setAttribute("goodsinfo", goodsInfo);
				request.setAttribute("relatedgoods", relatedgoods);
				request.setAttribute("goodsdetail", goodsDetail);
				
				request.setAttribute("reviewBoard", reviewBoard);
				request.setAttribute("noticelist", noticelist);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return "/goods/goods_view";	
			
		} else if(request.getMethod().equalsIgnoreCase("post")) {
			System.out.println("goodsViewHandler post()");
			
			ReviewBoardService service2 = new ReviewBoardService();
			ReviewBoardList reviewBoard = service2.getReviewBoard(currentPage, choose, group_no);
			
			JSONObject data = JSONObject.fromObject(reviewBoard);
			request.setAttribute("data", data);
			//
			// S->D
			return "/goods/reviewboard_ajax";
		}
		
		return null;
	}

}

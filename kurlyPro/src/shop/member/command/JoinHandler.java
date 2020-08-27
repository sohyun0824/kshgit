package shop.member.command;

import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;
import shop.member.model.MemberDTO;
import shop.member.service.JoinService;

public class JoinHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		// 상위 하위 카테고리 가져오기.. 이거 모든 핸들러에 있어야한다.. OMG..
		MainListService mainService = new MainListService();
		ArrayList<CCategoryDTO> cCategoryList = mainService.selectCCategory();
		request.setAttribute("c_categoryList", cCategoryList);
		ArrayList<PCategoryDTO> pCategoryList = mainService.selectPCategory();
		request.setAttribute("p_categoryList", pCategoryList);
		
		String method = request.getMethod();
		if(method.equalsIgnoreCase("get")) {
			// 회원가입 폼 띄우기
			return "/member/join";
		} else if(method.equalsIgnoreCase("post")) {
			Date birthday = null;
			if(request.getParameter("year") != null) {
				int year = Integer.parseInt(request.getParameter("year"));
				int month = Integer.parseInt(request.getParameter("month"));
				int day = Integer.parseInt(request.getParameter("day"));
				birthday = new Date(year, month-1, day);
			}
			// 입력한 회원정보 dto에 담기
			MemberDTO dto = new MemberDTO();
			dto.setM_id(request.getParameter("m_id"));
			dto.setPwd(request.getParameter("password"));
			dto.setName(request.getParameter("name"));
			dto.setEmail(request.getParameter("email"));
			dto.setTel(request.getParameter("mobileInp"));
			dto.setGender(request.getParameter("sex"));
			dto.setBirthday(birthday);
			dto.setRecommend_id(request.getParameter("recommend_id"));
			dto.setEvent_name(request.getParameter("event_name"));
			dto.setSms_agr(request.getParameter("sms") == "y" ? 1 : 0);
			dto.setEmail_agr(request.getParameter("mailling") == "y" ? 1 : 0);

			// 회원가입 : member 테이블에 회원 insert
			JoinService service = new JoinService();
			int result = service.join(dto);
			
			String location = "/kurlyPro/shop/member/login.do";
			if(result == 1) {
				location += "?join=ok";
			} else {
				location += "?join=fail";
			}
			// 로그인 페이지로 리다이렉트
			response.sendRedirect(location);
		}
		
		return null;
	}

}

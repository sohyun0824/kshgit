package shop.member.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.controller.CommandHandler;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;
import shop.member.model.MemberDTO;
import shop.member.service.LoginService;

public class LoginHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		// 상위 하위 카테고리 가져오기.. 이거 모든 핸들러에 있어야한다.. OMG..
		MainListService mainService = new MainListService();
		ArrayList<CCategoryDTO> cCategoryList = mainService.selectCCategory();
		request.setAttribute("c_categoryList", cCategoryList);
		ArrayList<PCategoryDTO> pCategoryList = mainService.selectPCategory();
		request.setAttribute("p_categoryList", pCategoryList);
		
		String method = request.getMethod();
		
		if(method.equalsIgnoreCase("get")) {
			String join = request.getParameter("join");	// 회원가입 성공 여부
			if(join != null) {
				request.setAttribute("join", join);
			}
			
			// 로그인 폼으로 포워딩
			return "/member/login";
		} else if(method.equalsIgnoreCase("post")) {
			// 실제 로그인 처리 : 아이디, 비밀번호 확인, 세션설정
			String id = request.getParameter("m_id");
			String pw = request.getParameter("password");
			String return_url = request.getParameter("return_url");
			if(return_url == null || return_url.equalsIgnoreCase("null")) {
				return_url = "/kurlyPro/shop/main/index.do";
			}
			//System.out.println(return_url);
			
			LoginService service = new LoginService();
			int result = service.chkLogin(id, pw);
			// 로그인 실패 0, 성공 1
			if(result == 1) {
				MemberDTO dto = service.selectMember(id);
				// 로그인 성공시 해당 회원의 정보를 dto로 넘김
				request.setAttribute("dto", dto);
			}
			
			request.setAttribute("return_url", return_url);
			
			return "/member/login_ok";
		}
		
		return null;
	}

}

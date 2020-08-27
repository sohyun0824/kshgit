package shop.mypage.command;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import shop.controller.CommandHandler;
import shop.main.model.CCategoryDTO;
import shop.main.model.PCategoryDTO;
import shop.main.service.MainListService;
import shop.member.model.MemberDTO;
import shop.mypage.model.MypageQnaDTO;
import shop.mypage.service.MypageQnaWriteService;

public class MypageQnaWriteHandler implements CommandHandler{

   @Override
   public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
      // 상위 하위 카테고리 가져오기
      MainListService mainService = new MainListService();
      ArrayList<CCategoryDTO> cCategoryList = mainService.selectCCategory();
      request.setAttribute("c_categoryList", cCategoryList);
      ArrayList<PCategoryDTO> pCategoryList = mainService.selectPCategory();
      request.setAttribute("p_categoryList", pCategoryList);
      
      // 글쓰기 버튼 눌렀을 때 GET 방식으로 가져와서 글쓰기 저장(제출) 할 때는 POST방식으로 저장
      // 그 이유는 GET방식으로 할 경우 간혹 글이 중복으로 저장되는 경우도 있고 오류가 생김...
      //System.out.println("핸들러 process");
      request.setCharacterEncoding("UTF-8");
      // GET    write.jsp 포워딩
      // POST  ReplyBoardDTO    새글, 답글 저장. list.do 이동.
      if (request.getMethod().equalsIgnoreCase("GET")) {
         
         // 세션 
         /*
           HttpSession session = request.getSession(false); 
           if( session != null && session.getAttribute("auth")) { session.getAttribute("auth).getE }
          */
         
         //글쓰기 페이지 만들어서 이동
         return "/mypage/mypage_qna_write";    
         
      }else if(request.getMethod().equalsIgnoreCase("POST")) {
         System.out.println("핸들러 POST process");
         
         String location = processSubmit(request, response);
         response.sendRedirect(location);
      }else{
         response.sendError( HttpServletResponse.SC_METHOD_NOT_ALLOWED);
      }
      return null;
   }

   // 글쓰기 DB -> 목록 이동..
   private String processSubmit(HttpServletRequest request, HttpServletResponse response) throws IOException {
      System.out.println("processSubmit");
      try {
         request.setCharacterEncoding("UTF-8");
      } catch (UnsupportedEncodingException e) {
         e.printStackTrace();
      }
      // DTO -> 서비스.저장( dto ) -> DAO.저장(dto)
      // list.do 리다이렉트 요청
      
      String saveDirectory = request.getRealPath("/shop/mypage/qna_file");
      System.out.println(saveDirectory);
      //
      File saveDir = new File(saveDirectory);
      if (!saveDir.exists()) { 
         saveDir.mkdirs();
      }
            
   
      int maxPostSize = 1024*1024*5; // 5MB
      String encoding = "UTF-8";
      
      // 중복파일일 경우 뒤에 인덱스 생성
      FileRenamePolicy policy = new DefaultFileRenamePolicy();
      
      //첨부파일 업로드
      MultipartRequest mrequest = null;  
      try {
         mrequest = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
      } catch (IOException e) {
         e.printStackTrace();
      }
      // getParameter : jsp -> handler
      String pq_code = mrequest.getParameter("pq_code");
      String title = mrequest.getParameter("title");
      String pq_type = mrequest.getParameter("pq_type");
      //int order_no = Integer.parseInt(mrequest.getParameter("order_no"));
      String content = mrequest.getParameter("content");
      //int step = Integer.parseInt(mrequest.getParameter("step"));
      String ref = mrequest.getParameter("ref");
      String m_id= mrequest.getParameter("m_id");
      
      // dto객체 생성 & file_list 리스트 선언
      MypageQnaDTO dto = new MypageQnaDTO();
      ArrayList<String> file_list= null;
      
      // 첨부 파일이 있으면 수행
      if (mrequest.getFile("attachFile")!=null) {
         // file_list에 파일첨부한거 담음
         file_list = new ArrayList<String>();
         Enumeration<?> en = mrequest.getFileNames();
         
         while(en.hasMoreElements()) {
            //
            String attachFile = (String) en.nextElement();
                        
            // 오리지널 파일 + 중복파일 경우 인덱스붙여서 저장
            // input='file'타입의 name속성 값이attachFile 값인 애의 systemname값 얻어오기
            String systemFileName = mrequest.getFilesystemName(attachFile);
            String originalFileName = mrequest.getOriginalFileName(attachFile);
            System.out.println(systemFileName);
            
            // systemFileName을 file_list에 추가
            file_list.add(systemFileName);
         }
      }//if
      
      // 글쓰기 정보 dto에 담아서 (mypage_qna.jsp 보내기 위해)
      dto.setPq_code(request.getParameter("pq_code"));
      dto.setTitle(title);
      dto.setPq_type(pq_type);
      dto.setContent(content);
      //
      dto.setFile_list(file_list);
      
      // 회원ID
      MemberDTO member = (MemberDTO)request.getSession().getAttribute("member");
      dto.setM_id(member.getM_id());
      
      //dto.setRef(request.getParameter("ref")); 시퀀스로 처리
      //dto.setM_id(request.getParameter("m_id")); 
      //dto.setOrder_no(Integer.parseInt(request.getParameter("order_no")));    // 고정값 넣어둠
      //dto.setStep(Integer.parseInt(request.getParameter("step")));               // 고정값 넣어둠
               
      // writeService 객체 생성 ->  qnaInsert 정보를 담음
      MypageQnaWriteService writeService = MypageQnaWriteService.getInstance();
      writeService.qnaInsert(dto);
      // ? 
      request.setAttribute("file_dto1", dto);
      
      //
      response.sendRedirect("/kurlyPro/shop/mypage/mypage_qna.do");
      
      return null;
   }

}

//로그인(세션처리)해서 값 불러오기 
//dto.setEmail(request.getParameter("email"));
//dto.폰넘버(request.getParameter("phone"));
/*
* String pq_code = request.getParameter("pq_code"); if (pq_code==null) {
* dto.setStep(0); }else { //답글에 필요한 것 }
* 
* try { MypageQnaWriteService writeservice = new MypageQnaWriteService(); int
* result = writeservice.write(dto); if( result == 1)
* response.sendRedirect("/mypage/mypage_qna"); } catch (Exception e) {
* e.printStackTrace(); }
*/
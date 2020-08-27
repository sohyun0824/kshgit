package shop.mypage.command;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import shop.controller.CommandHandler;
import shop.mypage.model.FileTestDTO;
import shop.mypage.service.ReviewInsertService;

public class ReviewInsertHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 작성한 후기를 후기테이블과 후기이미지 테이블에 각각 insert시키기 위한 핸들러
		// /shop/goods/goods_review_write_ok.do
		// /shop/goods/goods_review_write_ok.do?del=true&goods_no=*&m_id=*&order_no=*
		
		System.out.println("ReviewInsertHandler..");
		
		// 첨부파일 저장 경로
		String saveDirectory = request.getRealPath("/shop/goods/review_img");
		System.out.println("saveDirectory경로 : " + saveDirectory);
		
		// 해당 경로가 없으면 새로 생성
		File saveDir = new File(saveDirectory);
		if(!saveDir.exists())	saveDir.mkdirs();
		
		// 첨부파일 최대 크기 설정
		int maxPostSize = 1024 * 1024 * 5;  // 5MB
		
		String encoding = "UTF-8";
		
		FileRenamePolicy policy = new DefaultFileRenamePolicy();
		
		// mrequest객체가 만들어지면 이미 첨부파일 업로드된 상태 (saveDirectory경로에)
		MultipartRequest mrequest = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
				
		String goods_no = mrequest.getParameter("goodsno");
		Long order_no = Long.parseLong(mrequest.getParameter("orderno"));
		String m_name = mrequest.getParameter("m_name");
		String m_id = mrequest.getParameter("m_id");
		String mode = mrequest.getParameter("mode");
		String subject = mrequest.getParameter("subject");
		String contents = mrequest.getParameter("contents");
		
		// 후기 내용 + 첨부 파일 배열 정보를 담는 dto
		FileTestDTO dto = new FileTestDTO();
		
		// 첨부파일 목록을 저장할 배열
		ArrayList<String> file_list = null;
		
		if (mrequest.getFile("file[]") != null) {
			file_list = new ArrayList<String>();
			Enumeration en = mrequest.getFileNames();
			while(en.hasMoreElements()) {
				String fName = (String)en.nextElement();
				System.out.println(fName);
				// File uploadFile = mrequest.getFile(fName);
				
				// input='file'타입의 name속성 값이 fName값인 애의 systemname값 얻어오기
				String systemFileName = mrequest.getFilesystemName(fName);
				
				file_list.add(systemFileName);
			}
		}
		// 후기글 정보 dto에 담기
		dto.setContents(contents);
		dto.setGoods_no(goods_no);
		dto.setM_id(m_id);
		dto.setM_name(m_name);
		dto.setMode(mode);
		dto.setOrder_no(order_no);
		
		dto.setSubject(subject);
		dto.setFile_list(file_list);
		
		ReviewInsertService reviewInsertService = ReviewInsertService.getInstance();
		reviewInsertService.reviewInsert(dto);
		request.setAttribute("file_dto", dto);
		
		response.sendRedirect("/kurlyPro/shop/mypage/mypage_review.do?view=after");
		
		return null;
	}

}

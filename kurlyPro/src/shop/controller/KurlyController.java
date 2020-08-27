package shop.controller;

import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class KurlyController extends HttpServlet{

	//				< 요청 url, 핸들러객체 >
	private Map<String, CommandHandler> map = new HashMap<String, CommandHandler>();

	@Override
	public void init() throws ServletException {
		String path = getInitParameter("configFile");
		String configFilePath = getServletContext().getRealPath(path);
		Properties prop = new Properties();
		try (FileReader fr = new FileReader(configFilePath)){
			// commandHandler.properties 파일 읽어오기
			prop.load(fr);
		} catch (Exception e) {
			throw new ServletException(e);
		}
		
		Iterator<Object> ir = prop.keySet().iterator();
		while (ir.hasNext()) {
			String url = (String) ir.next();
			String handlerClassName = prop.getProperty(url);
			try {
				// 핸들러 객체 생성
				Class<?> handlerClass = Class.forName(handlerClassName);
				CommandHandler handlerInstance = (CommandHandler) handlerClass.newInstance();
				// 읽어온 정보를 map에 담기
				map.put(url, handlerInstance);
			} catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
				throw new ServletException();
			}
		}
		
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}

	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();	// 요청URI
		if(requestURI.indexOf(request.getContextPath()) == 0) {
			requestURI = requestURI.substring(request.getContextPath().length());
		}
		//System.out.println(requestURI);
		
		CommandHandler handler = map.get(requestURI);	// 핸들러객체(모델)
		String viewPage = null;	// 보여줄 페이지(뷰)
		try {
			viewPage = handler.process(request, response);	// 모든 핸들러의 공통메서드 process를 통해 보여줄 페이지 결정
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 포워딩
		if(viewPage != null) {
			//String prefix = "/WEB-INF/shop";
			String prefix = "/shop";
			String suffix = ".jsp";
			viewPage = String.format("%s%s%s", prefix, viewPage, suffix);
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		}
		
	}


	
}

package mvc.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.ProductDAO;
import mvc.model.ProductDTO;

public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final int LISTCOUNT = 5; 

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		if (command.equals("/ProductListAction.do")) {//등록된 글 목록 페이지 출력하기
			requestProductList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./product/list.jsp");
			rd.forward(request, response);
		}
	}
	
	public void requestProductList(HttpServletRequest request) {
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		request.setAttribute("productList", productList);
	}
}

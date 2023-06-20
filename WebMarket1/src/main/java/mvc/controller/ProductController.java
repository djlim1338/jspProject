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
	
		//if (command.equals("/ProductListAction.do")) { //선택된 글 삭제하기
		if (command.equals("/ProductListAction.pdo")) { //선택된 글 삭제하기
			requestProductList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./product/list.jsp");
			rd.forward(request, response);	
		//}else if (command.equals("/ProductDetailAction.do")) { //선택된 글 삭제하기
		}else if (command.equals("/ProductDetailAction.pdo")) { //선택된 글 삭제하기
			requestProductDetail(request);
			RequestDispatcher rd = request.getRequestDispatcher("./product/detail.jsp");
			rd.forward(request, response);	
		//}else if (command.equals("/ProductAddCartAction.do")) { //선택된 글 삭제하기
		}else if (command.equals("/ProductAddCartAction.pdo")) { //선택된 글 삭제하기
			requestProductAddCart(request);
			RequestDispatcher rd = request.getRequestDispatcher("./product/addCart.jsp");
			rd.forward(request, response);	
		}
	}
	
	public void requestProductList(HttpServletRequest request) {
		
		ProductDAO dao = ProductDAO.getInstance();
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		
		productList = dao.getProductListAll();

		
		request.setAttribute("productList", productList);
	}
	
	public void requestProductDetail(HttpServletRequest request) {
		
		ProductDAO dao = ProductDAO.getInstance();
		ProductDTO product = new ProductDTO();
		
		String productId = (String) request.getParameter("id");
		if(productId != null) product = dao.getProductById(productId);
		else product = null;
		
		request.setAttribute("product", product);
		request.setAttribute("id", productId);
	}
	
	public void requestProductAddCart(HttpServletRequest request) {
		
		ProductDAO dao = ProductDAO.getInstance();
		
		String userId = (String) request.getSession().getAttribute("sessionId");
		String productId = (String) request.getParameter("id");
		int productQuantity = Integer.parseInt(request.getParameter("product_quantity"));
		
		int insertState = 0;

		if(userId != null) insertState = dao.addCart(userId, productId, productQuantity);
		
		request.setAttribute("insertState", insertState);
	}
}

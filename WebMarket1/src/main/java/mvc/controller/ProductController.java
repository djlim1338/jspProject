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
}

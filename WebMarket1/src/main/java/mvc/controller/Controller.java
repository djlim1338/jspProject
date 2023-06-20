package mvc.controller;

import java.io.IOException;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;
import mvc.controller.BoardController_new;
import mvc.controller.ProductController_new;

public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final int LISTCOUNT = 5; 

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		BoardController_new bc = new BoardController_new();
		ProductController_new pc = new ProductController_new();
		
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
	
		if (command.equals("/BoardListAction.do")) {//등록된 글 목록 페이지 출력하기
			bc.requestBoardList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./board/list.jsp");
			rd.forward(request, response);
		} else if (command.equals("/BoardWriteForm.do")) { // 글 등록 페이지 출력하기
			bc.requestLoginName(request);
			RequestDispatcher rd = request.getRequestDispatcher("./board/writeForm.jsp");
			rd.forward(request, response);				
		} else if (command.equals("/BoardWriteAction.do")) {// 새로운 글 등록하기
			bc.requestBoardWrite(request);
			RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");
			rd.forward(request, response);						
		} else if (command.equals("/BoardViewAction.do")) {//선택된 글 상세 페이지 가져오기
			bc.requestBoardView(request);
			RequestDispatcher rd = request.getRequestDispatcher("/BoardView.do");
			rd.forward(request, response);						
		} else if (command.equals("/BoardView.do")) { //글 상세 페이지 출력하기
			RequestDispatcher rd = request.getRequestDispatcher("./board/view.jsp");
			rd.forward(request, response);	
		} else if (command.equals("/BoardUpdateAction.do")) { //선택된 글의 조회수 증가하기
			bc.requestBoardUpdate(request);
			RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");
			rd.forward(request, response);
		}else if (command.equals("/BoardDeleteAction.do")) { //선택된 글 삭제하기
			bc.requestBoardDelete(request);
			RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");
			rd.forward(request, response);				
		}else if (command.equals("/ProductListAction.do")) { //선택된 글 삭제하기
			pc.requestProductList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./product/list.jsp");
			rd.forward(request, response);	
		}else if (command.equals("/ProductDetailAction.do")) { //선택된 글 삭제하기
			pc.requestProductDetail(request);
			RequestDispatcher rd = request.getRequestDispatcher("./product/detail.jsp");
			rd.forward(request, response);	
		}else if (command.equals("/ProductAddCartAction.do")) { //선택된 글 삭제하기
			pc.requestProductAddCart(request);
			RequestDispatcher rd = request.getRequestDispatcher("./product/addCart.jsp");
			rd.forward(request, response);	
		}
	}
}




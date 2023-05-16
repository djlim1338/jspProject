package midterm;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(description = "for temp service", urlPatterns = { "/TempServlet" })

public class TempServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
       
	public TempServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int temp = Integer.parseInt(request.getParameter("temperature"));
		String unit = request.getParameter("unit");
		
		double result = 0;
		
		switch(unit) {
			case "Celsius": result = 5./9.*(temp-32.);break;
			case "Fahrenheit": result = 9.0/5.*temp+32.;break;
		}
		
		response.setContentType("text/html; charset=utf-8"); // content 유형
		PrintWriter out = response.getWriter();
		out.append("<html><body><h2>온도 변환 서블릿</h2><hr>").append("계산 결과: "+Math.round(result)+unit+"</body></html>");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}

package step02.app;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Buy
 */
@WebServlet("/buy")
public class Buy extends HttpServlet {
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get parameters
		String product = request.getParameter("product");
		String count = request.getParameter("count");
		
		// response
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().append(product + "을 " + count + " 개 구매했읍니다.");
	}

}

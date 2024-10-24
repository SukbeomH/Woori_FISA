// step02/app/LoginCheck.java
package step02.app;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginCheck
 */
//<form action="validation" 
@WebServlet("/validation")
public class LoginCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginCheck() {
        super();
        System.out.println("서블릿 실행");
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
//	method="GET">
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		process(request, response);
		response.getWriter().append("GET 방식으로 호출 ");
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
//	method="POST">
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);

		process(request, response); // Body에 값이 들어오기 때문에 
		response.getWriter().append("Post 방식으로 호출 ");
	}
	

	// 공통된 처리 로직을 사용합니다 - 요청 방식이 어떤지만 다를 뿐
	protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 1. 데이터 획득
		//		 아이디 <input type="text" name="id"> <br>
		String id =request.getParameter("id");
//		 비밀번호 <input type="text" name="password"> <br>
		String pw =request.getParameter("password");
		 
		// 2. 응답에 대한 기본 설정
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if (id.equals("master")&&pw.equals("1234")) {
//			Success.java로 가기
			response.sendRedirect("/success"); //  response.getWriter().append("로그인 성공");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/success");
			dispatcher.forward(request, response);
		} else {
//			Fail.java로 가기 
			response.sendRedirect("/fail"); // response.getWriter().append("로그인 실패");

		}
	}


}





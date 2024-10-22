package step02.app;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginCheck
 */
@WebServlet("/validation")
public class LoginCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginCheck() {
        super();
        System.out.println("생성자는 서블릿 컨테이너가 만들어질 때 딱 한번만 호출");
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("GET 방식으로 호출");
		process(request, response);	
		}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// id master, pw 1234 인 경우에만 로그인 가능하도록 
		System.out.println("POST 방식으로 호출");
		process(request, response);	
	}

		
		// 공통된 처리 로직으로 요청방식이 달라도 같게 response를 전달하도록 
	protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			// 1. 데이터 가져오기
			// <input type="text" name="id" : name 변수로 값을 가져옵니다.
			String id = request.getParameter("id");
			String pw = request.getParameter("password");
			
			// 2. 응답에 대한 기본 설정
			response.setContentType("text/html;charset=utf-8");
			
			// 3. 로직에 따라 실제 동작 
			if (id.equals("master") && pw.equals("1234")) { // equals : 자료형, 값 일치 확인하는 메서드
				response.getWriter().append("로그인 성공");
			} else {
				response.getWriter().append("로그인 실패");
			}
	}

}

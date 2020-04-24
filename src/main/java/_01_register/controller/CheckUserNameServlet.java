package _01_register.controller;

import java.io.IOException;
import java.io.Writer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import _01_register.service.MemberService;

// 檢查帳號是否已被註冊
@WebServlet("/register/checkUserName")
public class CheckUserNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");

		Writer os = null;
		os = response.getWriter();

		WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
		MemberService service = ctx.getBean(MemberService.class);

		String userName = request.getParameter("userName");
		if (userName.trim().length() != 0) {
			boolean exist = service.idExists(userName);
			if (!exist) {
				os.write("此帳號可使用");
			} else {
				os.write("此帳號已被使用");
			}
		}
		return;
	}
}
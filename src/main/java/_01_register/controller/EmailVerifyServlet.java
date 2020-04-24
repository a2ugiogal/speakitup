package _01_register.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import _01_register.model.MemberBean;
import _01_register.service.MemberService;

@WebServlet("/EmailVerify")
public class EmailVerifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();
		StringBuilder content = new StringBuilder();
		// 取得信件內連結的queryString
		String queryString = request.getQueryString();

		// 把搜尋字串前面的字拿掉，取得後面的字串方便與資料庫進行比對
		String emailVerifyCode = queryString.replaceAll("emailCode=", "");

		WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
		// 利用getBean取得MemberService 型別的物件
		MemberService memberService = ctx.getBean(MemberService.class);

		MemberBean mb = null;
		System.out.println(emailVerifyCode);

		// 透過service的方法得到與驗證碼相同的MemberBean物件
		mb = memberService.getEmailValid(emailVerifyCode);
//		Integer memberId = mb.getId();
//		System.out.println("memberId = " + memberId);

		// 如果有取得mb物件，就要把資料庫內的表格CheckAuthSuccess(是否驗證成功)改為y(yes)
		if (mb != null) {
			if (mb.getStatus().trim().equals("未驗證")) {
				mb.setStatus("正常");
				;
			}
			memberService.updateMember(mb);
			session.setAttribute("LoginOK", mb);
			System.out.println(mb.getStatus());

		} else {
			content.append("<li>" + "資料發生異常，請再試一次" + "</li>");
		}

		response.sendRedirect("index.jsp");
	}

}

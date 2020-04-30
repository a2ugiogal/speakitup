package com.web.speakitup.controller;


import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.web.speakitup._00_init.GlobalService;
import com.web.speakitup.model.MemberBean;
import com.web.speakitup.service.MemberService;


@Controller
@RequestMapping("/login")
public class LoginController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ServletContext context;
	
	
	
	@GetMapping("/login")
	public String loginForm() {
		return "login/login";
	}
	
	 
	@PostMapping("/checkLogin")
	public String checkData(@RequestParam("memberId") String memberId,
							@RequestParam("password")String password,
							Model model,HttpServletRequest request,HttpServletResponse response,
							HttpSession session) {
		
		//因為如果沒勾會是null 用@RequestParam註釋一定要傳值進來   如果沒有值會當掉  所以需要用過去request的方式去抓
		String rm = request.getParameter("rememberMe");
				
		Cookie cookieUser = null;
		Cookie cookiePassword = null;
		Cookie cookieRememberMe = null;

		if (rm != null) {
			// 如果記住帳密打勾，rm字串裡面就不會是null
			cookieUser = new Cookie("memberId", memberId);
			cookieUser.setMaxAge(30 * 24 * 60 * 60); // cookie存活期一個月
			cookieUser.setPath(context.getContextPath());

			String encodePassword = GlobalService.encryptString(password);
			cookiePassword = new Cookie("password", encodePassword);
			cookiePassword.setMaxAge(30 * 24 * 60 * 60);
			cookiePassword.setPath(context.getContextPath());

			cookieRememberMe = new Cookie("rememberMe", "true");
			cookieRememberMe.setMaxAge(30 * 24 * 60 * 60);
			cookieRememberMe.setPath(context.getContextPath());
		} else {
			// 如果使用者沒有按下記住帳密 就不會保存帳號密碼的cookie
			cookieUser = new Cookie("memberId", memberId);
			cookieUser.setMaxAge(0);
			cookieUser.setPath(context.getContextPath());

			String encodePassword = GlobalService.encryptString(password);
			cookiePassword = new Cookie("password", encodePassword);
			cookiePassword.setMaxAge(0);
			cookiePassword.setPath(context.getContextPath());

			cookieRememberMe = new Cookie("rememberMe", "true");
			cookieRememberMe.setMaxAge(0);
			cookieRememberMe.setPath(context.getContextPath());
		}

		response.addCookie(cookieUser);
		response.addCookie(cookiePassword);
		response.addCookie(cookieRememberMe);	
		
		password = GlobalService.getMD5Endocing(GlobalService.encryptString(password));	
		MemberBean mb = memberService.checkIdPassword(memberId, password);
		
			if(mb == null) {
				model.addAttribute("loginError", "loginError");
				System.out.println("帳密錯誤");
				return "login/login";
			}else {
				String target = (String) session.getAttribute("target");
				session.setAttribute("LoginOK", mb);
				if(target!=null) {
//				System.out.println(mb.getMemberId());
				return "redirect:" + target;
				}else {
				return "redirect:/";
				}
			}		
	}
	
	@GetMapping("/logout")
	public String logout() {
		return "login/logout";
	}
}

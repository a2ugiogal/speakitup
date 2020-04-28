package com.web.speakitup.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.web.speakitup._00_init.GlobalService;
import com.web.speakitup.model.MemberBean;
import com.web.speakitup.service.MemberService;


@Controller
@RequestMapping("/login")
@SessionAttributes("LoginOK")  //此註解可讓LoginOK變成session物件
public class LoginController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ServletContext context;
	
	@GetMapping("login")
	public String loginForm() {

		return "login/login";
	}
	
	@PostMapping("/checkLogin")
	public String checkData(@RequestParam("memberId") String memberId,
							@RequestParam("password")String password,
							@RequestParam("rememberMe")String rm,
							Model model,HttpServletResponse response) {
		
		
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
				model.addAttribute("LoginOK", mb);
				System.out.println(mb.getMemberId());
				return "redirect:/";
			}
		
			
	}
	
	
	@GetMapping("/logout")
	public String logout() {
		return "login/logout";
	}
}

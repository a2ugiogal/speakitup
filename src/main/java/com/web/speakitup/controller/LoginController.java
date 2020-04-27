package com.web.speakitup.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.speakitup.model.MemberBean;
import com.web.speakitup.service.MemberService;


@Controller
@RequestMapping("/login")
public class LoginController {
	
	@Autowired
	MemberService memberService;
	
	
	@GetMapping("login")
	public String loginForm() {

		return "login/login";
	}
	
	@PostMapping("/checkLogin")
	public String checkData(@RequestParam("memberId") String memberId,@RequestParam("password")String password,Model model) {
			MemberBean mb = memberService.checkIdPassword(memberId, password);
				if(mb == null) {
				model.addAttribute("loginError", "loginError");
				System.out.println("帳密錯誤");
				return "login/login";
			}else {
				model.addAttribute("LoginOK", mb);
				return "redirect:../";
			}
		
			
	}
	
}

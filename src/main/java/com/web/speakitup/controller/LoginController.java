package com.web.speakitup.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
		
		
		
		if (memberId == null || memberId.trim().length() == 0) {
			model.addAttribute("AccountEmptyError", "帳號欄必須輸入");
		}
		if (password == null || password.trim().length() == 0) {
			model.addAttribute("PasswordEmptyError", "密碼欄必須輸入");
		}
		
		
			
			return "login/login";
		
//		return "redirect:../";
	}
	
}

package com.web.speakitup.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/login")
public class LoginController {
	
	
	
	
	@GetMapping("login")
	public String loginForm() {

		return "login/login";
	}
}

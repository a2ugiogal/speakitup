package com.web.speakitup._00_init;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	@GetMapping("/")
	public String home() {
		return "index";
	}

	@GetMapping("/aboutUs/contact")
	public String contact() {
		return "aboutUs/contact";
	}
}

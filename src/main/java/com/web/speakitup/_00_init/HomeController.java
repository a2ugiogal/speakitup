package com.web.speakitup._00_init;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.speakitup.service.MemberService;

@Controller
public class HomeController {

	@Autowired
	MemberService memberService;

	@GetMapping("/")
	public String home() {
		return "index";
	}

	@GetMapping("/game")
	public String game(@RequestParam("range") Integer range, Model model) {
		model.addAttribute("range", range);
		return "game/game";
	}

	@GetMapping("/aboutUs/contact")
	public String contact() {
		return "aboutUs/contact";
	}

	@GetMapping("/scheduledWork")
	public String scheduledWork(HttpServletRequest request) {
			System.out.println("123");
		  if (request.getRemoteAddr().equalsIgnoreCase("0:0:0:0:0:0:0:1")) {			  
			  memberService.clearLetteroftheday();
			  memberService.clearSendReplyQuota();
		  }
		return "/";
	}
}

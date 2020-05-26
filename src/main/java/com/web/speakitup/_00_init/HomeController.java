package com.web.speakitup._00_init;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
	
	@GetMapping("/aboutUs/groupInfo")
	public String groupInfo() {
		return "aboutUs/groupInfo";
	}
	
	@GetMapping("/aboutUs/createIdea")
	public String createIdea() {
		return "aboutUs/createIdea";
	}

	@GetMapping("/scheduledWork")
	public void scheduledWork(HttpServletRequest request) {

		  if (request.getRemoteAddr().equalsIgnoreCase("0:0:0:0:0:0:0:1") || request.getRemoteAddr().equalsIgnoreCase("127.0.0.1")) {
			  memberService.clearLetteroftheday();
			  memberService.clearSendReplyQuota();
		  }
	}
}

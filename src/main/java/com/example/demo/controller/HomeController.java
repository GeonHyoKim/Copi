package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.service.ChatService;

import dto.Member;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	
	private HttpSession session;
	private ChatService chatService;


	public HomeController(HttpSession session, ChatService chatService) {
		this.session = session;
		this.chatService = chatService;

	}


	@GetMapping("/")
	public String showRoot() {
		return "redirect:/usr/home/home";
	}
	
	@GetMapping("/usr/home/home")
	public String home(Model model) {
		Member loginedMember = (Member) session.getAttribute("loginedMember");
		if (loginedMember != null) {
		    int jongCount = chatService.getIsRead(loginedMember.getId());
		    model.addAttribute("jongCount", jongCount);
		    
		}
		return "/usr/home/home";
	}
	
	@GetMapping("/usr/home/test")
	public String test() {
		return "/usr/home/test";
	}
	
	
	

}

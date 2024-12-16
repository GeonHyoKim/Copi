package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.service.ChatService;

import dto.Member;
import jakarta.servlet.http.HttpSession;

@Controller
public class JongController {
	private ChatService chatService;
	private HttpSession session;
	
	public JongController(ChatService chatService, HttpSession session) {
		this.chatService = chatService;
		this.session = session;
	}
	
	@GetMapping("/usr/common/jong")
	public String jong(Model model ) {

		Member loginedMember = (Member) session.getAttribute("loginedMember");
		if (loginedMember != null) {
		    int jongCount = chatService.getIsRead(loginedMember.getId());
		    System.out.println("jongCount: " + jongCount); 
		    model.addAttribute("jongCount", jongCount);
		}
		
		return "/usr/common/jong";
	}
	
}

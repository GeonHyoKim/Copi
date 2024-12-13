package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.service.ChatService;
import com.example.demo.service.MemberService;

import dto.Chat;
import dto.Member;
import jakarta.servlet.http.HttpSession;

@Controller
public class ChatController {
	
	private ChatService chatService;
	private MemberService memberService;
	
	private HttpSession session;
	
	public ChatController(ChatService chatService, HttpSession session, MemberService memberService) {
		this.chatService = chatService;
		this.memberService = memberService;
		this.session = session;
	}

	@GetMapping("/usr/chat/chat")
	public String chat(Model model, @RequestParam int receiverId) {
		
		Member loginedMember = (Member) session.getAttribute("loginedMember");
		Member member = memberService.getMemberById(receiverId);
		if (loginedMember == null) {
			model.addAttribute("message", "로그인이 안 되어있습니다.");
			return "/usr/home/fail";
		}
		
		List<Chat> chat = chatService.getChat(loginedMember.getId(), receiverId);
		
		chatService.read(chat, loginedMember.getId());
		
		model.addAttribute("chat", chat);
		model.addAttribute("loginedMember", loginedMember);
		model.addAttribute("member", member);
		return "/usr/chat/chat";
	}
	
	
	@PostMapping("/usr/chat/send")
    public String sendMessage(Model model, @RequestParam int receiverId, @RequestParam String content) {
        Member loginedMember = (Member) session.getAttribute("loginedMember");

        if (loginedMember == null) {
        	model.addAttribute("message", "로그인이 안 되어있습니다.");
            return "redirect:/usr/home/fail";
        }

        chatService.sendMessage(loginedMember.getId(), receiverId, content);
        return "redirect:/usr/chat/chat?receiverId=" + receiverId;
    }
	
	
}

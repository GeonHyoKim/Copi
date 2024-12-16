package com.example.demo.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	private final SimpMessagingTemplate template;
	private HttpSession session;
	
	public ChatController(ChatService chatService, HttpSession session, MemberService memberService, SimpMessagingTemplate template) {
		this.chatService = chatService;
		this.memberService = memberService;
		this.session = session;
		this.template = template;
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
	
	
	@MessageMapping("/messages")
    public Chat sendMessage(Chat message) {
		Member sender = memberService.getMemberById(message.getSenderId());
	    Member receiver = memberService.getMemberById(message.getReceiverId());
        
	    message.setSenderName(sender.getName());
	    message.setReceiverName(receiver.getName());
	    message.setTimestamp(LocalDateTime.now());
	    
		template.convertAndSend("/sub/message", message);
        chatService.sendMessage(message.getSenderId(), message.getReceiverId(), message.getContent());
        return message;
    }
	
	
	
	
	
	
}

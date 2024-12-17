package com.example.demo.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ChatService;

import dto.Chat;
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
	
	@GetMapping("/getUnreadChats")
	@ResponseBody
	public List<Chat> getUnreadChats(Model model ) {

		Member loginedMember = (Member) session.getAttribute("loginedMember");
		
		if (loginedMember != null) {
            // 로그인된 사용자의 id를 이용하여 읽지 않은 메시지 가져오기
            return chatService.getChatIsRead(loginedMember.getId());
        }
        return Collections.emptyList();
	}
	
}

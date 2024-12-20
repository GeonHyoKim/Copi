package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.service.GiftService;
import com.example.demo.service.MessageService;
import com.example.demo.service.PicService;

import dto.Gift;
import dto.GiftPic;
import dto.Member;
import dto.Present;
import jakarta.servlet.http.HttpSession;

@Controller
public class MessageController {

	private MessageService messageService;
	private HttpSession session;
	private GiftService giftService;
	private PicService picService; 

	public MessageController(GiftService giftService, PicService picService, MessageService messageService, HttpSession session) {
		this.messageService = messageService;
		this.session = session;
		this.giftService = giftService;
		this.picService = picService;

	}

	@GetMapping("/usr/message/list")
	public String receivedMessages(Model model) {
		Member loginedMember = (Member) session.getAttribute("loginedMember");

		if (loginedMember == null) {
			model.addAttribute("message", "로그인이 안 되어있습니다.");
			return "/usr/home/fail";
		}

		List<Present> receivedMessages = messageService.getReceivedMessages(loginedMember.getId());
		List<Present> sentMessages = messageService.getSentMessages(loginedMember.getId());
		
		model.addAttribute("sentMessages", sentMessages);
		model.addAttribute("receivedMessages", receivedMessages);
		return "usr/message/list";
	}

	@GetMapping("/usr/message/send")
	public String send(Model model, @RequestParam int receiverId) {
//		List<Gift> gifts = giftService.getGifts();
//
//		for (Gift gift : gifts) {
//			GiftPic giftPic = picService.getPicByGiftId(gift.getId());
//			gift.setGiftPic(giftPic);
//		}
//		
//		model.addAttribute("gifts", gifts);
		model.addAttribute("receiverId", receiverId);
		return "usr/message/send";
	}

	@PostMapping("/usr/message/doSend")
	public String doSend(@RequestParam int receiverId, @RequestParam String content, Model model) {
		if (receiverId == 0) {
	        model.addAttribute("message", "받는 사람 ID가 누락되었습니다.");
	        return "/usr/home/fail";
	    }
		
		Member sender = (Member) session.getAttribute("loginedMember");

		if (sender == null) {
			model.addAttribute("message", "로그인 해주세요.");
			return "/usr/home/fail";
		}

		messageService.sendMessage(sender.getId(), receiverId, content);
		model.addAttribute("message", "쪽지 보내기 성공");
		return "/usr/home/success";
	}

	@GetMapping("/usr/message/detail")
	public String detail(@RequestParam int id, Model model) {
		Present message = messageService.getMessageById(id);

		if (message == null) {
			model.addAttribute("message", "쪽지를 찾을 수 없습니다.");
			return "/usr/home/fail";
		}
		model.addAttribute("message", message);
		return "/usr/message/detail";
	}
	
	
	
}

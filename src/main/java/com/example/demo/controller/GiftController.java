package com.example.demo.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.service.GiftService;
import com.example.demo.service.MemberService;
import com.example.demo.service.PicService;

import dto.Gift;
import dto.GiftPic;
import dto.Member;
import dto.Present;
import jakarta.servlet.http.HttpSession;

@Controller
public class GiftController {
	
	private GiftService giftService;
	private HttpSession session;
	private PicService picService; 
	private MemberService memberService;
	
	public GiftController(GiftService giftService, HttpSession session, PicService picService, MemberService memberService) {
		this.giftService = giftService;
		this.session = session;
		this.picService = picService;
		this.memberService = memberService;
	}
	
	
	@GetMapping("/usr/gift/upload")
	public String upload(Model model) {
//		Member loginedMember = (Member) session.getAttribute("loginedMember");
//		if (loginedMember.getId() != 1) {
//			model.addAttribute("message", "접근 권환이 없습니다.");
//			return "/usr/home/fail";
//		}
		
		return "/usr/gift/upload";
	}
	
	@PostMapping("/usr/gift/doUpload")
	public String doUpload(Model model, String giftName, int price, 
			@RequestParam("giftPic")MultipartFile giftPic) throws IOException {

		giftService.uploadGift(giftName, price);
		int giftId = giftService.getGiftId(giftName);
				
		picService.saveGiftPic(giftId, giftPic);
		
		return "/usr/home/home";
	}
	
	@GetMapping("/usr/gift/GiftList")
	public String list(Model model) {
		List<Gift> gifts = giftService.getGifts();

		for (Gift gift : gifts) {
			GiftPic giftPic = picService.getPicByGiftId(gift.getId());
			gift.setGiftPic(giftPic);
		}
		
		model.addAttribute("gifts", gifts);
		return "usr/gift/GiftList";
	}
	@GetMapping("/usr/gift/send")
	public String send(Model model, @RequestParam int receiverId) {
		Member sessionMember = (Member) session.getAttribute("loginedMember");
		if (sessionMember == null) {
			model.addAttribute("message", "로그인 먼저 해주세요.");
			model.addAttribute("redirectUrl", "/usr/member/login");
			return "/usr/home/fail";
		}
		
		Member sender = memberService.getMember(sessionMember.getId());
		
		List<Gift> gifts = giftService.getGifts();

		for (Gift gift : gifts) {
			GiftPic giftPic = picService.getPicByGiftId(gift.getId());
			gift.setGiftPic(giftPic);
		}
		
		model.addAttribute("sender", sender);
		model.addAttribute("gifts", gifts);
		model.addAttribute("receiverId", receiverId);
		return "usr/gift/send";
	}
	
	@PostMapping("/usr/gift/doSend")
	public String doSend(@RequestParam int receiverId, @RequestParam int presentId, @RequestParam String content, Model model) {
		if (receiverId == 0) {
	        model.addAttribute("message", "받는 사람 ID가 누락되었습니다.");
	        return "/usr/home/fail";
	    }
		Member sessionMember = (Member) session.getAttribute("loginedMember");
		if (sessionMember == null) {
			model.addAttribute("message", "로그인 먼저 해주세요.");
			model.addAttribute("redirectUrl", "/usr/member/login");
			return "/usr/home/fail";
		}
		
		Member sender = memberService.getMember(sessionMember.getId());
		if (sender == null) {
			model.addAttribute("message", "로그인 해주세요.");
			model.addAttribute("redirectUrl", "/usr/member/login");
			return "/usr/home/fail";
		}
		
		Gift gift = giftService.getGiftByid(presentId);
		
		if(sender.getPoint() < gift.getPrice()) {
			model.addAttribute("message", "보유금액이 부족합니다.");
			model.addAttribute("redirectUrl", "/usr/member/list");
			return "/usr/home/fail";
		}
		
		
		giftService.sendPresent(sender.getId(), receiverId, presentId, content);
		giftService.memberPoint(sender.getId(), gift.getPrice());
		
		model.addAttribute("message", "선물 보내기 성공");
		model.addAttribute("redirectUrl", "/usr/gift/list");
		return "/usr/home/success";
	}
	
	@GetMapping("/usr/gift/list")
	public String receivedMessages(Model model) {
		Member loginedMember = (Member) session.getAttribute("loginedMember");

		if (loginedMember == null) {
			model.addAttribute("message", "로그인이 안 되어있습니다.");
			model.addAttribute("redirectUrl", "/usr/member/login");
			return "/usr/home/fail";
		}

		List<Present> receivedPresents = giftService.getReceivedPresent(loginedMember.getId());
		List<Present> sentPresents = giftService.getSentPresent(loginedMember.getId());
		
		model.addAttribute("sentPresents", sentPresents);
		model.addAttribute("receivedPresents", receivedPresents);
		return "usr/gift/list";
	}
	@GetMapping("/usr/gift/detail")
	public String detail(@RequestParam int id, Model model) {
		Present present = giftService.getPresentById(id);

		if (present == null) {
			model.addAttribute("message", "선물과 메세지를 찾을 수 없습니다.");
			model.addAttribute("redirectUrl", "/usr/member/myPage");
			return "/usr/home/fail";
		}
		
		model.addAttribute("present", present);
		return "/usr/gift/detail";
	}
	
}

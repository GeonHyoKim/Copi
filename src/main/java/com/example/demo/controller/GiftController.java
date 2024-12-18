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
import com.example.demo.service.PicService;

import dto.Gift;
import dto.GiftPic;
import jakarta.servlet.http.HttpSession;

@Controller
public class GiftController {
	
	private GiftService giftService;
	private HttpSession session;
	private PicService picService; 

	public GiftController(GiftService giftService, HttpSession session, PicService picService) {
		this.giftService = giftService;
		this.session = session;
		this.picService = picService;
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
		List<Gift> gifts = giftService.getArticles();

		for (Gift gift : gifts) {
			GiftPic giftPic = picService.getPicByGiftId(gift.getId());
			gift.setGiftPic(giftPic);
		}
		
		System.out.println(gifts);
		model.addAttribute("gifts", gifts);
		return "usr/gift/GiftList";
	}
}

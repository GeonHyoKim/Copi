package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

//	private MemberService memberService;
//	private PicService picService;
//
//	public HomeController(MemberService memberService, PicService picService) {
//		this.memberService = memberService;
//		this.picService = picService;
//	}

//	@GetMapping("/usr/home/main")
//	public String showMain(@RequestParam(defaultValue = "1") int memberId,
//			@RequestParam(defaultValue = "1") int currentPicId, Model model) {
//		// 회원과 해당 회원의 사진 리스트를 가져옵니다.
//		Member member = memberService.getMemberById(memberId);
//		List<Pic> pics = picService.getPicById(memberId);
//
//		// 이전 다음 사진을 가져옵니다.
//		Pic prevPic = picService.getPrevPic(memberId, currentPicId);
//		Pic nextPic = picService.getNextPic(memberId, currentPicId);
//
//		// 모델에 이전/다음 사진을 추가
//		model.addAttribute("prevPic", prevPic);
//		model.addAttribute("nextPic", nextPic);
//
//		// 이전/다음 회원 정보
//		Member prevMember = memberService.getPrevMemberId(memberId);
//		Member nextMember = memberService.getNextMemberId(memberId);
//
//		if (prevMember == null) {
//	        model.addAttribute("showPrev", false); // 왼쪽을 숨기기 위한 flag
//	    } else {
//	        model.addAttribute("showPrev", true);
//	    }
//		
//		if (nextMember == null) {
//	        model.addAttribute("showNext", false); // 왼쪽을 숨기기 위한 flag
//	    } else {
//	        model.addAttribute("showNext", true);
//	    }
//
//	    List<Pic> prevMemberPic = prevMember != null ? picService.getPicById(prevMember.getId()) : null;
//	    List<Pic> nextMemberPic = nextMember != null ? picService.getPicById(nextMember.getId()) : null;
//
//		model.addAttribute("prevMember", prevMember);
//		model.addAttribute("nextMember", nextMember);
//		model.addAttribute("prevMemberPic", prevMemberPic);
//		model.addAttribute("nextMemberPic", nextMemberPic);
//
//		model.addAttribute("member", member);
//		model.addAttribute("pics", pics);
//
//		return "usr/home/main";
//	}

	@GetMapping("/")
	public String showRoot() {
		return "redirect:/usr/home/home";
	}
	
	@GetMapping("/usr/home/home")
	public String home() {
		return "/usr/home/home";
	}
	

}

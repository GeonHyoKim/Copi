package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.service.MemberService;
import com.example.demo.service.PointService;

import dto.Member;
import jakarta.servlet.http.HttpSession;

@Controller
public class PointController {
	private PointService pointService;
	private HttpSession session;
	private MemberService memberService;

	public PointController(PointService pointService, HttpSession session, MemberService memberService) {
		this.pointService = pointService;
		this.session = session;
		this.memberService = memberService;
	}

	@GetMapping("/usr/point/point")
	public String point(Model model  ) {
		Member loginedMember = (Member) session.getAttribute("loginedMember");

		if (loginedMember == null) {
			model.addAttribute("message", "로그인 먼저 해주세요.");
			model.addAttribute("redirectUrl", "/usr/member/login");
			return "/usr/home/fail";
		}
		return "/usr/point/point";
	}
	
	@PostMapping("/usr/point/doPointCharge")
	public String doPointCharge(Model model, @RequestParam("point") int point) {
		Member loginedMember = (Member) session.getAttribute("loginedMember");
		
		Member member = memberService.getMember(loginedMember.getId());
		
		pointService.setMemberPoint(point, member.getId());
		
		model.addAttribute("message", "포인트 충전 성공!");
		model.addAttribute("redirectUrl", "/usr/member/myPage");
		return "/usr/home/fail";
	}
	
}

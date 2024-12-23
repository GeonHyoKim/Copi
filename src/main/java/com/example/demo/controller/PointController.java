package com.example.demo.controller;

import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.service.MemberService;
import com.example.demo.service.PointService;
import com.example.demo.service.TossPaymentService;

import dto.Member;
import jakarta.servlet.http.HttpSession;

@Controller
public class PointController {
	private PointService pointService;
	private HttpSession session;
	private MemberService memberService;
	private TossPaymentService tossPaymentService;

	public PointController(PointService pointService, HttpSession session, MemberService memberService,
			TossPaymentService tossPaymentService) {
		this.pointService = pointService;
		this.session = session;
		this.memberService = memberService;
		this.tossPaymentService = tossPaymentService;
	}

	@GetMapping("/usr/point/point")
	public String point(Model model) {
		Member loginedMember = (Member) session.getAttribute("loginedMember");

		if (loginedMember == null) {
			model.addAttribute("message", "로그인 먼저 해주세요.");
			model.addAttribute("redirectUrl", "/usr/member/login");
			return "/usr/home/fail";
		}
		return "/usr/point/point";
	}

	@PostMapping("/usr/point/doPointCharge")
	public String doPointCharge(@RequestParam("point") int point, Model model) {
		Member loginedMember = (Member) session.getAttribute("loginedMember");

		if (loginedMember == null) {
			model.addAttribute("message", "로그인 먼저 해주세요.");
			model.addAttribute("redirectUrl", "/usr/member/login");
			return "/usr/home/fail";
		}

		// 주문 ID 생성 (예: UUID 사용)
		String orderId = UUID.randomUUID().toString();
		String customerName = loginedMember.getName(); // 로그인한 회원의 이름 사용

		// 결제 정보 모델에 추가
		model.addAttribute("point", point);
		model.addAttribute("orderId", orderId);
		model.addAttribute("customerName", customerName);

		return "/usr/point/toss"; 
	}

	@GetMapping("/usr/point/paymentSuccess")
	public String paymentSuccess(@RequestParam Map<String, String> params, Model model) {
		// 결제 검증 로직 구현 (결제 금액, 주문 ID 확인)
		String orderId = params.get("orderId");
		String paymentKey = params.get("paymentKey");
		int amount = Integer.parseInt(params.get("amount"));

		// 결제 검증 API 호출 (토스페이먼츠 API 사용)
		boolean isValid = tossPaymentService.verifyPayment(orderId, paymentKey, amount);
		if (!isValid) {
			model.addAttribute("message", "결제 검증에 실패했습니다.");
			model.addAttribute("redirectUrl", "/usr/member/myPage");
			return "/usr/home/fail";
		}

		// 포인트 충전 처리
		Member loginedMember = (Member) session.getAttribute("loginedMember");

		Member member = memberService.getMember(loginedMember.getId());

		pointService.setMemberPoint(amount, member.getId());
		model.addAttribute("message", "포인트 충전이 완료되었습니다.");
		model.addAttribute("redirectUrl", "/usr/member/myPage");
		return "/usr/home/fail";
	}

	@GetMapping("/usr/point/paymentFail")
	public String paymentFail(Model model) {
		model.addAttribute("message", "결제가 실패했습니다. 다시 시도해주세요.");
		model.addAttribute("redirectUrl", "/usr/member/myPage");
		return "/usr/home/fail";
	}

}

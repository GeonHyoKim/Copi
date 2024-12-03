package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.MemberService;

import dto.Member;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {

	private MemberService memberService;
	private HttpSession session;

	public MemberController(MemberService memberService, HttpSession session) {
		this.memberService = memberService;
		this.session = session;
	}

	@GetMapping("/usr/member/join")
	public String join(Model model) {
		Member loginedMember = (Member) session.getAttribute("loginedMember");

		if (loginedMember != null) {
			model.addAttribute("message", "로그인이 이미 되어있습니다.");
			return "/usr/home/fail";
		}
		return "/usr/member/join";
	}

	@PostMapping("/usr/member/doJoin")
	public String doJoin(Model model, String loginId, String loginPw, String name, int age, String sex, int num, String areaId) {
		memberService.joinMember(loginId, loginPw, name, age, sex, num, areaId);
		model.addAttribute("message", "회원가입 성공.");
		return "/usr/home/success";
	}

	@GetMapping("/usr/member/login")
	public String login(Model model) {
		Member loginedMember = (Member) session.getAttribute("loginedMember");

		if (loginedMember != null) {
			model.addAttribute("message", "로그인이 이미 되어있습니다.");
			return "/usr/home/fail";
		}
		return "/usr/member/login";
	}

	@PostMapping("/usr/member/doLogin")
	public String doLogin(Model model, String loginId, String loginPw) {
		Member member = memberService.getMemberId(loginId);

		if (member == null) {
			model.addAttribute("message", "없는 아이디입니다.");
			return "/usr/home/fail";
		}

		if (!member.getLoginPw().equals(loginPw)) {
			model.addAttribute("message", "비밀번호를 확인해주세요");
			return "/usr/home/fail";
		}
		session.setAttribute("loginedMember", member);

		model.addAttribute("message", "로그인 성공!");
		return "/usr/home/success";
	}
	
	@GetMapping("/usr/member/logout")
	public String logout(Model model) {

		Member loginedMember = (Member) session.getAttribute("loginedMember");

		if (loginedMember == null) {
			model.addAttribute("message", "로그인이 안 되어있습니다.");
			return "/usr/home/fail";
		}

		session.invalidate();
		
		model.addAttribute("message", "로그아웃 성공!");
		return "/usr/home/success";
	}
	
	@GetMapping("/usr/member/myPage")
	public String myPage(Model model) {
		Member member = (Member) session.getAttribute("loginedMember");

		if (member == null) {
			model.addAttribute("message", "로그인 먼저 해주세요.");
			return "/usr/home/fail";
		}

		model.addAttribute("member", member);
		return "usr/member/myPage";
	}
	
	
	@GetMapping("/usr/member/list")
	public String list(Model model) {
		List<Member> members = memberService.getMembers();
		
		model.addAttribute("members", members);
		return "/usr/member/list";
	}
	
	@GetMapping("/usr/member/detail")
	public String detail(Model model, @RequestParam("id")int id) {
		
		Member member = memberService.getMemberById(id);
		
		memberService.increaseView(id);
		
		model.addAttribute("member", member);
		
		return "/usr/member/detail";
	}
	
	@PostMapping("/usr/member/increaseHeart")
	@ResponseBody
	public Map<String, Object> increaseHeart(@RequestParam("id") int id) {
	    Map<String, Object> response = new HashMap<>();
	    
	    try {
	        // 하트 수 증가 메서드 호출
	        memberService.increaseHeart(id);
	        
	        // 성공적으로 하트 수 증가한 후, 새로운 하트 수 반환
	        Member updatedMember = memberService.getMemberById(id);
	        response.put("success", true);
	        response.put("newHeartCount", updatedMember.getHearts());
	    } catch (Exception e) {
	        response.put("success", false);
	    }
	    
	    return response;
	}
	
	


}

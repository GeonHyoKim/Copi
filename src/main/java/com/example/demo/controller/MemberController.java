package com.example.demo.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dao.PicService;
import com.example.demo.service.HeartService;
import com.example.demo.service.MemberService;

import dto.Heart;
import dto.Member;
import dto.Pic;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {

	private MemberService memberService;
	private HeartService heartService;
	private PicService picService;
	private HttpSession session;

	public MemberController(MemberService memberService, HeartService heartService, PicService picService, HttpSession session) {
		this.memberService = memberService;
		this.heartService = heartService;
		this.picService = picService;
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
	public String doJoin(Model model, String loginId, String loginPw, String name, int age, String sex, int num, String areaId, MultipartFile pic) throws IOException {
		memberService.joinMember(loginId, loginPw, name, age, sex, num, areaId);
		Member member = memberService.getMemberId(loginId);
		
		if (!pic.isEmpty()) {
	        picService.savePic(member.getId(), pic);
	    }
		
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
		
		List<Pic> pics = picService.getPicById(member.getId()); 
		
		model.addAttribute("pics", pics);
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
		
		int likeCount = heartService.getLikePointCnt(id);
		
		model.addAttribute("member", member);
		model.addAttribute("likeCount", likeCount);
		
		return "/usr/member/detail";
	}
	
	@GetMapping("/usr/heart/clickLikePoint")
	@ResponseBody
	public String clickLikePoint(@RequestParam int senderId, @RequestParam int receiverId, boolean likePointBtn) {
		int likeCount;

	    if (likePointBtn) {
	        heartService.deleteLikePoint(senderId, receiverId);
	        likeCount = heartService.getLikePointCnt(receiverId);
	        return likeCount + ";좋아요 취소";
	    }

	    heartService.insertLikePoint(senderId, receiverId);
	    likeCount = heartService.getLikePointCnt(receiverId);
	    return likeCount + ";좋아요 추가";
	}
	
	@GetMapping("/usr/heart/getLikePoint")
	@ResponseBody
	public String getLikePoint(int receiverId) {
	    Member member = (Member) session.getAttribute("loginedMember");

	    if (member == null) {
	        return "로그인 해주세요.";
	    }

	    Heart heart = heartService.getLikePoint(member.getId(), receiverId);
	    int likeCount = heartService.getLikePointCnt(receiverId);

	    if (heart != null) {
	        return "좋아요 상태: 이미 좋아요 누름, 총 좋아요 수: " + likeCount;
	    } else {
	        return "좋아요 상태: 좋아요 안 누름, 총 좋아요 수: " + likeCount;
	    }
	}


	
	


}

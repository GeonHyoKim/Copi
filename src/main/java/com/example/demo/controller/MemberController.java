package com.example.demo.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.service.HeartService;
import com.example.demo.service.MemberService;
import com.example.demo.service.PicService;

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

	public MemberController(MemberService memberService, HeartService heartService, PicService picService,
			HttpSession session) {
		this.memberService = memberService;
		this.heartService = heartService;
		this.picService = picService;
		this.session = session;
	}

	// 회원가입
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
	public String doJoin(Model model, String loginId, String loginPw, String name, int age, String sex, int num,
			String areaId, MultipartFile pic) throws IOException {
		memberService.joinMember(loginId, loginPw, name, age, sex, num, areaId);
		Member member = memberService.getMemberId(loginId);

		if (!pic.isEmpty()) {
			picService.savePic(member.getId(), pic);
		}

		model.addAttribute("message", "회원가입 성공.");
		return "/usr/home/success";
	}

	// 로그인
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

	// 로그아웃
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

	// 마이페이지
	@GetMapping("/usr/member/myPage")
	public String myPage(Model model) {
		Member member = (Member) session.getAttribute("loginedMember");

		if (member == null) {
			model.addAttribute("message", "로그인 먼저 해주세요.");
			return "/usr/home/fail";
		}

		int likeCount = heartService.getLikePointCnt(member.getId());
		model.addAttribute("likeCount", likeCount);

		List<Pic> pics = picService.getPicById(member.getId());

		model.addAttribute("pics", pics);
		model.addAttribute("member", member);
		return "usr/member/myPage";
	}

	// 프로필 이미지 가져오기
	@GetMapping("/usr/member/getImage")
	@ResponseBody
	public Resource getImage(String pic) throws IOException {

		return new UrlResource("file:" + "C:/kgh/upload/" + pic);
	}

	// 수정
	@GetMapping("/usr/member/modify")
	public String modify(Model model, int id) {
		Member member = (Member) session.getAttribute("loginedMember");

		if (member == null) {
			model.addAttribute("message", "로그인 먼저 해주세요.");
			return "/usr/home/fail";
		}

		List<Pic> pics = picService.getPicById(member.getId());

		model.addAttribute("pics", pics);
		model.addAttribute("member", member);
		return "usr/member/modify";
	}

	@PostMapping("/usr/member/doModify")
	public String doModify(Model model, int id, String name, int age, String areaId, MultipartFile pic)
			throws IOException {
		Member member = (Member) session.getAttribute("loginedMember");

		if (member == null) {
			model.addAttribute("message", "로그인 먼저 해주세요.");
			return "/usr/home/fail";
		}

		memberService.modifyMember(id, name, age, areaId);

		if (!pic.isEmpty()) {
			picService.savePic(id, pic);
		}

		Member updatedMember = memberService.getMemberById(id);
		session.setAttribute("loginedMember", updatedMember);

		return "redirect:/usr/member/myPage?id=" + id;
	}

	// 삭제
	@GetMapping("/usr/member/picDelete")
	public String picDelete(Model model, int id, int picId) {

		picService.picDelete(picId);

		return "redirect:/usr/member/modify?id=" + id;
	}

	// 회원 리스트
	@GetMapping("/usr/member/list")
	public String list(Model model) {
		List<Member> members = memberService.getMembers();

		model.addAttribute("members", members);
		return "/usr/member/list";
	}

	// 디테일
	@GetMapping("/usr/member/detail")
	public String detail(Model model, @RequestParam("id") int id, HttpSession session) {

		Member loginedMember = (Member) session.getAttribute("loginedMember");
		Member member = memberService.getMemberById(id);
		if (loginedMember != null && loginedMember.equals(member)) {
			return "redirect:/usr/member/myPage"; // 리디렉션
		}
		memberService.increaseView(id);

		int likeCount = heartService.getLikePointCnt(id);

		List<Pic> pics = picService.getPicById(member.getId());

		model.addAttribute("pics", pics);
		model.addAttribute("member", member);
		model.addAttribute("likeCount", likeCount);

		return "/usr/member/detail";
	}

	// 하트누르기
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

	// 하트 가져오기
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
	
	
	@GetMapping("/usr/member/heartRank")
	public String heartRank(Model model) {
		List<Member> rankMembers = heartService.rankHeart3();
	    List<Pic> pics = new ArrayList<>();

	    for (int i = 0; i < rankMembers.size(); i++) {
	        pics.add(picService.getPicByRank(rankMembers.get(i).getId()));
	    }

	    // 1등, 2등, 3등 멤버와 사진 분리
	    Member firstMember = rankMembers.size() > 0 ? rankMembers.get(0) : null;
	    Member secondMember = rankMembers.size() > 1 ? rankMembers.get(1) : null;
	    Member thirdMember = rankMembers.size() > 2 ? rankMembers.get(2) : null;

	    Pic firstPic = pics.size() > 0 ? pics.get(0) : null;
	    Pic secondPic = pics.size() > 1 ? pics.get(1) : null;
	    Pic thirdPic = pics.size() > 2 ? pics.get(2) : null;

	    model.addAttribute("firstMember", firstMember);
	    model.addAttribute("secondMember", secondMember);
	    model.addAttribute("thirdMember", thirdMember);

	    model.addAttribute("firstPic", firstPic);
	    model.addAttribute("secondPic", secondPic);
	    model.addAttribute("thirdPic", thirdPic);

	    int like1stCount = heartService.getLikePointCnt(firstMember.getId());
	    int like2edCount = heartService.getLikePointCnt(secondMember.getId());
	    int like3rdCount = heartService.getLikePointCnt(thirdMember.getId());
	    
	    model.addAttribute("like1stCount", like1stCount);
	    model.addAttribute("like2edCount", like2edCount);
	    model.addAttribute("like3rdCount", like3rdCount);

	    return "/usr/member/heartRank";
	}
	

}

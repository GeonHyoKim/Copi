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
		return "/usr/member/join";
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
	        return "/usr/member/login"; // 로그인 페이지에서 메시지를 표시하도록
	    }

	    if (!member.getLoginPw().equals(loginPw)) {
	        model.addAttribute("message", "비밀번호를 확인해주세요");
	        return "/usr/member/login"; // 로그인 페이지에서 메시지를 표시하도록
	    }
	    session.setAttribute("loginedMember", member);

	    model.addAttribute("message", "로그인 성공!");
	    return "redirect:/usr/home/home"; // 로그인 후 리다이렉트할 페이지
	}


	// 로그아웃
	@GetMapping("/usr/member/logout")
	public String logout(Model model) {
		session.invalidate();

		return "redirect:/usr/home/home";
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
	public String list(Model model, @RequestParam(defaultValue = "전체") String sex) {
	    List<Member> members = memberService.getMembers();
	    
	    if ("전체".equals(sex)) {
	        members = memberService.getMembers();
	    } else {
	        members = memberService.getMembersBySex(sex);
	    }
	    
	    for (Member member : members) {
	        Pic pic = picService.getPicByMemberId(member.getId());
	        member.setPic(pic);
	    }

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
	
	
	@GetMapping("/usr/member/rank")
	public String rank(Model model) {
		//하트 랭커 
		List<Member> heartRankers = heartService.rankHeart3();
	    List<Pic> heartRankerPics = new ArrayList<>();

	    for (int i = 0; i < heartRankers.size(); i++) {
	    	heartRankerPics.add(picService.getPicByRank(heartRankers.get(i).getId()));
	    }

	    // 1등, 2등, 3등 멤버와 사진 분리
	    Member firstHeartRanker = heartRankers.size() > 0 ? heartRankers.get(0) : null;
	    Member secondHeartRanker = heartRankers.size() > 1 ? heartRankers.get(1) : null;
	    Member thirdHeartRanker = heartRankers.size() > 2 ? heartRankers.get(2) : null;

	    Pic HRFirstPic = heartRankerPics.size() > 0 ? heartRankerPics.get(0) : null;
	    Pic HRSecondPic = heartRankerPics.size() > 1 ? heartRankerPics.get(1) : null;
	    Pic HRThirdPic = heartRankerPics.size() > 2 ? heartRankerPics.get(2) : null;

	    model.addAttribute("firstHeartRanker", firstHeartRanker);
	    model.addAttribute("secondHeartRanker", secondHeartRanker);
	    model.addAttribute("thirdHeartRanker", thirdHeartRanker);

	    model.addAttribute("HRFirstPic", HRFirstPic);
	    model.addAttribute("HRSecondPic", HRSecondPic);
	    model.addAttribute("HRThirdPic", HRThirdPic);

	    int like1stCount = heartService.getLikePointCnt(firstHeartRanker.getId());
	    int like2edCount = heartService.getLikePointCnt(secondHeartRanker.getId());
	    int like3rdCount = heartService.getLikePointCnt(thirdHeartRanker.getId());
	    
	    model.addAttribute("like1stCount", like1stCount);
	    model.addAttribute("like2edCount", like2edCount);
	    model.addAttribute("like3rdCount", like3rdCount);
	    
	    //조회수 랭커
	    List<Member> viewsRankers = memberService.viewRanker();
	    List<Pic> viewRankerPics = new ArrayList<>();
	    
	    for (int i = 0; i < viewsRankers.size(); i++) {
	    	viewRankerPics.add(picService.getPicByRank(viewsRankers.get(i).getId()));
	    }
	    
	    Member firstviewsRanker = viewsRankers.size() > 0 ? viewsRankers.get(0) : null;
	    Member secondviewsRanker = viewsRankers.size() > 1 ? viewsRankers.get(1) : null;
	    Member thirdviewsRanker = viewsRankers.size() > 2 ? viewsRankers.get(2) : null;
	    
	    Pic VRFirstPic = viewRankerPics.size() > 0 ? viewRankerPics.get(0) : null;
	    Pic VRSecondPic = viewRankerPics.size() > 1 ? viewRankerPics.get(1) : null;
	    Pic VRThirdPic = viewRankerPics.size() > 2 ? viewRankerPics.get(2) : null;
	    
	    model.addAttribute("firstviewsRanker", firstviewsRanker);
	    model.addAttribute("secondviewsRanker", secondviewsRanker);
	    model.addAttribute("thirdviewsRanker", thirdviewsRanker);

	    model.addAttribute("VRFirstPic", VRFirstPic);
	    model.addAttribute("VRSecondPic", VRSecondPic);
	    model.addAttribute("VRThirdPic", VRThirdPic);
	    
	    return "/usr/member/rank";
	}
	

}

package com.example.demo.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.service.ArticleService;
import com.example.demo.service.PicService;

import dto.Article;
import dto.Member;
import jakarta.servlet.http.HttpSession;

@Controller
public class ArticleController {
	private ArticleService articleService;
	private HttpSession session;
	private PicService picService;

	
	public ArticleController(ArticleService articleService, PicService picService, HttpSession session) {
		this.articleService = articleService;
		this.session = session;

	}
	
	@GetMapping("/usr/article/write")
	public String write(Model model) {
		Member loginedMember = (Member) session.getAttribute("loginedMember");

		if (loginedMember == null) {
			model.addAttribute("message", "로그인 먼저 해주세요.");
			return "/usr/home/fail";
		}
		return "/usr/article/write";
	}
	
	@PostMapping("/usr/article/doWrite")
	public String doWrite(Model model, String title, String body, MultipartFile pic) throws IOException {
		Member loginedMember = (Member) session.getAttribute("loginedMember");

		if (loginedMember == null) {
			model.addAttribute("message", "로그인 먼저 해주세요.");
			return "/usr/home/fail";
		}
		
		if (!pic.isEmpty()) {
			picService.saveArticlePic(loginedMember.getId(), pic);
		}
		
		articleService.writeArticle(loginedMember.getId(), title, body, pic);
		return "redirect:/usr/article/list";
	}
	
	@GetMapping("/usr/article/list")
	public String list(Model model) {
		
		List<Article> articles = articleService.getArticles();
		
		model.addAttribute("articles", articles);
		return "usr/article/list";
	}
	
}

package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ArticleDao;

import dto.Article;

@Service
public class ArticleService {
	
	private ArticleDao articleDao;

	public ArticleService(ArticleDao articleDao) {
		this.articleDao = articleDao;
	}

	public void writeArticle(int id, String title, String body, String pic) {
		articleDao.writeArticle(id, title, body, pic);
	}

	public List<Article> getArticles() {
		return articleDao.getArticles();
	}

}

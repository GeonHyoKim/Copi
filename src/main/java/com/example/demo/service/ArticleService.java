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

	public int writeArticle(int id, String title, String body) {
		articleDao.writeArticle(id, title, body);
		
		return articleDao.getLastInsertedArticleId();
	}

	public List<Article> getArticles() {
		return articleDao.getArticles();
	}

	public Article getArticleById(int id) {
		return articleDao.getArticleById(id);
	}

	public void increaseView(int id) {
		articleDao.increaseView(id);
	}

}

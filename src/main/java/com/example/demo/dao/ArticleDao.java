package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import dto.Article;

@Mapper
public interface ArticleDao {
	
	@Insert("""
			INSERT INTO article
				SET regDate = NOW()
				, updateDate = NOW() 
				, title = #{title}
				, body = #{body}
				, pic = #{pic}
				, memberId = #{id}
			""")
	
	void writeArticle(int id, String title, String body, String pic);

	@Select("""
			SELECT * FROM article
			""")
	List<Article> getArticles();
	
}

package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Article;

@Mapper
public interface ArticleDao {
	
	@Insert("""
			INSERT INTO article
				SET regDate = NOW()
				, updateDate = NOW() 
				, title = #{title}
				, body = #{body}
				, memberId = #{id}
			""")
	
	void writeArticle(int id, String title, String body);
	
	@Select("SELECT LAST_INSERT_ID()")
	int getLastInsertedArticleId();  // 삽입된 마지막 게시글의 ID 반환

	@Select("""
			SELECT * FROM article
			""")
	List<Article> getArticles();
	
	@Select("""
			SELECT * FROM article
				WHERE id = #{id}
			""")
	Article getArticleById(int id);
	
	@Update("""
			UPDATE article
				SET views = views + 1
				WHERE id = #{id}
			""")
	void increaseView(int id);
	
	@Delete("""
			DELETE FROM article
				WHERE id = #{id}
			""")
	void deleteArticle(int id);
	
	@Update("""
			UPDATE article
				SET updateDate = NOW()
				, title = #{title}
				, body = #{body}
				WHERE id = #{id}
			""")
	void modifyArticle(int id, String title, String body);
	
}

package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import dto.ArticlePic;
import dto.GiftPic;
import dto.Pic;

@Mapper
public interface PicDao {

	@Insert("""
			INSERT INTO `pic`
				SET memberId = #{id}
				, pic = #{fileName}
			""")
	void savePic(int id, String fileName);
	
	@Select("""
			SELECT * FROM `pic`
				WHERE memberId = #{id} 
			""")
	List<Pic> getPicById(int id);

	@Select("""
			    SELECT * FROM `pic`
			    WHERE id = #{picId}
			""")
	Pic getPicByIdAndPicId(int picId);

	@Delete("""
			DELETE FROM `pic`
				WHERE id = #{picId}
			""")
	void picDelete(int picId);

	@Select("""
			    SELECT * FROM `pic`
			    WHERE memberId = #{memberId} AND id > #{currentPicId}
			    ORDER BY id ASC
			    LIMIT 1
			""")
	Pic getNextPicByMemberId(int memberId, int currentPicId);

	@Select("""
			    SELECT * FROM `pic`
			    WHERE memberId = #{memberId} AND id < #{currentPicId}
			    ORDER BY id DESC
			    LIMIT 1
			""")
	Pic getPrevPicByMemberId(int memberId, int currentPicId);

	@Select("""
			SELECT *
			FROM pic
			WHERE memberId = #{memberId}
			LIMIT 1
			""")
	Pic getPicByMemberId(@Param("memberId") int memberId);
	
	@Select("""
			SELECT * FROM pic
			""")
	List<Pic> getPics();
	
	@Select("""
			SELECT *
			FROM articlePic
			WHERE articleId = #{articleId}
			LIMIT 1
			""")
	ArticlePic getPicByArticleId(int articleId);
	
	@Select("""
			SELECT * FROM articlePic
				where articleId = #{articleId}
				ORDER BY id DESC
			""")
	List<ArticlePic> getArticlePicById(int articleId);
	
	@Insert("""
			INSERT INTO `articlePic`
				SET articleId = #{articleId}
				, pic = #{fileName}
			""")
	void saveArticlePic(int articleId, String fileName);
	
	
	@Delete("""
	        DELETE FROM articlePic 
			    WHERE id = #{picId}
	    """)
	void deleteArticlePic(int picId);
	
	@Delete("""
			DELETE FROM `articlePic`
				WHERE id = #{picId}
			""")
	void articlePicDelete(int articlePicId);
	
	// 게시물에 해당하는 모든 이미지 삭제
	@Delete("""
	    DELETE FROM articlePic
	    WHERE articleId = #{articleId}
	""")
	void deleteArticlePicsByArticleId(int articleId);
	
	@Delete("""
			DELETE FROM articlePic
				WHERE id = #{picId}
			""")
	void articlePicDeleteById(int picId);
	
	@Select("""
			SELECT * FROM articlePic
				where id = #{picId}
			""")
	ArticlePic articlePicById(int picId);
	
	@Insert("""
			INSERT INTO `giftPic`
				SET giftId = #{giftId}
				, pic = #{fileName}
			""")
	void saveGiftPic(int giftId, String fileName);
	
	@Select("""
			SELECT * FROM giftPic
				WHERE giftId = #{giftId}
			""")
	GiftPic getPicByGiftId(int giftId);

}

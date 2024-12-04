package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

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
	
}

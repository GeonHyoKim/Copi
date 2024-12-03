package com.example.demo.dao;

import java.util.List;

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
	
}

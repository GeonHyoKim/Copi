package com.example.demo.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import dto.Heart;

@Mapper
public interface HeartDao {
	
	@Delete("""
			DELETE FROM heart
				WHERE memberId = #{id}
				AND receiverId = #{receiverId}
			""")
	void deleteLikePoint(int id, int receiverId);
	
	@Insert("""
			INSERT INTO heart
				SET memberId = #{id}
					, receiverId = #{receiverId}
			""")
	void insertLikePoint(int id, int receiverId);
	
	@Select("""
			SELECT *
				FROM heart
				WHERE memberId = #{senderId}
				AND receiverId = #{receiverId}
			""")
	Heart getLikePoint(int senderId, int receiverId);
	
	@Select("""
			SELECT IFNULL(SUM(point), 0)
				FROM heart
				WHERE receiverId = #{receiverId}
			""")
	int getLikePointCnt(int receiverId);
}
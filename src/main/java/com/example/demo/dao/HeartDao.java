package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import dto.Heart;
import dto.Member;

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
			SET memberId = #{id},
			    receiverId = #{receiverId}
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
			SELECT COALESCE(SUM(point), 0)
			FROM heart
			WHERE receiverId = #{receiverId}
			""")
	int getLikePointCnt(int receiverId);

	@Select("""
			SELECT m.*
			FROM heart AS h
			INNER JOIN member AS m
			ON m.id = h.receiverId
			GROUP BY receiverId
			ORDER BY COUNT(receiverId) DESC
			LIMIT #{limit}
			""")
	List<Member> getTopRankedMembers(@Param("limit") int limit);

	@Select("""
			SELECT m.*, COUNT(h.id) AS heartCount
			FROM member m
			LEFT JOIN heart h
			ON m.id = h.receiverId
			GROUP BY m.id
			ORDER BY COUNT(h.id) DESC
			LIMIT #{limit}
			""")
	List<Member> getTopRankedMembersWithHeartCount(@Param("limit") int limi);
}

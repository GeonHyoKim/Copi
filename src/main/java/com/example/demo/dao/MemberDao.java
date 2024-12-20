package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Member;

@Mapper
public interface MemberDao {

	@Insert("""
			INSERT INTO `member`
				SET regDate = NOW()
				, updateDate = NOW()
				, loginId = #{loginId}
				, loginPw = #{loginPw}
				, `name` = #{name}
				, age = #{age}
				, sex = #{sex}
				, num = #{num}
				, areaId = #{areaId}
			""")
	void joinMember(String loginId, String loginPw, String name, int age, String sex, int num, String areaId);

	@Select("""
			SELECT * FROM `member`
				WHERE loginId = #{loginId}
			""")
	Member getMemberId(String loginId);

	@Select("""
			SELECT * FROM `member`
			""")
	List<Member> getMembers();

	@Select("""
			SELECT * FROM `member`
				WHERE id = #{id}
			""")
	Member getMemberById(int id);

	@Update("""
			UPDATE `member`
				SET views = views + 1
				WHERE id = #{id}
			""")
	void increaseView(int id);

	@Update("""
			UPDATE `member`
				SET updateDate = now()
				, name = #{name}
				, age = #{age}
				, areaId = #{areaId}
				WHERE id = #{id}
			""")
	void modifyMember(int id, String name, int age, String areaId);

	@Select("""
			SELECT m.*
			FROM `member` m
			LEFT JOIN heart h ON m.id = h.memberId
			GROUP BY m.id
			ORDER BY COUNT(h.id) DESC
			LIMIT #{limit}
			""")
	List<Member> getRankedMembers(@Param("limit") int limit);

	@Select("""
			SELECT * FROM `member`
				ORDER BY views DESC
				LIMIT #{limit}
			""")
	List<Member> viewRanker(@Param("limit") int limit);

	@Select("""
			    SELECT * FROM `member`
			    WHERE sex = #{sex}
			""")
	List<Member> getMembersBySex(@Param("sex") String sex);
	
	@Select("""
			SELECT * FROM `member`
				WHERE id = #{id}
			""")
	Member getMember(int id);

}

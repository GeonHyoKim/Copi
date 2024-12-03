package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
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
	        SET hearts = hearts + 1
	        WHERE id = #{id}
	        """)
	void increaseHeart(int id);
	
	

	

}

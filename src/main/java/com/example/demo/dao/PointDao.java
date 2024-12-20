package com.example.demo.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface PointDao {
	
	@Update("""
			UPDATE `member`
				SET `point` = `point` + #{point}
				WHERE id = #{id}
			""")
	void setmemberPoint(int point, int id);

}

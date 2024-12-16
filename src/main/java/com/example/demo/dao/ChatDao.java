package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Chat;

@Mapper
public interface ChatDao {

	@Insert("INSERT INTO chat (senderId, receiverId, content, timestamp, isRead) "
			+ "VALUES (#{senderId}, #{receiverId}, #{content}, NOW(), #{isRead})")
	void save(Chat chat);

	@Select("""
			SELECT
			    c.*,
			    sm.name AS senderName,
			    rm.name AS receiverName
			FROM chat AS c
				INNER JOIN member AS sm
					ON c.senderId = sm.id
				INNER JOIN member AS rm
					ON c.receiverId = rm.id
			WHERE
			    (c.senderId = #{id} AND c.receiverId = #{receiverId})
			    OR (c.senderId = #{receiverId} AND c.receiverId = #{id})
			ORDER BY c.`timestamp` ASC;
			""")
	List<Chat> getChat(int id, int receiverId);

	@Update("""
			    UPDATE chat
			    SET isRead = 0
			    WHERE id = #{chatId}
			""")
	void read(@Param("chatId") int chatId);
	
	@Select("""
			SELECT COUNT(*) FROM chat
			WHERE receiverId  = #{receiverId }
			AND isRead = 1;
			""")
	int getIsRead(int receiverId );

}

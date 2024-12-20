package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Gift;
import dto.Present;

@Mapper
public interface GiftDao {

	@Insert("""
			INSERT INTO gift
				SET giftName = #{giftName}
				, price = #{price}
			""")
	void uploadGift(String giftName, int price);

	@Select("""
			SELECT id FROM gift
				WHERE giftName = #{giftName}
			""")
	int getGiftId(String giftName);

	@Select("""
			SELECT * FROM gift
			""")
	List<Gift> getGifts();

	@Insert("""
			INSERT INTO present
				SET senderId = #{id}
				, receiverId = #{receiverId}
				, presentId = #{presentId}
				, content = #{content}
			""")
	void sendPresent(int id, int receiverId, int presentId, String content);

	@Select("""
			SELECT p.*, g.giftName AS giftName, sender.name AS senderName, receiver.name AS receiverName
				FROM present AS p
				JOIN `member` AS sender
				ON p.senderId = sender.id
				JOIN `member` AS receiver
				ON p.receiverId = receiver.id
				JOIN gift AS g
				ON g.id = p.presentId
				WHERE receiverId = #{id}
			""")
	List<Present> getReceivedPresent(int id);

	@Select("""
			SELECT p.*, g.giftName AS giftName, sender.name AS senderName, receiver.name AS receiverName
				FROM present AS p
				JOIN `member` AS sender
				ON p.senderId = sender.id
				JOIN `member` AS receiver
				ON p.receiverId = receiver.id
				JOIN gift AS g
				ON g.id = p.presentId
			    WHERE senderId = #{id}
				""")
	List<Present> getSentPresent(int id);
	
	@Select("""
			SELECT p.*, g.giftName AS giftName, sender.name AS senderName, receiver.name AS receiverName, gp.pic AS giftPic
				FROM present p
				JOIN `member` sender 
				ON p.senderId = sender.id
				JOIN `member` receiver 
				ON p.receiverId = receiver.id
				JOIN gift AS g
				ON g.id = p.presentId
				JOIN giftPic AS gp
				on gp.giftId = g.id  
				WHERE p.id = #{id}
			""")
	Present getPresentById(int id);
	
	@Select("""
			SELECT * FROM gift
				WHERE id = #{presentId}
			""")
	Gift getGiftByid(int presentId);
	
	@Update("""
			UPDATE `member`
				SET `point` = `point` - #{price}
				WHERE id = #{id}
			""")
	void memberPoint(int id, int price);

}

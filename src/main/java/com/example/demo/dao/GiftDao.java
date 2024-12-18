package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import dto.Gift;

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

}

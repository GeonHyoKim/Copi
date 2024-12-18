package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.GiftDao;

import dto.Gift;

@Service
public class GiftService {
	
	private GiftDao giftDao;
	
	public GiftService(GiftDao giftDao) {
		this.giftDao = giftDao;
	}

	public void uploadGift(String giftName, int price) {
		giftDao.uploadGift(giftName, price);
	}

	public int getGiftId(String giftName) {
		return giftDao.getGiftId(giftName);
	}

	public List<Gift> getArticles() {
		return giftDao.getGifts();
	}
}

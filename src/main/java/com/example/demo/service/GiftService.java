package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.GiftDao;

import dto.Gift;
import dto.Present;

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

	public List<Gift> getGifts() {
		return giftDao.getGifts();
	}

	public void sendPresent(int id, int receiverId, int presentId, String content) {
		giftDao.sendPresent(id, receiverId, presentId, content);
	}

	public List<Present> getReceivedPresent(int id) {
		return giftDao.getReceivedPresent(id);
	}

	public List<Present> getSentPresent(int id) {
		return giftDao.getSentPresent(id);
	}

	public Present getPresentById(int id) {
		return giftDao.getPresentById(id);
	}

	public Gift getGiftByid(int presentId) {
		return giftDao.getGiftByid(presentId);
	}

	public void memberPoint(int id, int price) {
		giftDao.memberPoint(id, price);
	}
}

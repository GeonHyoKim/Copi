package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.HeartDao;

import dto.Heart;

@Service
public class HeartService {
	
	private HeartDao heartDao;
	
	public HeartService(HeartDao heartDao) {
		this.heartDao = heartDao;
	}

	public void deleteLikePoint(int senderId, int receiverId) {
		heartDao.deleteLikePoint(senderId, receiverId);
	}

	public void insertLikePoint(int senderId, int receiverId) {
		Heart heart = heartDao.getLikePoint(senderId, receiverId);
	    if (heart == null) {  // 눌리지 않았으면 좋아요 추가
	        heartDao.insertLikePoint(senderId, receiverId);
	    }
	}
	
	public Heart getLikePoint(int senderId, int receiverId) {
		return heartDao.getLikePoint(senderId, receiverId);
	}
	
	public int getLikePointCnt(int receiverId) {
		return heartDao.getLikePointCnt(receiverId);
	}
}

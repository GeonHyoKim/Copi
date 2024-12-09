package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.HeartDao;

import dto.Heart;
import dto.Member;

@Service
public class HeartService {

    private final HeartDao heartDao;

    public HeartService(HeartDao heartDao) {
        this.heartDao = heartDao;
    }

    public void deleteLikePoint(int senderId, int receiverId  ) {
        heartDao.deleteLikePoint(senderId, receiverId);
    }

    public void insertLikePoint(int senderId, int receiverId) {
        heartDao.insertLikePoint(senderId, receiverId);
    }

    public Heart getLikePoint(int senderId, int receiverId ) {
        return heartDao.getLikePoint(senderId, receiverId);
    }

    public int getLikePointCnt(int receiverId) {
        return heartDao.getLikePointCnt(receiverId);
    }

    public List<Member> rankHeart3() {
        return heartDao.getTopRankedMembers(3); // 하트 순으로 상위 3명의 멤버 반환
    }
}

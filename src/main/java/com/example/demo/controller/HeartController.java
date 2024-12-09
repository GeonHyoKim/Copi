package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.HeartService;

import dto.Heart;
import dto.Member;
import jakarta.servlet.http.HttpSession;

@Controller
public class HeartController {

    private HeartService heartService;
    private HttpSession session;

    public HeartController(HeartService heartService, HttpSession session) {
        this.heartService = heartService;
        this.session = session;
    }

    // 하트 누르기 (좋아요 추가/취소)
    @GetMapping("/usr/heart/clickLikePoint")
    @ResponseBody
    public String clickLikePoint(@RequestParam int senderId, @RequestParam int receiverId, boolean likePointBtn) {
        int likeCount;

        if (likePointBtn) {
            heartService.deleteLikePoint(senderId, receiverId);  // 좋아요 취소
            likeCount = heartService.getLikePointCnt(receiverId);
            return likeCount + ";좋아요 취소";
        }

        heartService.insertLikePoint(senderId, receiverId);  // 좋아요 추가
        likeCount = heartService.getLikePointCnt(receiverId);
        return likeCount + ";좋아요 추가";
    }

    // 하트 상태 가져오기 (좋아요 여부 확인)
    @GetMapping("/usr/heart/getLikePoint")
    @ResponseBody
    public String getLikePoint(@RequestParam int receiverId ) {
        Member member = (Member) session.getAttribute("loginedMember");
        
        if (member == null) {
            return "로그인 해주세요.";
        }

        Heart heart = heartService.getLikePoint(member.getId(), receiverId);
        int likeCount = heartService.getLikePointCnt(receiverId);

        if (heart != null) {
            return "좋아요 상태: 이미 좋아요 누름, 총 좋아요 수: " + likeCount;
        } else {
            return "좋아요 상태: 좋아요 안 누름, 총 좋아요 수: " + likeCount;
        }
    }
}
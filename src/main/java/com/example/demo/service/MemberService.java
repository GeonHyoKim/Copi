package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;

import dto.Member;

@Service
public class MemberService {
	
	private MemberDao memberDao;
	
	public MemberService(MemberDao memberDao) {
		this.memberDao = memberDao;
	}
	public void joinMember(String loginId, String loginPw, String name, int age, String sex, int num, String areaId) {
		memberDao.joinMember(loginId, loginPw, name, age, sex, num, areaId);
	}
	public Member getMemberId(String loginId) {
		return memberDao.getMemberId(loginId);
	}
	public List<Member> getMembers() {
		return memberDao.getMembers();
	}
	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}
	public void increaseView(int id) {
		memberDao.increaseView(id);		
	}
	
	public void increaseHeart(int id) {
	    memberDao.increaseHeart(id);
	}

}

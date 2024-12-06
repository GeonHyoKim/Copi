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

	public void modifyMember(int id, String name, int age, String areaId) {
		memberDao.modifyMember(id, name, age, areaId);
	}

	public Member getNextMemberId(int currentId) {
		List<Member> allMembers = memberDao.getMembers(); // 모든 회원을 가져옴
		// currentId 이후의 실제 존재하는 ID를 찾음
		for (int i = 0; i < allMembers.size(); i++) {
			if (allMembers.get(i).getId() > currentId) {
				return allMembers.get(i); // 다음 존재하는 ID를 반환
			}
		}
		return null; // 더 이상 다음 ID가 없으면 현재 ID를 반환
	}

	public Member getPrevMemberId(int currentId) {
		List<Member> allMembers = memberDao.getMembers(); // 모든 회원을 가져옴
		// currentId 이전의 실제 존재하는 ID를 찾음
		for (int i = allMembers.size() - 1; i >= 0; i--) {
			if (allMembers.get(i).getId() < currentId) {
				return allMembers.get(i); // 이전 존재하는 ID를 반환
			}
		}
		return null; // 더 이상 이전 ID가 없으면 현재 ID를 반환
	}

	public List<Member> getRankedMembers(int limit) {
		return memberDao.getRankedMembers(limit);
	}

	public List<Member> viewRanker() {
		return memberDao.viewRanker(3);
	}

	public List<Member> getMembersBySex(String sex) {
		return memberDao.getMembersBySex(sex);
	}

}

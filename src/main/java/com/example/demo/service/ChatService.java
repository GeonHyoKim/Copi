package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ChatDao;

import dto.Chat;

@Service
public class ChatService {

	private ChatDao chatDao;

	public ChatService(ChatDao chatDao) {
		this.chatDao = chatDao;
	}


	public void sendMessage(int senderId, int receiverId, String content) {
        Chat chat = new Chat();
        chat.setSenderId(senderId);
        chat.setReceiverId(receiverId);
        chat.setContent(content);
        chat.setIsRead(1); // 기본값은 읽음 상태로 설정

        chatDao.save(chat); // DB에 저장
    }
	
	public List<Chat> getChat(int id, int receiverId) {
		return chatDao.getChat(id, receiverId);
	}
	
	public void read(List<Chat> chat, int loginedMemberId) {
	    for (Chat c : chat) {
	        if (c.getSenderId() != loginedMemberId && c.getIsRead() == 1) { // 읽지 않은 메시지에 대해서만 업데이트
	            chatDao.read(c.getId());
	        }
	    }
	}
	
}

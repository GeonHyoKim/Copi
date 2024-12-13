package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.MessageDao;

import dto.Message_1;

@Service
public class MessageService {
	private MessageDao messageDao;

	public MessageService(MessageDao messageDao) {
		this.messageDao = messageDao;
	}

	public void sendMessage(int senderId, int receiverId, String content) {
		messageDao.sendMessage(senderId, receiverId, content);
	}

	public List<Message_1> getReceivedMessages(int memberId) {
		return messageDao.getReceivedMessages(memberId);
	}

	public List<Message_1> getSentMessages(int memberId) {
		return messageDao.getSentMessages(memberId);
	}

	public Message_1 getMessageById(int id) {
		return messageDao.getMessageById(id);
	}

}

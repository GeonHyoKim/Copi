package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.MessageDao;

import dto.present;

@Service
public class MessageService {
	private MessageDao messageDao;

	public MessageService(MessageDao messageDao) {
		this.messageDao = messageDao;
	}

	public void sendMessage(int senderId, int receiverId, String content) {
		messageDao.sendMessage(senderId, receiverId, content);
	}

	public List<present> getReceivedMessages(int memberId) {
		return messageDao.getReceivedMessages(memberId);
	}

	public List<present> getSentMessages(int memberId) {
		return messageDao.getSentMessages(memberId);
	}

	public present getMessageById(int id) {
		return messageDao.getMessageById(id);
	}

}

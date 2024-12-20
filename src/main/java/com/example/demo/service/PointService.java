package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.PointDao;

@Service
public class PointService {
	
	private PointDao pointDao;
	
	public PointService(PointDao pointDao) {
		this.pointDao = pointDao;
	}
	
	
	public void setMemberPoint(int point, int id) {
		pointDao.setmemberPoint(point, id);
	}

}

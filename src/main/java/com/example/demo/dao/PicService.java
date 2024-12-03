package com.example.demo.dao;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dto.Pic;

@Service
public class PicService {
	
	
	@Value("${custom.file.dir}")
	private String fileDir;
	
	private PicDao picDao;
	
	public PicService(PicDao picDao) {
		this.picDao = picDao;
	}
	
	public void savePic(int id, MultipartFile pic) throws IOException {
	    if (pic != null && !pic.isEmpty()) {
	        String fileName = saveFile(pic); // 파일 저장
	        picDao.savePic(id, fileName); // DB에 파일 이름 저장
	    }
	}
	
    //사진 파일 저장
    private String saveFile(MultipartFile file) throws IOException {
        String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
        Path savePath = Paths.get(fileDir + File.separator + fileName);

        if (!Files.exists(savePath.getParent())) {
            Files.createDirectories(savePath.getParent());
        }

        file.transferTo(savePath.toFile());
        return fileName;
    }

	public List<Pic> getPicById(int id) {
		return picDao.getPicById(id);
	}
    
    

	
}


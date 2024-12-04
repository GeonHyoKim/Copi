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
	        String fileName = saveFile(pic);
	        picDao.savePic(id, fileName); 
	    }
	}
	
	//v파일 추가
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
	
	
	//v파일 삭제
	public void picDelete(int picId) {
		Pic pic = picDao.getPicByIdAndPicId(picId);
		
		if (pic != null) {
	        String filePath = fileDir + File.separator + pic.getPic();
	        File file = new File(filePath);

	        if (file.exists()) {
	            file.delete();
	        }
	    }
		
		picDao.picDelete(picId);
	}
	
	
}


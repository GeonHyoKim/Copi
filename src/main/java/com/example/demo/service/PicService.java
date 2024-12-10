package com.example.demo.service;

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

import com.example.demo.dao.PicDao;

import dto.ArticlePic;
import dto.Pic;

@Service
public class PicService {

	@Value("${custom.file.dir}")
	private String fileDir;

	private PicDao picDao;

	public PicService(PicDao picDao) {
		this.picDao = picDao;
	}

	public void savePic(int id, MultipartFile[] pics) throws IOException {
		for (MultipartFile pic : pics) {
			if (pic != null && !pic.isEmpty()) {
				String fileName = saveFile(pic);
				picDao.savePic(id, fileName);
			}
		}
	}

	// member or article 사진 추가
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

	// v파일 삭제
	public void picDelete(int picId) {
		Pic pic = picDao.getPicByIdAndPicId(picId);
		String filePath = fileDir + File.separator + pic.getPic();
		File file = new File(filePath);

		// 파일이 존재하면 삭제
		if (file.exists()) {
			file.delete();
		}

		picDao.picDelete(picId);

	}

	public Pic getNextPic(int memberId, int currentPicId) {
		return picDao.getNextPicByMemberId(memberId, currentPicId);
	}

	public Pic getPrevPic(int memberId, int currentPicId) {
		return picDao.getPrevPicByMemberId(memberId, currentPicId);
	}

	public Pic getPicByIdAndPicId(int picId) {
		return picDao.getPicByIdAndPicId(picId);
	}

	public Pic getPicByRank(int memberId) {
		return picDao.getPicByMemberId(memberId);
	}

	public List<Pic> getPics() {
		return picDao.getPics();
	}

	public Pic getPicByMemberId(int id) {
		return picDao.getPicByMemberId(id);
	}

	public void saveArticlePic(int articleId, MultipartFile[] articlePics) throws IOException {
		for (MultipartFile articlePic : articlePics) {
			if (articlePic != null && !articlePic.isEmpty()) {
				String fileName = saveFile(articlePic);
				picDao.saveArticlePic(articleId, fileName);
			}
		}
	}

	public ArticlePic getPicByArticleId(int articleId) {
		return picDao.getPicByArticleId(articleId);
	}

	public List<ArticlePic> getArticlePicById(int id) {
		return picDao.getArticlePicById(id);
	}

	public void deleteArticlePicsByArticleId(int articleId) {
		List<ArticlePic> articlePics = picDao.getArticlePicById(articleId);

		for (ArticlePic articlePic : articlePics) {
			String filePath = fileDir + File.separator + articlePic.getPic();
			File file = new File(filePath);

			// 파일이 존재하면 삭제
			if (file.exists()) {
				file.delete();
			}

			// DB에서 이미지 삭제
			picDao.articlePicDelete(articlePic.getId());
		}

	}

	public void articlePicDeleteById(int picId) {
		ArticlePic articlePic = picDao.articlePicById(picId);
		String filePath = fileDir + File.separator + articlePic.getPic();
		File file = new File(filePath);

		// 파일이 존재하면 삭제
		if (file.exists()) {
			file.delete();
		}

		picDao.articlePicDeleteById(picId);
	}

}

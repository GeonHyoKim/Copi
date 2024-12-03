//package com.example.demo.controller;
//
//import java.io.IOException;
//import java.util.List;
//
//import org.springframework.core.io.UrlResource;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.multipart.MultipartFile;
//
//import com.example.demo.dao.PicService;
//
//import dto.Pic;
//
//@Controller
//public class PicController {
//	private PicService picService;
//	
//	
//	public PicController(PicService picService) {
//		this.picService = picService;
//	}
//
//	@PostMapping("/usr/home/upload")
//	@ResponseBody
//	public String upload(MultipartFile file) {
//		if (file.isEmpty()) {
////			return Util.jsReturn("파일이 선택되지 않았습니다", null);
//		}
//		
//		try {
//			picService.saveFile(file);
//		} catch (IOException e) {
//			e.printStackTrace();
////			return Util.jsReturn("파일을 업로드 하는데 문제가 발생했습니다", null);
//		}
//		
////		return Util.jsReturn("파일 업로드 성공", "/");
//	}
//	
//	@GetMapping("/usr/home/view")
//	public String view(Model model) {
//		
//		List<Pic> files = picService.getFiles();
//		
//		model.addAttribute("files", files);
//		
//		return "usr/home/view";
//	}
//	
//	@GetMapping("/usr/home/file/{fileId}")
//	@ResponseBody
//	public Resource fileLoad(Model model, @PathVariable("fileId") int id) throws IOException {
//		
//		Pic fileDto = picService.getFileById(id);
//		
//		return new UrlResource("file:" + fileDto.getSavedPath());
//	}
//	
//}

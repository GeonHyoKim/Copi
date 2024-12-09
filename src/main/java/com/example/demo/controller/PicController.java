package com.example.demo.controller;

import java.io.IOException;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PicController {
	
//	private PicService picService;
//
//	public PicController(PicService picService) {
//		this.picService = picService;
//	}
	
	
	
	@GetMapping("/usr/pic/getImage")
	@ResponseBody
	public Resource getImage(String pic) throws IOException {

		return new UrlResource("file:" + "C:/kgh/upload/" + pic);
	}
}

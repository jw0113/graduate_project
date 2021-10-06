package com.spring.graduateproject;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//기본 메인 화면
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	// 파일 업로드 요청 들어왔을 경우
	@RequestMapping(value="/upload", method = RequestMethod.GET)
	public String upload() {
		return "fileupload";
	}
	
	@ResponseBody
	// 파일 업로드 후 해당 파일을 가져옴
	// 한글 파일 처리를 위한 produces 속성 추가
	@RequestMapping(value="/upload", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public String uploadcheck(MultipartHttpServletRequest file) {
		System.out.println("/upload POST 요청 발생!");
		System.out.println("param : " + file);
		return "OK";
	}
	
}

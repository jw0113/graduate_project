package com.spring.graduateproject;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.graduateproject.fileupload.model.FileUploadVO;
import com.spring.graduateproject.fileupload.service.IFileService;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private IFileService ifileservice;
	private FileUploadVO vo = new FileUploadVO();
	
	//기본 메인 화면
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "index";
	}
	
	@ResponseBody
	// 파일 업로드 한 파일을 가져옴
	// MultipartResolver : 인코딩 타입이 Multipart인 경우, 파라미터나 파일을 추가적 처리 없이 Multipart형식의 파라미터와 파일 정보를 쉽게 구할 수 있
	@RequestMapping(value="/upload", method = RequestMethod.POST)
	public String uploadcheck(MultipartHttpServletRequest file) {
		
		
		// Multipart로 읽어온 파일들 저장
		Iterator<String> filelist = file.getFileNames();
		String re = null;
		//받은 파일을 모두 불러온다.
		while(filelist.hasNext()) {
			MultipartFile f = file.getFile(filelist.next());
			int size = (int)f.getSize();
			try {
				// 파일의 크기 보냄
				re = ifileservice.SizeCon(f,size);
				if(re == "fail") break;
				
				try {
					String data = new String(f.getBytes());
					vo.setFilename(f.getOriginalFilename());
					//vo.setData(data);
					// 기존 파일 db저장
					//ifileservice.uploadOriginalfile(f.getOriginalFilename(),data);
					
					// 탐지&해제 데이터 db저장 - vo같이 넘기자
					ifileservice.uploadResultfile(vo, re);
					
					
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
			} catch(IllegalStateException e) {
				e.printStackTrace();
			}

		}
		System.out.println("re의 값 : " + re);
		if(re == "fail") {
			return "fail";
		}
		else {
			return re;
		}
	}

	@RequestMapping(value = "/uploadfile", method = RequestMethod.POST)
	public String resulticon(@RequestBody String result, HttpSession session) {
		System.out.println("받은 값 : "+ result.length());
		session.setAttribute("result", result);
		return "/uploadfile";
	}

	
	
}
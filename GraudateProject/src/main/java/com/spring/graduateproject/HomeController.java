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
	public String home() {
		
		// fileupload db 삭제 후 시작
		//ifileservice.deleteUploadfile();
		
		return "mainhome";
	}
	
	//기본 메인 화면2
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {

		// fileupload db 삭제 후 시작
		//ifileservice.deleteUploadfile();

		return "main";
	}
	
	// fileupload 화면
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index() {
		
		// fileupload db 삭제 후 시작
		ifileservice.deleteUploadfile();

		return "index";
	}
	
	@ResponseBody
	// 파일 업로드 한 파일을 가져옴
	// MultipartResolver : 인코딩 타입이 Multipart인 경우, 파라미터나 파일을 추가적 처리 없이 Multipart형식의 파라미터와 파일 정보를 쉽게 구할 수 있음
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

					// 기존 파일 db저장
					ifileservice.uploadOriginalfile(f.getOriginalFilename(),data);
					
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
		if(re == "fail") {
			return "fail";
		}
		else {
			return re;
		}
	}
	
	// 탐지&해제 버튼 result 화면 보기
	@RequestMapping(value = "/result1", method = RequestMethod.GET)
	public String result1(Model model) {
		
		// upload한 파일 개수와 파일 명 가져오기
		List<FileUploadVO> dbfilelist = ifileservice.uploadFileCheck();
		model.addAttribute("result", dbfilelist);
		return "result1";
	}
	
	// 선택한 파일의 탐지&해제 결과 화면 보기
	@RequestMapping(value = "/result2", method = RequestMethod.GET)
	public String result2(String filename, Model model) {
		
		// 선택한 파일명을 기준으로 db에서 원래 코드 받아오기
		String originalCode = ifileservice.selectFileNameOri(filename);
		// 선택한 파일명을 기준으로 db에서 해제 코드 받아오기
		List<FileUploadVO> dbresultlist = ifileservice.selectFileName(filename);
		for(int i=0; i<dbresultlist.size(); i++) {
			System.out.println(dbresultlist.get(i).toString());
		}
		
		
		//System.out.println("originalCode : " + originalCode);
		model.addAttribute("data", originalCode);
		model.addAttribute("dbresult", dbresultlist);
		
		return "result2";
	}
	
}
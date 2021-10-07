package com.spring.graduateproject;

import java.util.Iterator;

import org.springframework.web.multipart.MultipartFile;


public interface IFileService {
	
	// python 서버에 파일 전송
	void sendToserver(MultipartFile f);
	
	//python 서버에 파일서 파일 받기
	

}

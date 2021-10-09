package com.spring.graduateproject;

import java.io.BufferedOutputStream;
import java.util.Iterator;

import org.springframework.web.multipart.MultipartFile;


public interface IFileService {
	
	// python 서버에 파일 전송
//	void sendToserver(MultipartFile f);
	
	// 서버 연결
	void Connect(MultipartFile f, BufferedOutputStream bufferout);
	
	// 데이터 사이즈 연결
	void SizeCon(MultipartFile f, int size);
	

}

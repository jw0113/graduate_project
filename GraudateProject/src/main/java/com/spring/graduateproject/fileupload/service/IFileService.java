package com.spring.graduateproject.fileupload.service;

import java.io.BufferedOutputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.util.Iterator;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.graduateproject.fileupload.model.FileUploadVO;


public interface IFileService {
	
	// python 서버에 파일 전송
//	void sendToserver(MultipartFile f);
	
	// 서버 연결
	void Connect(MultipartFile f, Socket socket);
	
	// 데이터 사이즈 연결
	String SizeCon(MultipartFile f, int size);
	
	// 기존 파일 db 저장
	void uploadOriginalfile(String filename, String data);
	
	// 탐지&해제 결과 db 저장
	void uploadResultfile(FileUploadVO vo, String result);
	
	// upload한 파일명과 갯수 가져오기
	List<FileUploadVO> uploadFileCheck();
	

	

}

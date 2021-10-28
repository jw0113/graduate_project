package com.spring.graduateproject.fileupload.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.graduateproject.fileupload.model.FileUploadVO;

public interface IFileUploadMapper {
	
	// db 내용 총 갯수 확인
	int total();
	
	// 업로드한 기존 파일 db 저장
	void uploadOriginalfile(@Param("index") int index, @Param("filename") String filename, @Param("data") String data);
	
	// 탐지&해제 내용 db 저장
	void uploadResultfile(FileUploadVO vo);
	
	// 업로드한 기존 파일 불러오기
	List<FileUploadVO> uploadFileCheck();
	
	// 해당 파일명에 대한 해제&탐지 불러오기
	List<FileUploadVO> uploadFileData(String filename);
	
	// 해당 파일명에 대한 원래 코드 불러오기
	String selectFileNameOri(String filename);


}

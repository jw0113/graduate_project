package com.spring.graduateproject.fileupload.repository;

import org.apache.ibatis.annotations.Param;

import com.spring.graduateproject.fileupload.model.FileUploadVO;

public interface IFileUploadMapper {
	
	// db 내용 총 갯수 확인
	int total();
	
	// 업로드한 기존 파일 db 저장
	void uploadOriginalfile(@Param("index") int index, @Param("filename") String filename, @Param("data") String data);
	
	// 탐지&해제 내용 db 저장
	void uploadResultfile(FileUploadVO vo);


}

package com.spring.graduateproject.file.service;

import java.util.List;

import com.spring.graduateproject.file.model.FileVO;

public interface IFilesService {
	
	// file db에서 전체 내용 가져오기
	List<FileVO> selectAll();
	
	// 인덱스에 해당하는 파일 상세보기
	FileVO selectOne(int index);

}

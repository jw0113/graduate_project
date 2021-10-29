package com.spring.graduateproject.file.repository;

import java.util.List;

import com.spring.graduateproject.file.model.FileVO;

public interface IFileMapper {
	
	// file db 데이터 전체 불러오기
	List<FileVO> selectAll();
	
	// index 해당 데이터 불러오기
	FileVO selectOne(int index);

}

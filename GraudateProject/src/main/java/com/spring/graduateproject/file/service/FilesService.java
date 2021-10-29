package com.spring.graduateproject.file.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.graduateproject.file.model.FileVO;
import com.spring.graduateproject.file.repository.IFileMapper;

@Service
public class FilesService implements IFilesService {
	
	@Autowired
	private IFileMapper mapper;
	
	// file db 전체 데이터 가져오기
	@Override
	public List<FileVO> selectAll(){
		return mapper.selectAll();
	}
	
	// index에 해당하는 데이터 가져오기
	@Override
	public FileVO selectOne(int index) {
		return mapper.selectOne(index);
	}
	
}

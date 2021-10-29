package com.spring.graduateproject.file.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.graduateproject.file.model.FileVO;
import com.spring.graduateproject.file.service.IFilesService;

@Controller
public class FileController {
	
	@Autowired
	private IFilesService ifilesservice;
	private FileVO vo = new FileVO();
	
	//기본 메인 화면
	@RequestMapping(value = "/filelist", method = RequestMethod.GET)
	public String filelist(Model model) {
		
		// file db에서 데이터 가져오기
		List<FileVO> filelist = ifilesservice.selectAll();
		model.addAttribute("dbdata", filelist);

		return "file/filelist";
	}
	
	// file 상세보기
	@RequestMapping(value="/filedetail", method = RequestMethod.GET)
	public String filedetail(int index, Model model) {
		
		// 헤당 index의 데이터 가져오기
		vo = ifilesservice.selectOne(index);
		model.addAttribute("filedetail", vo);
		
		return "file/filedetail";
	}

}

package com.spring.graduateproject.file.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.graduateproject.file.model.FileVO;
import com.spring.graduateproject.file.service.IFilesService;

@Controller
public class FileController {
	
	@Autowired
	private IFilesService ifilesservice;
	private FileVO vo = new FileVO();
	
	// filelist 요청 처리
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
	
	// base64 요청 처리
	@RequestMapping(value="/base64", method = RequestMethod.GET)
	public String base64() {
		return "base64/inputbase64";
	}
	
	// encode 요청 처리
	@RequestMapping(value="/encode", method = RequestMethod.POST)
	public String encode( String inputbase64, RedirectAttributes re) {
		
		// encode 진행
		String encode_check = ifilesservice.encodeCheck(inputbase64);
		re.addFlashAttribute("encode_result", encode_check);
		
		return "redirect:/base64";
	}
	
	// decode 요청 처리
	@RequestMapping(value="/decode", method = RequestMethod.POST)
	public String decode(String inputbase64, RedirectAttributes re) {
		
		// decode 진행
		String decode_check = ifilesservice.decodeCheck(inputbase64);
		re.addFlashAttribute("decode_result", decode_check);
		
		return "redirect:/base64";
	}
	

}

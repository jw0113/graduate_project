package com.spring.graduateproject.url.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.graduateproject.url.service.IUrlService;

@Controller
public class URLController {
	
	@Autowired
	private IUrlService iurlservice;
	
	// url 요청 처리
	@RequestMapping(value = "/url", method = RequestMethod.GET)
	public String url(Model model) {

		return "url/inputurl";
	}
	
	// input url에 대한 결과 처리
	@RequestMapping(value = "/inputurl", method = RequestMethod.POST)
	public String inputurl(String inputurl, RedirectAttributes re) {
		System.out.println("url : " + inputurl);
		
		// url check
		double percent = iurlservice.urlCheck(inputurl);
		System.out.println("percent : " + percent);

		re.addFlashAttribute("percent", percent);
		
		return "redirect:/url";
	}
}

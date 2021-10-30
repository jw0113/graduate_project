package com.spring.graduateproject.file.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
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
	
	// encode 할 수 있는 문자열인지 확인
	@Override
	public String encodeCheck(String inputstr) {
		Socket socket;
		String ip = "127.0.0.1";
		int port = 5000;
		
		OutputStream outputstream;
		InputStream inputstream;
		BufferedOutputStream bufferout;
		BufferedInputStream bufferin;
		
		try {
			socket = new Socket(ip,port);
			System.out.println("Connect Success");
			
			outputstream = socket.getOutputStream();
			inputstream = socket.getInputStream();
			bufferout = new BufferedOutputStream(outputstream);
			bufferin = new BufferedInputStream(inputstream);
			
			bufferout.write(Integer.toString(0).getBytes());
			bufferout.flush();
			
			String encode_result = "";
			while(true) {
				if (bufferin.read() == 1) {
					bufferout.write(inputstr.getBytes());
					bufferout.flush();
					
				}
				
				if (bufferin.read() > 0) {
					byte[] in = new byte[3000];
					encode_result += new String(in,0,bufferin.read(in));
					
				}
				
				if (bufferin.read() < 0) {
					break;
				}
			}
			
			bufferout.close();
			bufferin.close();
			socket.close();
			
			return encode_result;
			
			
		} catch (Exception e) {
			System.out.println("Connect Fail");
			e.printStackTrace();
			return "fail";
		}

	}
	
}

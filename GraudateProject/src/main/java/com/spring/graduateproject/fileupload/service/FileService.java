package com.spring.graduateproject.fileupload.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.Socket;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.graduateproject.fileupload.model.FileUploadVO;
import com.spring.graduateproject.fileupload.repository.IFileUploadMapper;



@Service
public class FileService implements IFileService {
	
	@Autowired
	private IFileUploadMapper mapper;
	
	// 수신 데이터 사이즈 전송
	@Override
	public String SizeCon(MultipartFile f, int size) {
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

			bufferout.write(Integer.toString(size).getBytes());
			bufferout.flush();
			System.out.println("보낸 사이즈 : " + size);
			
			String deob_read = "";
			while(true) {

				// 보낸 데이터의 크기를 받았다는 응답이 왔을 경우에 데이터 내용 보냄
				if (bufferin.read() == 1) {
					Connect(f,socket);
					// System.out.println("Server.. : " + bufferin.read());
				}
				
				// 탐지 & 해제 코드를 받음
				if (bufferin.read() > 0) {
					byte[] in = new byte[9999];
					deob_read += new String(in,0,bufferin.read(in));
					
						
				}
				// server에서 모든 코드를 보냈다면 while문 종료
				if (bufferin.read() <0) {
					//System.out.println("받은 값 : " + bufferin.read());
					break;
				}
			}
			//System.out.println("gg : " + deob_read);
			bufferout.close();
			bufferin.close();
			socket.close();
			return deob_read;

		} catch (Exception e) {
			System.out.println("Connect Fail");
			e.printStackTrace();
			return "fail";
		}
	}
	
	// 파일 전송
	@Override
	public void Connect(MultipartFile f, Socket socket) {
		
		OutputStream out;
		BufferedOutputStream b;
		
		try {
			out = socket.getOutputStream();
			b = new BufferedOutputStream(out);
			
			byte[] fileData = f.getBytes();
			b.write(fileData);
			System.out.println("send file...");
			b.flush();
			
		} catch (Exception e) {
			System.out.println("Connect Fail");
			e.printStackTrace();
		}
	}
	
	// 기존 파일 db 저장
	@Override
	public void uploadOriginalfile(String filename, String data) {
		// db 내용 총 갯수 확인
		int index = mapper.total();
		index += 1;
		// original data 저장
		mapper.uploadOriginalfile(index, filename, data);
	}
	
	// 탐지&해제 result db 저장
	@Override
	public void uploadResultfile(FileUploadVO vo, String result) {
		System.out.println("result값 : "+result);

		result = "{"+result;
		
		// db 내용 총 갯수 확인
		//int index = mapper.total();
		
		try {
			// 탐지&해제 코드 json 파싱 작업
			JSONParser jsonParse = new JSONParser();
			JSONObject jsonObj = (JSONObject) jsonParse.parse(result);
			JSONArray resultArray = (JSONArray) jsonObj.get("result");
			
			
			for(int i =0; i<resultArray.size();i++) {
				JSONObject resultObject = (JSONObject)resultArray.get(i);
				vo.setTitle(String.valueOf(resultObject.get("title")));
				vo.setDescription(String.valueOf(resultObject.get("descriptions")));
				vo.setMatch(String.valueOf(resultObject.get("match")));
				vo.setPosfirst(Integer.valueOf(String.valueOf(resultObject.get("posfirst"))));
				vo.setPoslast(Integer.valueOf(String.valueOf(resultObject.get("poslast"))));
				vo.setDeob(String.valueOf(resultObject.get("deobfuscation")));
				vo.setData(String.valueOf(resultObject.get("data")));
				
				// 탐지&해제 result db 저장
				mapper.uploadResultfile(vo);
			}
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// upload file 파일명과 갯수 가져오기
	@Override
	public List<FileUploadVO> uploadFileCheck(){
		List<FileUploadVO> dbfilelist = mapper.uploadFileCheck();
		
		return dbfilelist;
	}
	
	// 선택한 파일에 대한 탐지&해제 내용 가져오기
	@Override
	public List<FileUploadVO> selectFileName(String filename) {
		
		List<FileUploadVO> result2list = mapper.uploadFileData(filename);
		
		return result2list;
		
	}
	
	// 선택한 파일에 대한 원래 코드 가져오기
	@Override
	public String selectFileNameOri(String filename) {
		return mapper.selectFileNameOri(filename);
	}
	
	// fileupload db 데이터 삭제
	@Override
	public void deleteUploadfile() {
		mapper.deleteUploadfile();
	}
	

}
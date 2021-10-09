package com.spring.graduateproject;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.Socket;
import java.net.URL;
import java.util.Iterator;
import java.util.UUID;


import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileService implements IFileService {
	
	//python server에 파일 전송
//	@Override
//	public void sendToserver(MultipartFile f) {
//		
//		// 전송할 파일의 http header, body 등의 구조들을 구분하기 위한 개행문자
//		String LINE_D = "\r\n";
//		
//		try {
//			// boundary값으로 사용하기 위한 무작위 값
//			UUID uuid = UUID.randomUUID();
//			System.out.println("uuid 값" + uuid);
//			
//			URL url = new URL("http://127.0.0.1:5000/flasktest");
//			// HttpURLConnection 객체를 생성하여 URL 연결
//			HttpURLConnection con = (HttpURLConnection) url.openConnection();
//			System.out.println("연동완료");
//			
//			// Request Header 설정
//			//con.setRequestProperty("Content-Type", "multipart/form-data;charset=utf-8;boundary=" + uuid);
//			con.setRequestProperty("Content-Type", "multipart/form-data");
//			// POST 형식으로 요청 방식 지정
//			con.setRequestMethod("POST");
//			// OutputStream으로 POST 데이터를 넘기는 옵션 활성화
//			con.setDoOutput(true);
//			// 서버 접속시 연결 시간
//			con.setConnectTimeout(1500);
//			
//			// Request Body에 데이터를 담기 위한 OutputStream 객체 생성
//			OutputStream outputstream = con.getOutputStream();
//			
//			// 바이트 기반 스트림에서 출력 스트림으로 변환시켜 저장
//			PrintWriter w = new PrintWriter(new OutputStreamWriter(outputstream, "UTF-8"), true);
//			
//			System.out.println("확인");
//			
//			// 파일 데이터를 추가한다.
//			w.append("--" + uuid).append(LINE_D);
//			w.append("Content-Dispotion; form-data; name=\"file\"; filename=\"" + f.getOriginalFilename() + "\"").append(LINE_D);
//			w.append("Content-Transfer-Encoding: binary").append(LINE_D);
//			w.append(LINE_D);
//			w.flush();
//			System.out.println(f.getOriginalFilename());
//			
//			// 파일 데이터 구하기
//			byte[] fileData = f.getBytes();
//			outputstream.write(fileData);
//			System.out.println("DATA : " + fileData);
//			
//			outputstream.flush();
//			w.append(LINE_D);
//			w.flush();
//			
//			w.append("--" + uuid + "--");
//			w.close();
//			
//			
//			// Request 요청 후 응답 코드 받기
//			int responseCode = con.getResponseCode();
//			
//			if (responseCode == 200) {
//				System.out.println("전송 성공 Success!!!!!!!!!!!");
//			}
//				
//			
//			
//			
//		} catch (MalformedURLException e1) {
//			e1.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		
//	}
	
	// 수신 데이터 사이즈 전송
	@Override
	public void SizeCon(MultipartFile f, int size) {
		Socket socket;
		String ip = "127.0.0.1";
		int port = 5000;
		
		OutputStream outputstream;
		BufferedOutputStream bufferout;
		
		try {
			socket = new Socket(ip,port);
			System.out.println("Connect Success");
			
			outputstream = socket.getOutputStream();
			bufferout = new BufferedOutputStream(outputstream);

			bufferout.write(Integer.toString(size).getBytes());
			bufferout.flush();
			System.out.println("보낸 사이즈 : " + size);
			
			// 데이터 내용도 보낸다.
			Connect(f, bufferout);
			

			
		} catch (Exception e) {
			System.out.println("Connect Fail");
			e.printStackTrace();
		}
	}
	
	// 서버 연결
	@Override
	public void Connect(MultipartFile f, BufferedOutputStream bufferout) {
		
		
		try {
			
			
			byte[] fileData = f.getBytes();
			bufferout.write(fileData);
			System.out.println("send file...");
			bufferout.flush();
			

			
		} catch (Exception e) {
			System.out.println("Connect Fail");
			e.printStackTrace();
		}
	}

}

package com.spring.graduateproject;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Iterator;
import java.util.UUID;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileService implements IFileService {
	
	//python server에 파일 전송
	@Override
	public void sendToserver(MultipartFile f) {
		
		// 전송할 파일의 http header, body 등의 구조들을 구분하기 위한 개행문자
		String LINE_D = "\r\n";
		
		try {
			// boundary값으로 사용하기 위한 무작위 값
			UUID uuid = UUID.randomUUID();
			
			URL url = new URL(null,"http://127.0.0.1:5000/flasktest", new sun.net.www.protocol.https.Handler());
			// HttpURLConnection 객체를 생성하여 URL 연결
			HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
			
			// Request Header 설정
			con.setRequestProperty("Content-Type", "multipart/form-data;charset=utf-8;boundary=" + uuid);
			// POST 형식으로 요청 방식 지정
			con.setRequestMethod("POST");
			// OutputStream으로 POST 데이터를 넘기는 옵션 활성화
			con.setDoOutput(true);
			// 서버 접속시 연결 시간
			con.setConnectTimeout(1500);
			
			// Request Body에 데이터를 담기 위한 OutputStream 객체 생성
			OutputStream outputstream = con.getOutputStream();
			
			// 바이트 기반 스트림에서 출력 스트림으로 변환시켜 저장
			PrintWriter w = new PrintWriter(new OutputStreamWriter(outputstream, "UTF-8"), true);
			
			// 파일 데이터를 추가한다.
			w.append("--" + uuid).append(LINE_D);
			w.append("Content-Dispotion; form-data; name=\"file\"; filename=\"").append(LINE_D);
			
			
			
			
			
			
			
			
			
			
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	

}

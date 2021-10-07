package com.spring.graduateproject;

import java.io.BufferedOutputStream;
import java.io.IOException;
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
		try {
			// boundary값으로 사용하기 위한 무작위 값
			UUID uuid = UUID.randomUUID();
			
			URL url = new URL(null,"http://127.0.0.1:5000/flasktest", new sun.net.www.protocol.https.Handler());
			// HttpURLConnection 객체를 생성하여 URL 연결
			HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
			
			
			// 파일 전송을 위한 버퍼
			BufferedOutputStream buffer = new BufferedOutputStream(con.getOutputStream());
			
			
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	

}

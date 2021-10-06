package com.spring.graduateproject;

import java.io.DataOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

public class ConnectPython {
	
	private void connectPython() {
		String url = "http://127.0.0.1:5000/flasktest";
		
		try {
			URL u = new URL(url);
			// HttpURLConnection 객체를 생성하여 URL 연결
			HttpsURLConnection con = (HttpsURLConnection)u.openConnection();
			// 요청 방식 선택
			con.setRequestMethod("POST");
			// 타입 설정 -> text/http 형식
			con.setRequestProperty("Content-Type", "text/html");
			// 서버 접속시 연결 시간
			con.setConnectTimeout(10000);
			// Read시 연결 시간
			con.setReadTimeout(5000);
			// POST 데이터를 넘긴다는 설정
			con.setDoOutput(true);
			
//			DataOutputStream re = new DataOutputStream(con.getOutputStream());
//			re.flush();
//			re.close();
			
			int responseCode = con.getResponseCode();
			
			
			
			
		} catch (MalformedURLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
}

package com.spring.graduateproject;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;



public class ConnectPython {
	
	
	public void conflask() {
		
		
		try {
			URL u = new URL(null, "http://127.0.0.1:5000/flasktest", new sun.net.www.protocol.https.Handler());
			// HttpURLConnection 객체를 생성하여 URL 연결
			HttpsURLConnection con = (HttpsURLConnection) u.openConnection();
//			// 요청 방식 선택
//			con.setRequestMethod("GET");
//			// 타입 설정 -> text/http 형식
//			con.setRequestProperty("Content-Type", "text/html");
//			// 서버 접속시 연결 시간
//			con.setConnectTimeout(10000);
//			// Read시 연결 시간
//			con.setReadTimeout(5000);
//			
//			
//			// 실제 서버로 Request 요청 & 응답코드를 받음 - 200(정상)
//			int responseCode = con.getResponseCode();
//			System.out.println("POST URL" + url);
//			System.out.println("응답코드 : " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
			System.out.println("Resut : " + br);
			
			
			
			
			
			
		} catch (MalformedURLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
}

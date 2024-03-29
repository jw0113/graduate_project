package com.spring.graduateproject.url.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;

import org.springframework.stereotype.Service;

@Service
public class UrlService implements IUrlService {

	// url check
	@Override
	public double urlCheck(String url) {
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
			
			bufferout.write(Integer.toString(2).getBytes());
			bufferout.flush();
			
			int a;
			int url_result = 0;
			while(true) {
				a = bufferin.read();
				if (a == 99) {
					bufferout.write(url.getBytes());
					bufferout.flush();
					
				}
				
				else if (a > 0) {
					url_result = a;
				}
				
				else if (a < 0) {
					break;
				}
			}
			System.out.println("url_result : " + url_result);
			
			bufferout.close();
			bufferin.close();
			socket.close();
			
			double percent = (url_result*100) / 8;
			System.out.println("계산한 값 : " + percent);
			return percent;
				
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
}

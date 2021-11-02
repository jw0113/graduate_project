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
	public void urlCheck(String url) {
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
			
			String encode_result = "";
			byte[] in = new byte[9999];
			int a;
			while(true) {
				a = bufferin.read(in);
				if (a == 4) {
					bufferout.write(url.getBytes());
					bufferout.flush();
					
				}
				
				else if (a > 0) {
					//byte[] in = new byte[9999];
					encode_result += new String(in,0,a);
				}
				
				else if (a < 0) {
					break;
				}
			}
			System.out.println("encode_result : " + encode_result);
			
			bufferout.close();
			bufferin.close();
			socket.close();
			
			
			
		} catch (Exception e) {
			System.out.println("Connect Fail");
			e.printStackTrace();
		}
	}
	
}

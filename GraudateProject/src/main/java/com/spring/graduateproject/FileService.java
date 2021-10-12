package com.spring.graduateproject;

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
import java.util.Iterator;
import java.util.UUID;


import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileService implements IFileService {
	
	// 수신 데이터 사이즈 전송
	@Override
	public void SizeCon(MultipartFile f, int size) {
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
					System.out.println("받은 값 : " + bufferin.read());
					byte[] in = new byte[1024];
					deob_read += new String(in,0,bufferin.read(in));
					System.out.println("gg : " + deob_read);
						
				}
				
				// server에서 모든 코드를 보냈다면 while문 종료
				if (bufferin.read() <0) {
					break;
				}
			}
			bufferout.close();
			bufferin.close();
			socket.close();

		} catch (Exception e) {
			System.out.println("Connect Fail");
			e.printStackTrace();
		}
	}
	
	// 서버 연결
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

}

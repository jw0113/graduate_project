package com.spring.graduateproject.file.model;

public class FileVO {
	
	private int index;
	private String filename;
	private String filetype;
	private String filesize;
	private String deob;
	private int deobcount;
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFiletype() {
		return filetype;
	}
	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}
	public String getFilesize() {
		return filesize;
	}
	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}
	public String getDeob() {
		return deob;
	}
	public void setDeob(String deob) {
		this.deob = deob;
	}
	public int getDeobcount() {
		return deobcount;
	}
	public void setDeobcount(int deobcount) {
		this.deobcount = deobcount;
	}
	
	@Override
	public String toString() {
		return "FileVO [index=" + index + ", filename=" + filename + ", filetype=" + filetype + ", filesize=" + filesize
				+ ", deob=" + deob + ", deobcount=" + deobcount + "]";
	}
	
}

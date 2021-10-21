package com.spring.graduateproject.fileupload.model;

public class FileUploadVO {
	
	private int index;
	private String filename;
	private String title;
	private String description;
	private String data;
	private String match;
	private String deob;
	private int posfirst;
	private int poslast;
	
	
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public String getMatch() {
		return match;
	}
	public void setMatch(String match) {
		this.match = match;
	}
	public String getDeob() {
		return deob;
	}
	public void setDeob(String deob) {
		this.deob = deob;
	}
	public int getPosfirst() {
		return posfirst;
	}
	public void setPosfirst(int posfirst) {
		this.posfirst = posfirst;
	}
	public int getPoslast() {
		return poslast;
	}
	public void setPoslast(int poslast) {
		this.poslast = poslast;
	}
	
	@Override
	public String toString() {
		return "FileUploadVO [index=" + index + ", filename=" + filename + ", title=" + title + ", description="
				+ description + ", data=" + data + ", match=" + match + ", deob=" + deob + ", posfirst=" + posfirst
				+ ", poslast=" + poslast + "]";
	}
	
	

}

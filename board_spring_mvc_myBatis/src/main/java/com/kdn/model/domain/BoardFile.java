package com.kdn.model.domain;

import java.io.Serializable;
public class BoardFile implements Serializable {
	private int no;
	private String rfilename;
	private String sfilename;
	private int bno;
	public BoardFile(){}
	public BoardFile(String rfilename, String filename) {
		super();
		this.rfilename = rfilename;
		this.sfilename = filename;
	}

	public BoardFile(int no, String rfilename, String filename, int bno) {
		super();
		this.no = no;
		this.rfilename = rfilename;
		this.sfilename = filename;
		this.bno = bno;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getRfilename() {
		return rfilename;
	}
	public void setRfilename(String rfilename) {
		this.rfilename = rfilename;
	}
	
	public String getSfilename() {
		return sfilename;
	}
	public void setSfilename(String sfilename) {
		this.sfilename = sfilename;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	@Override
	public String toString() {
		return "BoardFile [no=" + no + ", rfilename=" + rfilename
				+ ", filename=" + sfilename + ", bno=" + bno + "]";
	}
}









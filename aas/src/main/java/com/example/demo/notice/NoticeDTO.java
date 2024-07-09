package com.example.demo.notice;

import java.sql.Timestamp;

public class NoticeDTO {
	
	private int n_id;
    private String title;
    private String text;
    private Timestamp date;
    private int cnt;
    private String user_id; //FK로 가져오는 정보
    
    
	public int getN_id() {
		return n_id;
	}
	public void setN_id(int n_id) {
		this.n_id = n_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	@Override
	public String toString() {
		return "NoticeDTO [n_id=" + n_id + ", title=" + title + ", text=" + text + ", date=" + date + ", cnt=" + cnt
				+ ", user_id=" + user_id + "]";
	}
    
}//class end

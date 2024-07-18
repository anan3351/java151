package com.example.demo.qna;

import java.sql.Timestamp;

public class QnaDTO {

	private int question_id;
	private String user_id; //FK로 가져오는 정보
	private char category;
    private String q_title;
    private String q_text;
    private boolean q_open;
    private Timestamp q_date;
	public int getQuestion_id() {
		return question_id;
	}
	public void setQuestion_id(int question_id) {
		this.question_id = question_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public char getCategory() {
		return category;
	}
	public void setCategory(char category) {
		this.category = category;
	}
	public String getQ_title() {
		return q_title;
	}
	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}
	public String getQ_text() {
		return q_text;
	}
	public void setQ_text(String q_text) {
		this.q_text = q_text;
	}
	public boolean isQ_open() {
		return q_open;
	}
	public void setQ_open(boolean q_open) {
		this.q_open = q_open;
	}
	public Timestamp getQ_date() {
		return q_date;
	}
	public void setQ_date(Timestamp q_date) {
		this.q_date = q_date;
	}
	@Override
	public String toString() {
		return "QnaDTO [question_id=" + question_id + ", user_id=" + user_id + ", category=" + category + ", q_title="
				+ q_title + ", q_text=" + q_text + ", q_open=" + q_open + ", q_date=" + q_date + "]";
	}
    
	    
}

package com.example.demo.showreview;

import java.sql.Timestamp;

public class ReplyDTO {

    private int reply_Id;
    private String user_Id;
    private int rev_Id;
    private String content;
    private Timestamp rDate;
    
    
    
    public ReplyDTO() {}
    
    //getter setter
	public int getReply_Id() {
		return reply_Id;
	}
	public void setReply_Id(int reply_Id) {
		this.reply_Id = reply_Id;
	}
	public String getUser_Id() {
		return user_Id;
	}
	public void setUser_Id(String user_Id) {
		this.user_Id = user_Id;
	}
	public int getRev_Id() {
		return rev_Id;
	}
	public void setRev_Id(int rev_Id) {
		this.rev_Id = rev_Id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getrDate() {
		return rDate;
	}
	public void setrDate(Timestamp rDate) {
		this.rDate = rDate;
	}
	
	
	@Override
	public String toString() {
		return "ReplyDTO [reply_Id=" + reply_Id + ", user_Id=" + user_Id + ", rev_Id=" + rev_Id + ", content=" + content
				+ ", rDate=" + rDate + "]";
	}
	
	
    
	
}//class end

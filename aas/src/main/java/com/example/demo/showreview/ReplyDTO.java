package com.example.demo.showreview;

import java.sql.Timestamp;

public class ReplyDTO {
    private int reply_id;
    private String user_id;
    private int rev_id;
    private String content;
    private Timestamp r_date;

    public ReplyDTO() {}

	public int getReply_id() {
		return reply_id;
	}

	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getRev_id() {
		return rev_id;
	}

	public void setRev_id(int rev_id) {
		this.rev_id = rev_id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getR_date() {
		return r_date;
	}

	public void setR_date(Timestamp r_date) {
		this.r_date = r_date;
	}

	@Override
	public String toString() {
		return "ReplyDTO [reply_id=" + reply_id + ", user_id=" + user_id + ", rev_id=" + rev_id + ", content=" + content
				+ ", r_date=" + r_date + "]";
	}
    
    
    
}

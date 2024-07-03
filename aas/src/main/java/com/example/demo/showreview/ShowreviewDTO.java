package com.example.demo.showreview;

import java.sql.Timestamp;

public class ShowreviewDTO {

    private int rev_id;
    private String user_id;
    private String show_id;
    private String retitle;
    private String content;
    private Timestamp r_date;
    private int viewcnt;
    private int empcnt;
    
    
    //생성자
    public ShowreviewDTO() {}
   
    
    //getter setter
	public int getRev_id() {
		return rev_id;
	}
	public void setRev_id(int rev_id) {
		this.rev_id = rev_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getShow_id() {
		return show_id;
	}
	public void setShow_id(String show_id) {
		this.show_id = show_id;
	}
	public String getRetitle() {
		return retitle;
	}
	public void setRetitle(String retitle) {
		this.retitle = retitle;
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
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public int getEmpcnt() {
		return empcnt;
	}
	public void setEmpcnt(int empcnt) {
		this.empcnt = empcnt;
	}
	
	@Override
	public String toString() {
		return "ShowreviewDTO [rev_id=" + rev_id + ", user_id=" + user_id + ", show_id=" + show_id + ", retitle="
				+ retitle + ", content=" + content + ", r_date=" + r_date + ", viewcnt=" + viewcnt + ", empcnt="
				+ empcnt + "]";
	}
    
    
	
	
	
}//class end

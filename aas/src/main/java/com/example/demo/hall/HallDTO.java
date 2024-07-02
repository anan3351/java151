package com.example.demo.hall;

public class HallDTO {
	
	public HallDTO() {
		System.out.println("-----------HallDTO 객채 생성");
	}
	
	private int hall_id;
	private String h_name;
	private String miniHall;
	private String addr;
	private String h_call;
	private String url;
	private String seat;
	private String user_id;
	
	
	public int getHall_id() {
		return hall_id;
	}
	public void setHall_id(int hall_id) {
		this.hall_id = hall_id;
	}
	public String getH_name() {
		return h_name;
	}
	public void setH_name(String h_name) {
		this.h_name = h_name;
	}
	public String getMiniHall() {
		return miniHall;
	}
	public void setMiniHall(String miniHall) {
		this.miniHall = miniHall;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getH_call() {
		return h_call;
	}
	public void setH_call(String h_call) {
		this.h_call = h_call;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getSeat() {
		return seat;
	}
	public void setSeat(String seat) {
		this.seat = seat;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	@Override
	public String toString() {
		return "HallDTO [hall_id=" + hall_id + ", h_name=" + h_name + ", miniHall=" + miniHall + ", addr=" + addr
				+ ", h_call=" + h_call + ", url=" + url + ", seat=" + seat + ", user_id=" + user_id + "]";
	}
	
	

}//END hallDTO

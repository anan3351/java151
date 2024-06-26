package com.example.demo.hall;

public class HallDTO {
	public HallDTO() {
		System.out.println("HallDTO 객체 생성완료");
	}

	private int hall_id;
	private String h_name;
	private String miniHall;
	private String addr;
	private String hall_call;
	private String user_id;
	private String hall_url;
	private String seat;
	
	
	
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
	public String getHall_call() {
		return hall_call;
	}
	public void setHall_call(String hall_call) {
		this.hall_call = hall_call;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getHall_url() {
		return hall_url;
	}
	public void setHall_url(String hall_url) {
		this.hall_url = hall_url;
	}
	public String getSeat() {
		return seat;
	}
	public void setSeat(String seat) {
		this.seat = seat;
	}
	
	
	
	@Override
	public String toString() {
		return "HallDTO [hall_id=" + hall_id + ", h_name=" + h_name + ", miniHall=" + miniHall + ", addr=" + addr
				+ ", hall_call=" + hall_call + ", user_id=" + user_id + ", hall_url=" + hall_url + ", seat=" + seat
				+ "]";
	}
	
	
	
}//end

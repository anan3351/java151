package com.example.demo.hall;

public class HallDTO {
	
	public HallDTO() {
	}
	
	private String hall_id;
	private String h_name;
	private String miniHall;
	private String addr;
	private String h_call;
	private String url;
	private String seat;
	private String user_id;
	private String prfplcnm;
	private String mt13id;
    private String seatscale;
    private String h_code;
    

	public String getHall_id() {
		return hall_id;
	}
	public void setHall_id(String hall_id) {
		this.hall_id = hall_id;
	}
	public String getH_name() {
		return h_name;
	}
	public void setHname(String h_name) {
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
	public String getPrfplcnm() {
		return prfplcnm;
	}
	public void setPrfplcnm(String prfplcnm) {
		this.prfplcnm = prfplcnm;
	}
	public String getMt13id() {
		return mt13id;
	}
	public void setMt13id(String mt13id) {
		this.mt13id = mt13id;
	}
	public String getSeatscale() {
		return seatscale;
	}
	public void setSeatscale(String seatscale) {
		this.seatscale = seatscale;
	}
	public String getH_code() {
		return h_code;
	}
	public void setH_code(String h_code) {
		this.h_code = h_code;
	}

	
	public String toString() {
		return "HallDTO [hall_id=" + hall_id + ", h_name=" + h_name + ", miniHall=" + miniHall + ", addr=" + addr
				+ ", h_call=" + h_call + ", url=" + url + ", seat=" + seat + ", user_id=" + user_id + ", prfplcnm="
				+ prfplcnm + ", mt13id=" + mt13id + ", seatscale=" + seatscale + ", h_code=" + h_code + "]";
	}
	
    
    
  
	
	
	
	
}//END hallDTO

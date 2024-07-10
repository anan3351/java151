package com.example.demo.hall;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "tb_hall") // 테이블 이름 매핑
public class HallEntity {
	
	//public HallEntity() {} //생성자 함수
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "hall_id")
	private String hallId;
	
	@Column(name = "h_name")
	private String hname;
	
	
	private String miniHall;
	private String addr;
	private String h_call;
	private String url;
	private String seat;
	private String user_id;
    private String h_code;
    
    
	public String getHall_id() {
		return hallId;
	}
	public void setHall_id(String hall_id) {
		this.hallId = hallId;
	}
	public String getHname() {
		return hname;
	}
	public void setHname(String hname) {
		this.hname = hname;
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
	
	public String getH_code() {
		return h_code;
	}
	public void setH_code(String h_code) {
		this.h_code = h_code;
	}
	@Override
	public String toString() {
		return "HallEntity [hallId=" + hallId + ", hname=" + hname + ", miniHall=" + miniHall + ", addr=" + addr
				+ ", h_call=" + h_call + ", url=" + url + ", seat=" + seat + ", user_id=" + user_id + ", h_code="
				+ h_code + "]";
	}
	
	
    
	
	

}

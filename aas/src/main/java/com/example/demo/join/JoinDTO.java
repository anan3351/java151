package com.example.demo.join;

public class JoinDTO {

	 private String user_id;
	 private String pwd;
	 private String user_name;
	 private String tel_num;
	 private String addr1;
	 private String addr2;
	 private String email;
	 private String snum;
	 private String auth;
	 private String level_name;
	 private Integer point;
	 
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getTel_num() {
		return tel_num;
	}
	public void setTel_num(String tel_num) {
		this.tel_num = tel_num;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSnum() {
		return snum;
	}
	public void setSnum(String snum) {
		this.snum = snum;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	public String getLevel_name() {
		return level_name;
	}
	public void setLevel_name(String level_name) {
		this.level_name = level_name;
	}
	public Integer getPoint() {
		return point;
	}
	public void setPoint(Integer point) {
		this.point = point;
	}
	@Override
	public String toString() {
		return "JoinDTO [user_id=" + user_id + ", pwd=" + pwd + ", user_name=" + user_name + ", tel_num=" + tel_num
				+ ", addr1=" + addr1 + ", addr2=" + addr2 + ", email=" + email + ", snum=" + snum + ", auth=" + auth
				+ ", level_name=" + level_name + ", point=" + point + "]";
	}
	 
	
}

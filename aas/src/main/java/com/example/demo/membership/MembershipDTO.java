package com.example.demo.membership;

import java.util.Date;

public class MembershipDTO {
	public MembershipDTO() {
		// TODO Auto-generated constructor stub
	}
	
	private Integer member_id;
	private String mb_name;
	private String user_id;
	private Date admin_date;
	private String benefit;
	private Integer reservation_c;
	private Integer price;
	private Integer mb_date;
	private Integer level_point;
	private Date cp_date;
	private Integer left_count;
	private Integer u_point;
	
	
	
	
	
	public Integer getU_point() {
		return u_point;
	}
	public void setU_point(Integer u_point) {
		this.u_point = u_point;
	}
	public Integer getMember_id() {
		return member_id;
	}
	public void setMember_id(Integer member_id) {
		this.member_id = member_id;
	}
	public String getMb_name() {
		return mb_name;
	}
	public void setMb_name(String mb_name) {
		this.mb_name = mb_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getAdmin_date() {
		return admin_date;
	}
	public void setAdmin_date(Date admin_date) {
		this.admin_date = admin_date;
	}
	public String getBenefit() {
		return benefit;
	}
	public void setBenefit(String benefit) {
		this.benefit = benefit;
	}
	public Integer getReservation_c() {
		return reservation_c;
	}
	public void setReservation_c(Integer reservation_c) {
		this.reservation_c = reservation_c;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public Integer getMb_date() {
		return mb_date;
	}
	public void setMb_date(Integer mb_date) {
		this.mb_date = mb_date;
	}
	public Integer getLevel_point() {
		return level_point;
	}
	public void setLevel_point(Integer level_point) {
		this.level_point = level_point;
	}
	public Date getCp_date() {
		return cp_date;
	}
	public void setCp_date(Date cp_date) {
		this.cp_date = cp_date;
	}
	public Integer getLeft_count() {
		return left_count;
	}
	public void setLeft_count(Integer left_count) {
		this.left_count = left_count;
	}
	@Override
	public String toString() {
		return "MembershipDTO [member_id=" + member_id + ", mb_name=" + mb_name + ", user_id=" + user_id
				+ ", admin_date=" + admin_date + ", benefit=" + benefit + ", reservation_c=" + reservation_c
				+ ", price=" + price + ", mb_date=" + mb_date + ", level_point=" + level_point + ", cp_date=" + cp_date
				+ ", left_count=" + left_count + ", u_point=" + u_point + "]";
	}
	
	
	
	

}

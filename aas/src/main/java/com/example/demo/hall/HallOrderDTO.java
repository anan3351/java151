package com.example.demo.hall;

import java.sql.Date;
import java.sql.Timestamp;

public class HallOrderDTO {
	
	public HallOrderDTO() {
	}
	
	private String HallOrder_id;
	private String hall_id;
	private Integer hallPay_id;
	private String user_id;
	private String show_id;
	private String start_date;
	private String end_date;
	private String cancel;
	private Timestamp pay_date;
	private String pay_info;
	private String pay_status;
	private String price;
	private String miniHall;
	
	
	
	
	public String getMiniHall() {
		return miniHall;
	}
	public void setMiniHall(String miniHall) {
		this.miniHall = miniHall;
	}
	public String getHallOrder_id() {
		return HallOrder_id;
	}
	public void setHallOrder_id(String hallOrder_id) {
		HallOrder_id = hallOrder_id;
	}
	public String getHall_id() {
		return hall_id;
	}
	public void setHall_id(String hall_id) {
		this.hall_id = hall_id;
	}
	public Integer getHallPay_id() {
		return hallPay_id;
	}
	public void setHallPay_id(Integer hallPay_id) {
		this.hallPay_id = hallPay_id;
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
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getCancel() {
		return cancel;
	}
	public void setCancel(String cancel) {
		this.cancel = cancel;
	}
	public Timestamp getPay_date() {
		return pay_date;
	}
	public void setPay_date(Timestamp pay_date) {
		this.pay_date = pay_date;
	}
	public String getPay_info() {
		return pay_info;
	}
	public void setPay_info(String pay_info) {
		this.pay_info = pay_info;
	}
	public String getPay_status() {
		return pay_status;
	}
	public void setPay_status(String pay_status) {
		this.pay_status = pay_status;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "HallOrderDTO [HallOrder_id=" + HallOrder_id + ", hall_id=" + hall_id + ", hallPay_id=" + hallPay_id
				+ ", user_id=" + user_id + ", show_id=" + show_id + ", start_date=" + start_date + ", end_date="
				+ end_date + ", cancel=" + cancel + ", pay_date=" + pay_date + ", pay_info=" + pay_info
				+ ", pay_status=" + pay_status + ", price=" + price + "]";
	}
	
	
	
	
}//END hallDTO

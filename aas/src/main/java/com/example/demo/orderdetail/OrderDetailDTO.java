package com.example.demo.orderdetail;

import java.sql.Timestamp;

public class OrderDetailDTO {

    private int order_id;
    private int ticket_id;
    private String user_id;
    private int seat_id;
    private Integer dis_id; // NULL 값을 허용하는 필드는 Integer 클래스 사용
    private Integer coupon_id; // NULL 값을 허용하는 필드는 Integer 클래스 사용
    private Integer order_point; // NULL 값을 허용하는 필드는 Integer 클래스 사용
    private Timestamp order_date;
    private String progress;
    private String discount;
    private String order_info;
    private int total_amount;
    
    public OrderDetailDTO() {}

	public int getOrder_id() {
		return order_id;
	}

	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}

	public int getTicket_id() {
		return ticket_id;
	}

	public void setTicket_id(int ticket_id) {
		this.ticket_id = ticket_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getSeat_id() {
		return seat_id;
	}

	public void setSeat_id(int seat_id) {
		this.seat_id = seat_id;
	}

	public Integer getDis_id() {
		return dis_id;
	}

	public void setDis_id(Integer dis_id) {
		this.dis_id = dis_id;
	}

	public Integer getCoupon_id() {
		return coupon_id;
	}

	public void setCoupon_id(Integer coupon_id) {
		this.coupon_id = coupon_id;
	}

	public Integer getOrder_point() {
		return order_point;
	}

	public void setOrder_point(Integer order_point) {
		this.order_point = order_point;
	}

	public Timestamp getOrder_date() {
		return order_date;
	}

	public void setOrder_date(Timestamp order_date) {
		this.order_date = order_date;
	}

	public String getProgress() {
		return progress;
	}

	public void setProgress(String progress) {
		this.progress = progress;
	}

	public String getDiscount() {
		return discount;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}

	public String getOrder_info() {
		return order_info;
	}

	public void setOrder_info(String order_info) {
		this.order_info = order_info;
	}

	public int getTotal_amount() {
		return total_amount;
	}

	public void setTotal_amount(int total_amount) {
		this.total_amount = total_amount;
	}

	@Override
	public String toString() {
		return "OrderDetailDTO [order_id=" + order_id + ", ticket_id=" + ticket_id + ", user_id=" + user_id
				+ ", seat_id=" + seat_id + ", dis_id=" + dis_id + ", coupon_id=" + coupon_id + ", order_point="
				+ order_point + ", order_date=" + order_date + ", progress=" + progress + ", discount=" + discount
				+ ", order_info=" + order_info + ", total_amount=" + total_amount + "]";
	}
    
    
}//class end 

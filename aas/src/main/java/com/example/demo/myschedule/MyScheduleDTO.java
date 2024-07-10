package com.example.demo.myschedule;

import java.sql.Date;
import java.sql.Time;

public class MyScheduleDTO {

    private int mysch_id;
    private String user_id;
    private int order_id;
    private String title;
    private Date showdate;
    private Time showtime;
    private String seat;
    private String fair;
    private String poster;
    private String sale;
	
	
	public MyScheduleDTO() {}


	public int getMysch_id() {
		return mysch_id;
	}


	public void setMysch_id(int mysch_id) {
		this.mysch_id = mysch_id;
	}


	public String getUser_id() {
		return user_id;
	}


	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}


	public int getOrder_id() {
		return order_id;
	}


	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public Date getShowdate() {
		return showdate;
	}


	public void setShowdate(Date showdate) {
		this.showdate = showdate;
	}


	public Time getShowtime() {
		return showtime;
	}


	public void setShowtime(Time showtime) {
		this.showtime = showtime;
	}


	public String getSeat() {
		return seat;
	}


	public void setSeat(String seat) {
		this.seat = seat;
	}


	public String getFair() {
		return fair;
	}


	public void setFair(String fair) {
		this.fair = fair;
	}


	public String getPoster() {
		return poster;
	}


	public void setPoster(String poster) {
		this.poster = poster;
	}


	public String getSale() {
		return sale;
	}


	public void setSale(String sale) {
		this.sale = sale;
	}


	@Override
	public String toString() {
		return "MyScheduleDTO [mysch_id=" + mysch_id + ", user_id=" + user_id + ", order_id=" + order_id + ", title="
				+ title + ", showdate=" + showdate + ", showtime=" + showtime + ", seat=" + seat + ", fair=" + fair
				+ ", poster=" + poster + ", sale=" + sale + "]";
	}
	
	
	
}//class end



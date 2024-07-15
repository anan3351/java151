package com.example.demo.coupon;


public class CouponDTO {

		public CouponDTO() {};
		
		private String user_id;
		private String coupon_id;
	    private String coupon_name;
	    private String limit_date;
	    private String seat_level;
	    private String mb_name;
	    private int cp_count;
	    private int left_count;
	    private String cp_date;
	    
		public String getUser_id() {
			return user_id;
		}
		public void setUser_id(String user_id) {
			this.user_id = user_id;
		}
		public String getCoupon_id() {
			return coupon_id;
		}
		public void setCoupon_id(String coupon_id) {
			this.coupon_id = coupon_id;
		}
		public String getCoupon_name() {
			return coupon_name;
		}
		public void setCoupon_name(String coupon_name) {
			this.coupon_name = coupon_name;
		}
		public String getLimit_date() {
			return limit_date;
		}
		public void setLimit_date(String limit_date) {
			this.limit_date = limit_date;
		}
		public String getSeat_level() {
			return seat_level;
		}
		public void setSeat_level(String seat_level) {
			this.seat_level = seat_level;
		}
		public String getMb_name() {
			return mb_name;
		}
		public void setMb_name(String mb_name) {
			this.mb_name = mb_name;
		}
		public int getCp_count() {
			return cp_count;
		}
		public void setCp_count(int cp_count) {
			this.cp_count = cp_count;
		}
		public int getLeft_count() {
			return left_count;
		}
		public void setLeft_count(int left_count) {
			this.left_count = left_count;
		}
		public String getCp_date() {
			return cp_date;
		}
		public void setCp_date(String cp_date) {
			this.cp_date = cp_date;
		}
		@Override
		public String toString() {
			return "CouponDTO [user_id=" + user_id + ", coupon_id=" + coupon_id + ", coupon_name=" + coupon_name
					+ ", limit_date=" + limit_date + ", seat_level=" + seat_level + ", mb_name=" + mb_name
					+ ", cp_count=" + cp_count + ", left_count=" + left_count + ", cp_date=" + cp_date + "]";
		}
	    
	    
	    
}

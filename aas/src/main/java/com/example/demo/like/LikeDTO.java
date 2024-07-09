package com.example.demo.like;

public class LikeDTO {

	private int like_id;
	private String user_id;
	private int rev_id;
	private String emp;
	
	//생성자
	public LikeDTO() {}

	//getter setter
	public int getLike_id() {
		return like_id;
	}

	public void setLike_id(int like_id) {
		this.like_id = like_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getRev_id() {
		return rev_id;
	}

	public void setRev_id(int rev_id) {
		this.rev_id = rev_id;
	}

	public String getEmp() {
		return emp;
	}

	public void setEmp(String emp) {
		this.emp = emp;
	}

	@Override
	public String toString() {
		return "LikeDTO [like_id=" + like_id + ", user_id=" + user_id + ", rev_id=" + rev_id + ", emp=" + emp + "]";
	}
	
	
}//class end

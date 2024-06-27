package com.example.demo.actor;

import java.util.Date;

public class ActorDTO {
	//맴버변수	
	 private int actor_Id;
	 private String a_name;
	 private String photo;
	 private String job;
	 private Date birth;
	 private String physical;
	 private String agency;
	 private String site;
	//생성자
	public ActorDTO() {}
	public int getActor_Id() {
		return actor_Id;
	}
	public void setActor_Id(int actor_Id) {
		this.actor_Id = actor_Id;
	}
	public String getA_name() {
		return a_name;
	}
	public void setA_name(String a_name) {
		this.a_name = a_name;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getPhysical() {
		return physical;
	}
	public void setPhysical(String physical) {
		this.physical = physical;
	}
	public String getAgency() {
		return agency;
	}
	public void setAgency(String agency) {
		this.agency = agency;
	}
	public String getSite() {
		return site;
	}
	public void setSite(String site) {
		this.site = site;
	}
	
	
	@Override
	public String toString() {
		return "ActorDTO [actor_Id=" + actor_Id + ", a_name=" + a_name + ", photo=" + photo + ", job=" + job
				+ ", birth=" + birth + ", physical=" + physical + ", agency=" + agency + ", site=" + site + "]";
	}
	
	
	
	
	
}//class end

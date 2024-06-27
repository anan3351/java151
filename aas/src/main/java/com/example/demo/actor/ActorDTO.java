package com.example.demo.actor;

import java.util.Date;

public class ActorDTO {
	//맴버변수	
	 private int actorId;
	 private String name;
	 private String photo;
	 private String job;
	 private Date birth;
	 private String physical;
	 private String agency;
	 private String site;
	//생성자
	public ActorDTO() {}
	
	
	//getter setter
	public int getActorId() {
		return actorId;
	}
	public void setActorId(int actorId) {
		this.actorId = actorId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
		return "ActorDTO [actorId=" + actorId + ", name=" + name + ", photo=" + photo + ", job=" + job + ", birth="
				+ birth + ", physical=" + physical + ", agency=" + agency + ", site=" + site + "]";
	}
	
	
	
	
}//class end

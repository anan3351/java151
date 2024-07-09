package com.example.demo.actor;

import java.util.Date;

public class ActorDTO {
    private int actor_id; // 필드 이름을 데이터베이스 컬럼과 동일하게 수정
    private String a_name; // 필드 이름을 데이터베이스 컬럼과 동일하게 수정
    private String photo;
    private String job;
    private String birth;
    private String physical;
    private String agency;
    private String site;
    
    // Getters and Setters
    
    
	public int getActor_id() {
		return actor_id;
	}
	public void setActor_id(int actor_id) {
		this.actor_id = actor_id;
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
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
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
		return "ActorDTO [actor_id=" + actor_id + ", a_name=" + a_name + ", photo=" + photo + ", job=" + job
				+ ", birth=" + birth + ", physical=" + physical + ", agency=" + agency + ", site=" + site + "]";
	}

 
    
}
package com.example.demo.show;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@Data
@ToString
public class ShowDTO {
	private int show_id;		  // 공연ID
	private String user_id;		  // 유저ID
	private String title;		  // 공연명
	private int hall_id;		  // 공연장ID
	private String genre;		  // 장르
	private String start_day;	  // 공연시작일
	private String end_day;		  // 공연종료일
	private int runningtime;	  // 러닝타임(분)
	private String viewing_age;	  // 관람가
	private String synopsis;	  // 시놉시스(줄거리)
	private String notice_img;	  // 공지 이미지
	private String dis_img;		  // 할인정보 이미지
	private String casting_img;	  // 캐스팅 이미지
	private String event_img;	  // 이벤트 이미지
	private String detail_img;	  // 상세정보 이미지
	private String poster;		  // 포스터
}
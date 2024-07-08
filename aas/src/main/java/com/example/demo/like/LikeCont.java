package com.example.demo.like;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.showreview.ShowreviewDAO;

@Controller
@RequestMapping("/showreview")
public class LikeCont {

	public LikeCont() {
		System.out.println("-----likeCont 객체 생성");
	}
	
	@Autowired
	private LikeDAO likeDao;
	
	@Autowired
	private ShowreviewDAO showreviewDao;
	

	@PostMapping("/likeReview")
	@ResponseBody
	public String likeReview(@RequestParam("user_id") String user_id, @RequestParam(value = "rev_id", required = false, defaultValue = "0") String rev_idStr) {
	    //System.out.println("Received user_id: " + user_id); // user_id 로그 추가
	    //System.out.println("Received rev_idStr: " + rev_idStr); // rev_idStr 로그 추가
	    try {
	        int rev_id = Integer.parseInt(rev_idStr);
	        if (rev_id == 0) {
	            return "invalid_rev_id"; // 0은 유효하지 않은 리뷰 ID로 간주
	        }
	        if (likeDao.checkIfLiked(user_id, rev_id)) {
	            return "already_liked";
	        } else {
	            likeDao.insertLike(user_id, rev_id);
	            showreviewDao.incrementEmpcnt(rev_id);
	            return "liked";
	        }
	    } catch (NumberFormatException e) {
	        return "invalid_rev_id";
	    }
	}
	
	
	
}//class end

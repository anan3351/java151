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
    public String likeReview(@RequestParam("user_id") String user_id, @RequestParam("rev_id") int rev_id) {
        if (likeDao.checkIfLiked(user_id, rev_id)) {
            return "already_liked";
        } else {
            likeDao.insertLike(user_id, rev_id);
            showreviewDao.incrementEmpcnt(rev_id);
            return "liked";
        }
    }
	
}//class end

package com.example.demo.like;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("")
public class LikeCont {

	public LikeCont() {
		System.out.println("-----likeCont 객체 생성");
	}
	
	@Autowired
	private LikeDAO likeDao;
	
	@PostMapping("/like")
	@ResponseBody
    public String like(@RequestParam("user_Id") String user_Id, @RequestParam("rev_Id") int rev_Id) {
        if (likeDao.checkIfLiked(user_Id, rev_Id)) {
            return "already_liked";
        } else {
            likeDao.insertLike(user_Id, rev_Id);
            return "liked";
        }
	}
	
}//class end

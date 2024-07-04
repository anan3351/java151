package com.example.demo.showreview;

import java.util.Collections;
import java.util.List;

import javax.management.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.like.LikeDAO;
import com.example.demo.show.ShowDAO;

@Controller
@RequestMapping("")
public class ShowreviewCont {
	public ShowreviewCont() {
		System.out.println("-----ShowreviewCont 객체 생성");
	}
	
	@Autowired
	private ShowreviewDAO showreviewDao;
	
	@Autowired
	private ReplyDAO replyDao;
	
	@Autowired
	private LikeDAO likeDao;
	
	
	
	@RequestMapping("/showreview/showreviewForm")
	public ModelAndView showrvForm () {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("showreview/showrvForm");	
		return mav;
	}
	
	
	 @PostMapping("/showreview/insert")
	 public ModelAndView insert(ShowreviewDTO showreviewDto) {
	      ModelAndView mav = new ModelAndView();
	      showreviewDao.insert(showreviewDto);
	      mav.setViewName("redirect:/showrvList");
	      return mav;
	}
	 
	 @GetMapping("/showreview")
	 public ModelAndView list(@RequestParam(value = "pageNum", required = false) String pageNum) {
		 ModelAndView mav = new ModelAndView();
		 mav.setViewName("showreview/showrvList");
		 
	        int totalRowCount = showreviewDao.totalRowCount();
	        
	        int numPerPage = 10;
	        int pagePerBlock = 10;

	        if (pageNum == null) {
	            pageNum = "1";
	        }

	        int currentPage = Integer.parseInt(pageNum);
	        int startRow = (currentPage - 1) * numPerPage;
	        int endRow = numPerPage;

	        double totcnt = (double) totalRowCount / numPerPage;
	        int totalPage = (int) Math.ceil(totcnt);

	        double d_page = (double) currentPage / pagePerBlock;
	        int Pages = (int) Math.ceil(d_page) - 1;
	        int startPage = Pages * pagePerBlock + 1;
	        int endPage = startPage + pagePerBlock - 1;
	        if (endPage > totalPage) {
	            endPage = totalPage;
	        }

	        List<ShowreviewDTO> list = null;
	        if (totalRowCount > 0) {
	            list = showreviewDao.list(startRow, endRow);
	        } else {
	            list = Collections.emptyList();
	        }

	        mav.addObject("currentPage", currentPage);
	        mav.addObject("totalPages", totalPage);
	        mav.addObject("startPage", startPage);
	        mav.addObject("endPage", endPage);
	        mav.addObject("reviewList", list);		 
		 
		 return mav;
	 }
	 
	    @GetMapping("/showreviewdetail")
	    public ModelAndView showrvdetail(@RequestParam("rev_id") int rev_Id) {
	        ModelAndView mav = new ModelAndView();
	        ShowreviewDTO review = showreviewDao.getReviewById(rev_Id);
	        List<ReplyDTO> replies = replyDao.getRepliesByReviewId(rev_Id);
	        mav.addObject("review", review);
	        mav.addObject("replies", replies);
	        mav.setViewName("showreview/showrvdetail");
	        return mav;
	    }
	
	    @PostMapping("/addReply")
	    public String addReply(ReplyDTO replyDto) {
	        replyDao.insert(replyDto);
	        return "redirect:/showreview/showreviewdetail?rev_id=" + replyDto.getRev_Id();
	    }
	
	    @PostMapping("/likeReview")
	    @ResponseBody
	    public String likeReview(@RequestParam("user_Id") String user_Id, @RequestParam("rev_Id") int rev_Id) {
	        if (likeDao.checkIfLiked(user_Id, rev_Id)) {
	            return "already_liked";
	        } else {
	            likeDao.insertLike(user_Id, rev_Id);
	            showreviewDao.incrementEmpcnt(rev_Id);
	            return "liked";
	        }
	    }

}//class end

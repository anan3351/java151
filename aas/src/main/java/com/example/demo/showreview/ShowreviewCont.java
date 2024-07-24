package com.example.demo.showreview;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.management.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.like.LikeDAO;
import com.example.demo.orderdetail.OrderDetailDAO;
import com.example.demo.orderdetail.OrderDetailDTO;
import com.example.demo.showreview.DBOpen;
import com.example.demo.show.ShowDAO;
import com.example.demo.show.ShowDTO;
import com.example.demo.user.UserDTO;

import jakarta.servlet.http.HttpSession;

import org.springframework.ui.Model;


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
	
	@Autowired
	private OrderDetailDAO orderDetailDao;

    @GetMapping("/searchShows")
    @ResponseBody
    public List<ShowDTO> searchShows(@RequestParam("keyword") String keyword) {
        return showreviewDao.searchShows(keyword);
    } 
    
	
	@RequestMapping("/showreview/showreviewForm")
	public ModelAndView showrvForm (@RequestParam("user_id") String user_Id) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("user_id", user_Id);
		mav.setViewName("showreview/showrvForm");	
		return mav;
	}
	
	/*
	 @PostMapping("/showreview/insert")
	 public ModelAndView insert(ShowreviewDTO showreviewDto, @RequestParam("user_id") String userId) {
	      ModelAndView mav = new ModelAndView();
	      showreviewDto.setUser_id(userId);
	      showreviewDao.insert(showreviewDto);
	      mav.setViewName("redirect:/showreview");
	      return mav;
	}*/
	
	@PostMapping("/showreview/insert")
	public ModelAndView insert(@ModelAttribute ShowreviewDTO showreviewDto, HttpSession session) {
	    ModelAndView mav = new ModelAndView();

	    // 세션에서 로그인된 사용자 정보 가져오기
	    UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");

	    if (loggedInUser == null) {
	        // 사용자가 로그인되어 있지 않은 경우, 로그인 페이지로 리디렉션
	        mav.setViewName("redirect:/user/login");
	        return mav;
	    }

	    // showreviewDto에 사용자 ID 설정
	    showreviewDto.setUser_id(loggedInUser.getUser_id());

	    // 필수 데이터가 모두 있는지 확인
	    if (showreviewDto.getUser_id() == null || showreviewDto.getShow_id() == null ||
	        showreviewDto.getRetitle() == null || showreviewDto.getContent() == null) {
	        
	        // 어떤 데이터가 없는지 출력
	        System.out.println("Missing Data:");
	        if (showreviewDto.getUser_id() == null) System.out.println("User ID is null");
	        if (showreviewDto.getShow_id() == null) System.out.println("Show ID is null");
	        if (showreviewDto.getRetitle() == null) System.out.println("Retitle is null");
	        if (showreviewDto.getContent() == null) System.out.println("Content is null");

	        // 필요한 데이터가 없는 경우, 다시 입력 폼으로 리디렉션
	        mav.setViewName("redirect:/showreview/showreviewForm");
	        return mav;
	    }

	    // 데이터가 모두 있는 경우, 데이터베이스에 삽입
	    showreviewDao.insert(showreviewDto);
	    mav.setViewName("redirect:/showreview");
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

	        List<Map<String, Object>> list = null;
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
	 
	    @GetMapping("/showreview/showreviewdetail")
	    public ModelAndView showrvdetail(@RequestParam("rev_id") int rev_Id) {
	        ModelAndView mav = new ModelAndView();
	        ShowreviewDTO review = showreviewDao.getReviewById(rev_Id);
	        List<ReplyDTO> replies = replyDao.getRepliesByReviewId(rev_Id);
	        mav.addObject("review", review);
	        mav.addObject("replies", replies);
	        mav.setViewName("showreview/showrvdetail");
	        return mav;
	    }
	    
	    @PostMapping("/showreview/increaseViewCount")
	    @ResponseBody
	    public String increaseViewCount(@RequestParam("rev_id") int rev_id) {
	        try {
	            showreviewDao.incrementViewCount(rev_id);
	            return "success";
	        } catch (Exception e) {
	            return "error";
	        }
	    }

	    @PostMapping("/showreview/increaseEmpcnt")
	    @ResponseBody
	    public String increaseEmpcnt(@RequestParam("rev_id") int rev_id) {
	        try {
	            showreviewDao.incrementEmpcnt(rev_id);
	            return "success";
	        } catch (Exception e) {
	            return "error";
	        }
	    }


	    @PostMapping("/showreview/addReply")
	    public String addReply(@ModelAttribute ReplyDTO replyDto) {
	        //System.out.println("Received user_id: " + replyDto.getUser_id());
	        //System.out.println("Received rev_id: " + replyDto.getRev_id());
	        //System.out.println("Received content: " + replyDto.getContent());

	        replyDao.insert(replyDto);
	        return "redirect:/showreview/showreviewdetail?rev_id=" + replyDto.getRev_id();
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


	    @PostMapping("/showreview/updateReply")
	    public String updateReply(@ModelAttribute ReplyDTO replyDto) {
	        replyDao.update(replyDto);
	        return "redirect:/showreview/showreviewdetail?rev_id=" + replyDto.getRev_id();
	    }

	    @PostMapping("/showreview/deleteReply")
	    public String deleteReply(@RequestParam("reply_id") int reply_id, @RequestParam("rev_id") int rev_id) {
	        replyDao.delete(reply_id);
	        return "redirect:/showreview/showreviewdetail?rev_id=" + rev_id;
	    }
	    
	    @PostMapping("/showreview/updateReview")
	    public String updateReview(@ModelAttribute ShowreviewDTO showreviewDto) {
	        showreviewDao.update(showreviewDto);
	        return "redirect:/showreview/showreviewdetail?rev_id=" + showreviewDto.getRev_id();
	    }

	    
	    
	    private DBOpen dbopen = null;
	    private Connection con = null;
	    private PreparedStatement pstmt = null;
	    private ResultSet rs = null;
	    private StringBuilder sql = null;


	    @PostMapping("/showreview/deleteReview")
	    @ResponseBody
	    public String deleteReview(@RequestParam("rev_id") int rev_id, HttpSession session) {
	        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser"); // 세션에서 로그인한 사용자 객체 가져오기
	        ShowreviewDTO review = showreviewDao.getReviewById(rev_id);

	        if (review != null && loggedInUser != null && review.getUser_id().equals(loggedInUser.getUser_id())) {
	            showreviewDao.delete(rev_id);
	            return "success";
	        } else {
	            return "unauthorized";
	        }
	    }
	    
	    @GetMapping("/orderDetails")
	    @ResponseBody
	    public List<OrderDetailDTO> getOrderDetails(@RequestParam("user_id") String userId) {
	        return orderDetailDao.getOrderDetailsByUserId(userId);
	    }

	    @GetMapping("/showreview/showrvmy")
	    public ModelAndView showrvmy(HttpSession session) {
	        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
	        if (loggedInUser == null) {
	            return new ModelAndView("redirect:/user/login");
	        }
	        List<Map<String, Object>> myReviews = showreviewDao.getReviewsByUserId(loggedInUser.getUser_id());
	        ModelAndView mav = new ModelAndView("showreview/showrvmy");
	        mav.addObject("myReviews", myReviews);
	        return mav;
	    }

	    @GetMapping("/showreview/search")
	    public ModelAndView searchReviews(@RequestParam("keyword") String keyword) {
	        List<Map<String, Object>> reviewList = showreviewDao.searchReviewsByKeyword(keyword);
	        ModelAndView mav = new ModelAndView("showreview/showrvList");
	        mav.addObject("reviewList", reviewList);
	        mav.addObject("keyword", keyword);
	        return mav;
	    }

}//class end

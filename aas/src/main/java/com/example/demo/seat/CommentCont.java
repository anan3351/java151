package com.example.demo.seat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CommentCont {

    @Autowired
    private SeatReviewServ seatReviewService;

    @GetMapping("/comment")
    public String showCommentPage(Model model) {
        model.addAttribute("showTitle", "프랑켄슈타인");
        model.addAttribute("seatLocation", "1층1행1번");
        return "/seat/comment"; // 경로 확인
    }

    @PostMapping("/submitComment")
    public String submitComment(
            @RequestParam("rating") int rating,
            @RequestParam("comment") String comment,
            Model model) {
        // 리뷰 추가 로직
        SeatReviewDTO review = new SeatReviewDTO();
        review.setSeatRank(rating);
        review.setDetail(comment);
        // 다른 필요한 필드들 설정
        seatReviewService.addReview(review);

        return "redirect:/seatReview";
    }
}//end

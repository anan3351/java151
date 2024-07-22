package com.example.demo.membership;

import java.sql.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.transaction.Transactional;

@Controller
@RequestMapping("/membership")
public class MembershipCont {
	public MembershipCont() {
	}

	@Autowired
	private MembershipDAO membershipDao;

	@PostMapping("/join-membership")
	@Transactional
	public ResponseEntity<String> joinMembership(@RequestBody MembershipDTO membershipDto) {
		try {
			String userId = membershipDto.getUser_id(); // user_id
			String membershipType = membershipDto.getMb_name(); // 멤버십 명

			System.out.println("Received userId: " + userId);
			System.out.println("Received membershipType: " + membershipType);

			if (userId == null || membershipType == null) {
				return ResponseEntity.badRequest().body("User ID or Membership Type is missing");
			}

			Date currentDate = new Date(System.currentTimeMillis());
			String couponId;
			int points = 0;
			int leftCount = 0;

			switch (membershipType) {
			case "DIAMOND":
				couponId = "1";
				points = 250000;
				leftCount = 3;
				break;
			case "GOLD":
				couponId = "2";
				points = 10000;
				leftCount = 2;
				break;
			case "SILVER":
				couponId = "3";
				leftCount = 1;
				break;
			case "BRONZE":
				couponId = "4";
				leftCount = 1;
				break;
			default:
				return ResponseEntity.badRequest().body("잘못된 멤버십 유형입니다.");
			}

			// Insert membership
			membershipDao.insertMembership(userId, membershipType, currentDate);

			// Insert coupon detail
			membershipDao.insertCouponDetail(userId, couponId, leftCount);

			// Update user points if applicable
			if (points > 0) {
				membershipDao.updateUserPoints(userId, points);
			}

			return ResponseEntity.ok("가입되었습니다.");
		} catch (Exception e) {
			return ResponseEntity.badRequest().body("가입 중 오류가 발생했습니다: " + e.getMessage());
		}
	}
	
	//멤버십 중복 가입 방지 함수
	@PostMapping("/check-membership")
	public ResponseEntity<Boolean> checkMembership(@RequestBody Map<String, String> request) {
		String userId = request.get("user_id");
		String mbName = request.get("mb_name");

		boolean isMember = membershipDao.isAlreadyMember(userId, mbName);
		return ResponseEntity.ok(isMember);
	}
	
	

}// end MembershipCont

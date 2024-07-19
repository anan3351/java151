package com.example.demo.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.coupon.CouponDAO;
import com.example.demo.coupon.CouponDTO;
import com.example.demo.hall.HallOrderDAO;
import com.example.demo.hall.HallOrderDTO;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Controller
@RequestMapping("/user")
public class UserCont {

	public UserCont() {
		System.out.println("-----UserCont() 객체생성됨");
	}// UserCont() end

	@Autowired
	private UserDAO userDao;

	@Autowired
	private CouponDAO couponDao;
	
	@Autowired
	private HallOrderDAO hallOrderDao;
	

	@RequestMapping("/form")
	public String form() {
		return "user/form";
	}// form() end

	@PostMapping("/insert")
	public String insert(UserDTO userDto, RedirectAttributes redirectAttributes) {
		try {
			userDao.insert(userDto);
			redirectAttributes.addFlashAttribute("registrationSuccess", true);
			return "redirect:/user/login"; // 성공 시 login으로 리다이렉트
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", e.getMessage());
			return "redirect:/user/form";
		}
	}

	@GetMapping("/login")
	public String loginForm(HttpServletRequest request) {
		// 회원가입 성공 후 리다이렉트된 경우에만 메시지를 표시
		if (request.getSession().getAttribute("registrationSuccess") != null) {
			request.setAttribute("showSuccessMessage", true);
			request.getSession().removeAttribute("registrationSuccess");
		}
		return "user/login";
	}

	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
		if (loggedInUser != null) {
			UserDTO userInfo = userDao.getUserById(loggedInUser.getUser_id());
			model.addAttribute("userInfo", userInfo);
		}
		return "user/mypage";
	}

	// 멤버십 페이지 연결
	@GetMapping("/mypage/membership")
	public ModelAndView membershipMypage(@RequestParam("user_id") String user_Id, HttpSession session, Model model) {
		UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
		ModelAndView mav = new ModelAndView();

		if (loggedInUser != null) {
			UserDTO userInfo = userDao.getUserById(loggedInUser.getUser_id());
			model.addAttribute("userInfo", userInfo);
		}
		mav.addObject("user_id", user_Id);
		mav.setViewName("membership/membership");
		return mav;
	}

	// 쿠폰 페이지 연결
	@GetMapping("/mypage/coupon")
	public ModelAndView couponMypage(@RequestParam("user_id") String user_id, HttpSession session, Model model) {
		UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
		ModelAndView mav = new ModelAndView();

		if (loggedInUser != null) {
			UserDTO userInfo = userDao.getUserById(loggedInUser.getUser_id());
			model.addAttribute("userInfo", userInfo);
		}

		mav.addObject("user_id", user_id);
		mav.setViewName("membership/coupon");
		List<CouponDTO> coupons = couponDao.getCouponsByUserId(user_id);
		model.addAttribute("coupons", coupons);

		return mav;
	}

	// 공연장 대관 내역 페이지 연결
	@GetMapping("/mypage/hallMypage")
	public ModelAndView hallMypage(@RequestParam("user_id") String user_id, HttpSession session, Model model) {
		UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
		ModelAndView mav = new ModelAndView();

		if (loggedInUser != null) {
			UserDTO userInfo = userDao.getUserById(loggedInUser.getUser_id());
			model.addAttribute("userInfo", userInfo);
		}

		HallOrderDTO order = hallOrderDao.getLatestOrder();
		model.addAttribute("order", order);
		mav.addObject("user_id", user_id);
		mav.setViewName("hall/hallMypage");

		return mav;
	}

	

	@RequestMapping("/pwcheck")
	public ModelAndView pwcheck() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/pwcheck");
		return mav;
	}// pwcheck() end

	@RequestMapping("/pwmodify")
	public ModelAndView pwmodify() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/pwmodify");
		return mav;
	}// pwmodify() end

	@GetMapping("/quit")
	public String quit(@RequestParam(value = "success", required = false) String success) {
		return "user/quit";
	}

	@RequestMapping("/agreement")
	public String agreement() {
		return "user/agreement";
	}// agreement() end

	// ID 중복체크
	@GetMapping("/checkUserId")
	@ResponseBody
	public String checkUserId(@RequestParam("user_id") String userId) {
		try {
			boolean isDuplicate = userDao.isUserIdDuplicate(userId);
			return isDuplicate ? "duplicate" : "available";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 이메일 중복체크
	@GetMapping("/checkEmail")
	@ResponseBody
	public String checkEmail(@RequestParam("email") String email) {
		try {
			boolean isDuplicate = userDao.isEmailDuplicate(email);
			return isDuplicate ? "duplicate" : "available";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	@RequestMapping("/join")
	public String join() {
		return "user/join";
	}// join() end

	// 로그인처리
	@PostMapping("/login")
	public String login(@RequestParam String user_id, @RequestParam String pwd,
			@RequestParam(required = false) String rememberMe, HttpServletResponse response, HttpSession session,
			RedirectAttributes redirectAttributes) {
		try {
			UserDTO user = userDao.login(user_id, pwd);
			if (user != null) {
				// 로그인 성공
				session.setAttribute("loggedInUser", user);// 로그인정보를저장

				if ("on".equals(rememberMe)) {
					// 로그인 유지를 위한 쿠키 생성
					Cookie cookie = new Cookie("remember-me", user.getUser_id());
					// cookie.setMaxAge(60); // 60초 동안 유효
					cookie.setMaxAge(1 * 24 * 60 * 60); // 1일 동안 유효
					// cookie.setMaxAge(7 * 24 * 60 * 60); // 7일 동안 유효
					cookie.setPath("/");
					response.addCookie(cookie);
				}

				return "redirect:/"; // 메인 페이지로 리다이렉트
			} else {
				// 로그인 실패
				redirectAttributes.addFlashAttribute("loginError", "아이디와 비밀번호를 다시 확인해주세요");
				return "redirect:/user/login";
			}
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("loginError", "로그인 처리 중 오류가 발생했습니다");
			return "redirect:/user/login";
		}
	}

	// 로그아웃처리
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/user/login";
	}

	// 회원정보수정
	@GetMapping("/formmodify")
	public String showModifyForm(HttpSession session, Model model) {
		UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
		if (loggedInUser != null) {
			UserDTO userInfo = userDao.getUserInfo(loggedInUser.getUser_id());
			model.addAttribute("userInfo", userInfo);
		}
		return "user/formmodify";
	}

	@PostMapping("/updateUser")
	public String updateUser(@ModelAttribute UserDTO userDto, HttpSession session,
			RedirectAttributes redirectAttributes) {
		try {
			int result = userDao.updateUserInfo(userDto);
			if (result > 0) {
				redirectAttributes.addFlashAttribute("message", "회원정보가 성공적으로 수정되었습니다.");
				// 세션의 사용자 정보도 업데이트
				session.setAttribute("loggedInUser", userDto);

			} else {
				redirectAttributes.addFlashAttribute("error", "회원정보 수정에 실패했습니다.");
			}
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "회원정보 수정 중 오류가 발생했습니다.");
		}
		return "redirect:/user/mypage";
	}

	@GetMapping("/pwmodify")
	public String showPasswordChangeForm() {
		return "user/pwmodify";
	}

	@PostMapping("/pwmodify")
	public String changePassword(@RequestParam String newPassword, @RequestParam String confirmPassword,
			HttpSession session, RedirectAttributes redirectAttributes) {
		UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");

		if (loggedInUser == null) {
			redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
			return "redirect:/user/login";
		}

		if (!newPassword.equals(confirmPassword)) {
			redirectAttributes.addFlashAttribute("error", "새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
			return "redirect:/user/pwmodify";
		}

		// 비밀번호 규칙 검증
		if (newPassword.length() < 8 || newPassword.length() > 12) {
			redirectAttributes.addFlashAttribute("error", "비밀번호는 8~12자 이내여야 합니다.");
			return "redirect:/user/pwmodify";
		}

		try {
			userDao.updatePassword(loggedInUser.getUser_id(), newPassword);
			redirectAttributes.addFlashAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
			return "redirect:/user/mypage";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "비밀번호 변경 중 오류가 발생했습니다.");
			return "redirect:/user/pwmodify";
		}
	}

	@GetMapping("/sellerpage")
	public String sellerPage(HttpSession session, Model model) {
		UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
		if (loggedInUser != null) {
			// 로그인한 사용자의 정보를 모델에 추가
			model.addAttribute("userInfo", loggedInUser);
			return "user/sellerpage"; // sellerpage.jsp 뷰를 반환
		} else {
			// 로그인하지 않은 경우 로그인 페이지로 리다이렉트
			return "redirect:/user/login";
		}
	}// sellerPage() end

	// 셀러 공연장 등록 페이지 연결
	@GetMapping("/sellerHallInsert")
	public ModelAndView hallInsert(@RequestParam(required = false) String hall_id, HttpSession session, Model model) {
		UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
		ModelAndView mav = new ModelAndView();

		if (loggedInUser != null) {
			UserDTO userInfo = userDao.getUserById(loggedInUser.getUser_id());
			model.addAttribute("userInfo", userInfo);
		}

		List<Map<String, Object>> hallList = userDao.sellerHallInsert(null);
		mav.addObject("hallList", hallList);
		mav.setViewName("user/sellerHallInsert");

		return mav;
	}

	// 하위 관 정보를 가져오는 API
	@GetMapping("/sellerHallInsert/getSubHalls")
	@ResponseBody
	public List<Map<String, Object>> getSubHalls(@RequestParam String hall_id) {
		return userDao.getSubHallsWithPrices(hall_id);
	}

	@Transactional
	@PostMapping("/sellerHallInsert/saveHallPrices")
	public ResponseEntity<String> saveHallPrices(@RequestBody Map<String, Object> requestData, HttpSession session) {
		try {
			String userId = (String) requestData.get("user_id");
			List<Map<String, String>> halls = (List<Map<String, String>>) requestData.get("halls");

			UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
			if (loggedInUser == null || !loggedInUser.getUser_id().equals(userId)) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("올바른 사용자 인증이 필요합니다.");
			}

			userDao.saveHallPricesAndUpdateUser(halls, userId);
			return ResponseEntity.ok("Success");
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("저장 중 오류가 발생했습니다: " + e.getMessage());
		}
	}

	@PostMapping("/sellerHallInsert/updateHallPrices")
	public ResponseEntity<String> updateHallPrices(@RequestBody Map<String, Object> requestData, HttpSession session) {

		try {
			String userId = (String) requestData.get("user_id");
			List<Map<String, String>> halls = (List<Map<String, String>>) requestData.get("halls");

			UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
			if (loggedInUser == null || !loggedInUser.getUser_id().equals(userId)) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("올바른 사용자 인증이 필요합니다.");
			}

			for (Map<String, String> hall : halls) {
				String hallId = hall.get("hall_id");
				String hDay = hall.get("h_day");

				Map<String, Object> params = new HashMap<>();
				params.put("hall_id", hallId);
				params.put("h_day", Integer.parseInt(hDay));

				userDao.updateHallPrice(params);
			}

			return ResponseEntity.ok("Success");
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("수정 중 오류가 발생했습니다: " + e.getMessage());
		}
	}

	@GetMapping("/sellerApprove")
	public String sellerApprove(HttpSession session, Model model) {
		UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
		if (loggedInUser != null) {
			// 로그인한 사용자의 정보를 모델에 추가
			model.addAttribute("userInfo", loggedInUser);
			return "user/sellerApprove"; // sellerpage.jsp 뷰를 반환
		} else {
			// 로그인하지 않은 경우 로그인 페이지로 리다이렉트
			return "redirect:/user/login";
		}
	}// sellerPage() end

	@PostMapping("/delete")
	public String deleteUser(HttpSession session, RedirectAttributes redirectAttributes) {
		UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
		String user_id = loggedInUser.getUser_id();

		try {
			int result = userDao.deleteUser(user_id);
			if (result > 0) {
				session.invalidate();
				return "redirect:/user/quit?success=true";
			} else {
				redirectAttributes.addFlashAttribute("error", "사용자를 찾을 수 없습니다.");
				return "redirect:/error";
			}
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", "회원 탈퇴 중 오류가 발생했습니다.");
			return "redirect:/error";
		}
	}

	@RequestMapping("/findid")
	public String findid() {
		return "user/findid";
	}// findid() end

	@RequestMapping("/findpw")
	public String findpw() {
		return "user/findpw";
	}// findpw() end

	@GetMapping("/checkLoginStatus")
	@ResponseBody
	public ResponseEntity<Map<String, Boolean>> checkLoginStatus(HttpSession session) {
		UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");

		Map<String, Boolean> response = new HashMap<>();
		response.put("isLoggedIn", loggedInUser != null);

		return ResponseEntity.ok(response);
	}// End 로그인 상태 확인을 위한 함수

}// class end

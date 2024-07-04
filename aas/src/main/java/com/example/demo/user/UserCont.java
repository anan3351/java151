package com.example.demo.user;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/user")
public class UserCont {
	
		public UserCont() {
			System.out.println("-----UserCont() 객체생성됨");
		}//UserCont() end
		
		@Autowired
	    private UserDAO userDao;
		
		@RequestMapping("/form")
		public String form() {
		        return "user/form";      
		    }//form() end
		
		@PostMapping("/insert")
		public String insert(UserDTO userDto, RedirectAttributes redirectAttributes) {
		    try {
		        userDao.insert(userDto);
		        redirectAttributes.addFlashAttribute("registrationSuccess", true);
		        return "redirect:/user/login";  // 성공 시 login으로 리다이렉트
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
		
		@RequestMapping("/formmodify")
		public ModelAndView formmodify() {      
		        ModelAndView mav=new ModelAndView();
		        mav.setViewName("user/formmodify");
		        return mav;        
		    }//formmodify() end
		
		@RequestMapping("/pwcheck")
		public ModelAndView pwcheck() {      
		        ModelAndView mav=new ModelAndView();
		        mav.setViewName("user/pwcheck");
		        return mav;        
		    }//pwcheck() end
		
		@RequestMapping("/pwmodify")
		public ModelAndView pwmodify() {      
		        ModelAndView mav=new ModelAndView();
		        mav.setViewName("user/pwmodify");
		        return mav;        
		    }//pwmodify() end
		
		@RequestMapping("/quit")
		public ModelAndView quit() {      
		        ModelAndView mav=new ModelAndView();
		        mav.setViewName("user/quit");
		        return mav;        
		    }//quit() end
		
		@RequestMapping("/agreement")
		public String agreement() {
		        return "user/agreement";      
		    }//agreement() end
		
		//ID 중복체크
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
		
		//이메일 중복체크
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
		    }//join() end
		
		//로그인처리
		@PostMapping("/login")
		public String login(@RequestParam String user_id, @RequestParam String pwd, 
                @RequestParam(required = false) String rememberMe,
                HttpServletResponse response, HttpSession session,
                RedirectAttributes redirectAttributes) {
		    try {
		        UserDTO user = userDao.login(user_id, pwd);
		        if (user != null) {
		            // 로그인 성공
		            session.setAttribute("loggedInUser", user);//로그인정보를저장
		            
		            if ("on".equals(rememberMe)) {
		                // 로그인 유지를 위한 쿠키 생성
		                Cookie cookie = new Cookie("remember-me", user.getUser_id());
		                //cookie.setMaxAge(60); // 60초 동안 유효
		                cookie.setMaxAge(1*24*60*60); // 1일 동안 유효
		                //cookie.setMaxAge(7 * 24 * 60 * 60); // 7일 동안 유효
		                cookie.setPath("/");
		                response.addCookie(cookie);
		            }
		            return "redirect:/";  // 메인 페이지로 리다이렉트
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
		
		//로그아웃처리
		@GetMapping("/logout")
		public String logout(HttpSession session) {
		    session.invalidate();
		    return "redirect:/user/login";
		}
		
	
		
		
		
}//class end
	


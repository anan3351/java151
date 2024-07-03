package com.example.demo.user;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;


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
		
		@RequestMapping("/mypage")
		public ModelAndView mypage() {      
		        ModelAndView mav=new ModelAndView();
		        mav.setViewName("user/mypage");
		        return mav;        
		    }//mypage() end
		
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
		
		
}//class end
	


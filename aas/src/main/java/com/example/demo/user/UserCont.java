package com.example.demo.user;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/user")
public class UserCont {
	
		public UserCont() {
			System.out.println("-----UserCont() 객체생성됨");
		}//UserCont() end
		
		@RequestMapping("/form")
		public ModelAndView joinform() {      
		        ModelAndView mav=new ModelAndView();
		        mav.setViewName("user/form");
		        return mav;        
		    }//joinform() end
		
		@RequestMapping("/login")
		public ModelAndView loginform() {      
		        ModelAndView mav=new ModelAndView();
		        mav.setViewName("user/login");
		        return mav;        
		    }//loginform() end
		
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
		
		
		
}//class end
	


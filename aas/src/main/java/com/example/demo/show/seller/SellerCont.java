package com.example.demo.show.seller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;  // 올바른 Model 인터페이스 임포트
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.user.UserDAO;
import com.example.demo.user.UserDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class SellerCont {
	
	@Autowired
    private UserDAO userDao;
	
	@GetMapping("/seller/create")
	public String mypage(HttpSession session, Model model) {
		UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
		if (loggedInUser != null) {
            model.addAttribute("userInfo", loggedInUser);
            return "seller/showForm"; 
        } else {
            return "redirect:/user/login";
        }
	}
	
	@GetMapping("/seller/list")
	public String list(HttpSession session, Model model) {
		UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
		if (loggedInUser != null) {
            model.addAttribute("userInfo", loggedInUser);
            return "seller/list";
        } else {
            return "redirect:/user/login";
        }
	}

	@GetMapping("/seller/discount")
	public String mypage2(HttpSession session, Model model) {
		UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
		if (loggedInUser != null) {
            model.addAttribute("userInfo", loggedInUser);
            return "seller/discountForm";
        } else {
            return "redirect:/user/login";
        }
	}
}

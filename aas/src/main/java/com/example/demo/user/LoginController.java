package com.example.demo.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.github.scribejava.core.model.OAuth2AccessToken;
import org.json.simple.parser.ParseException;

import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {

    @Autowired
    private NaverLoginBO naverLoginBO;
    
    @Autowired
    private UserDAO userDao;

    @GetMapping("/naverLogin")
    public String naverLogin(HttpSession session) {
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        return "redirect:" + naverAuthUrl;
    }

    @GetMapping("/naver/callback")
    public String callback(@RequestParam String code, @RequestParam String state, HttpSession session, Model model) {
        try {
            OAuth2AccessToken oauthToken = naverLoginBO.getAccessToken(session, code, state);
            String apiResult = naverLoginBO.getUserProfile(oauthToken);
            
            JSONParser parser = new JSONParser();
            JSONObject jsonObj = (JSONObject) parser.parse(apiResult);
            JSONObject response_obj = (JSONObject) jsonObj.get("response");
            
            UserDTO userDTO = new UserDTO();
            userDTO.setTel_num((String) response_obj.get("mobile"));
            userDTO.setUser_name((String) response_obj.get("name"));
            userDTO.setEmail((String) response_obj.get("email"));
            
            userDTO = userDao.saveOrUpdateNaverUser(userDTO);
            session.setAttribute("loggedInUser", userDTO);
            
            System.out.println("User logged in: " + userDTO.getUser_name());
            
            return "redirect:/";
        } catch (IOException e) {
            model.addAttribute("error", "네이버 로그인 처리 중 오류가 발생했습니다: " + e.getMessage());
            return "error";
        } catch (ParseException e) {
            model.addAttribute("error", "사용자 정보 파싱 중 오류가 발생했습니다: " + e.getMessage());
            return "error";
        } catch (Exception e) {
            model.addAttribute("error", "예상치 못한 오류가 발생했습니다: " + e.getMessage());
            return "error";
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("loggedInUser");
        return "redirect:/";
    }

    @GetMapping("/login")
    public String login() {
        return "login";  // login.jsp 페이지로 이동
    }

    @GetMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", loggedInUser);
        return "mypage";  // mypage.jsp 페이지로 이동
    }

   

    @GetMapping("/loginError")
    public String loginError(Model model) {
        model.addAttribute("loginError", "로그인에 실패했습니다. 다시 시도해 주세요.");
        return "login";
    }

   

    // 회원 탈퇴
    @PostMapping("/deleteUser")
    public String deleteUser(HttpSession session) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            userDao.deleteUser(loggedInUser.getUser_id());
            session.removeAttribute("loggedInUser");
        }
        return "redirect:/";
    }
}
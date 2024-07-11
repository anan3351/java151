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
            System.out.println("Received callback with code: " + code + " and state: " + state);
            
            OAuth2AccessToken oauthToken = naverLoginBO.getAccessToken(session, code, state);
            System.out.println("Obtained OAuth token: " + oauthToken.getAccessToken());
            
            String apiResult = naverLoginBO.getUserProfile(oauthToken);
            System.out.println("API Result: " + apiResult);

            JSONParser parser = new JSONParser();
            JSONObject jsonObj = (JSONObject) parser.parse(apiResult);
            JSONObject response_obj = (JSONObject) jsonObj.get("response");
            System.out.println("Parsed response: " + response_obj);
            

            UserDTO userDTO = new UserDTO();
            String naverId = (String) response_obj.get("id");
            String truncatedId = truncateNaverId(naverId, 10); // 10자로 제한
            String userId = "NAVER_" + truncatedId;

            // 중복 확인 및 처리
            int suffix = 1;
            String originalUserId = userId;
            while (userDao.isUserIdExists(userId)) {
                userId = originalUserId + suffix;
                suffix++;
            }

            userDTO.setUser_id(userId);
            userDTO.setTel_num((String) response_obj.get("mobile"));
            userDTO.setUser_name((String) response_obj.get("name"));
            userDTO.setEmail((String) response_obj.get("email"));
            System.out.println("Created UserDTO: " + userDTO);

            userDTO = userDao.saveOrUpdateNaverUser(userDTO);
            System.out.println("After saveOrUpdateNaverUser: " + userDTO);

            session.setAttribute("loggedInUser", userDTO);
            System.out.println("User logged in: " + userDTO.getUser_name());

            return "redirect:/";
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error in callback: " + e.getMessage());
            model.addAttribute("error", "예상치 못한 오류가 발생했습니다: " + e.getMessage());
            return "error";  // error.jsp로 이동
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
    
    private String truncateNaverId(String naverId, int length) {
        if (naverId == null) {
            return "";
        }
        // naverId의 뒷부분 length자리를 사용
        int startIndex = Math.max(0, naverId.length() - length);
        return naverId.substring(startIndex);
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
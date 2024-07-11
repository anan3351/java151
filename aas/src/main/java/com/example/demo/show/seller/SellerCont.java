package com.example.demo.show.seller;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;  // 올바른 Model 인터페이스 임포트
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.show.ShowDAO;
import com.example.demo.user.UserDAO;
import com.example.demo.user.UserDTO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/seller")
public class SellerCont {
    
    @Autowired
    private UserDAO userDao;
    
    @Autowired
    private ShowDAO showDao;
    

    // 공연 등록 페이지
    @GetMapping("/create")
    public String mypage(HttpSession session, Model model) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("userInfo", loggedInUser);
            return "seller/showForm"; 
        } else {
            return "redirect:/user/login";
        }
    }
    
    
    // 공연 등록
    @PostMapping("/insert")
    public String insert(
        @RequestParam Map<String, Object> map,
        @RequestParam Map<String, MultipartFile> files,
        HttpServletRequest req, HttpSession session, Model model) {
    	
    	String show_id = showDao.showid_make();
    	map.put("show_id", show_id);
    	
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("userInfo", loggedInUser);
            
            // 이미지 저장 경로
            ServletContext application = req.getServletContext();
            String basePath = application.getRealPath("/storage");
            Map<String, String> fileNames = new HashMap<>();

            files.forEach((key, value) -> {
                if (value != null && !value.isEmpty()) {
                    try {
                        String o_name = value.getOriginalFilename();
                        int lastDot = o_name.lastIndexOf(".");
                        
                        String show_name = (String) map.get("title");
                        String filename = "all_about_show_" + show_name + o_name.substring(lastDot);
                        File saveFile = new File(basePath, filename);

                        int count = 1;
                        while (saveFile.exists()) {
                            lastDot = filename.lastIndexOf(".");
                            filename = "all_about_show_" + show_name + "_" + count + filename.substring(lastDot);
                            saveFile = new File(basePath, filename);
                            count++;
                        }

                        value.transferTo(saveFile);
                        fileNames.put(key, filename);

                    } catch (Exception e) {
                        System.out.println("이미지 저장 실패: " + e.getMessage());
                    }
                } else {
                    fileNames.put(key, null);
                }
            });

            map.putAll(fileNames);
            map.put("user_id", loggedInUser.getUser_id());
            showDao.insert(map);
            return "redirect:/seller/list";
        } else {
            return "redirect:/user/login";
        }
    }

    
    // 공연장 검색
    @GetMapping("/hallSearch")
    public String hall_search(HttpSession session, Model model) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("userInfo", loggedInUser);
            return "seller/hallSearch"; 
        } else {
            return "redirect:/user/login";
        }
    }

    
    // 공연장 검색  
    @GetMapping("/hallList")
    @ResponseBody
    public String hall_return(@RequestParam(defaultValue = "") String h_name) {
        List<Map<String, Object>> list = showDao.hall_search(h_name);
        StringBuilder html = new StringBuilder();
        html.append("<table class='table'>");
        html.append("<thead><tr><th>선택</th><th>공연장ID</th><th>공연장명</th><th>세부관</th><th>주소</th></tr></thead>");
        html.append("<tbody>");
        for (Map<String, Object> hall : list) {
            html.append("<tr>");
            html.append("<td><input type='radio' name='selected_hall' value='" + hall.get("hall_id") + "'></td>");
            html.append("<td>" + hall.get("hall_id") + "</td>");
            html.append("<td>" + hall.get("h_name") + "</td>");
            if (hall.get("miniHall") != null) {
            	html.append("<td>" + hall.get("miniHall") + "</td>");
            } else {
            	html.append("<td>" + " " + "</td>");
            }
            html.append("<td>" + hall.get("addr") + "</td>");
            html.append("</tr>");
        }
        html.append("</tbody></table>");
        html.append("<button onclick='selectHall()' class='btn btn-primary'>선택</button>");
        return html.toString();
    }


    
    @GetMapping("/list")
    public ModelAndView list(HttpSession session, Model model) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("userInfo", loggedInUser);
            
            ModelAndView mav = new ModelAndView();
    	    mav.setViewName("product/list");
    	    mav.addObject("list", showDao.list());
    	    return mav;
        } else return null;
    }
    
    

    @GetMapping("/discount")
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

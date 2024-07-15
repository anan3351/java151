package com.example.demo.show.seller;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;  // 올바른 Model 인터페이스 임포트
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.hall.HallEntity;
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
    public String hall_return(@RequestParam(defaultValue = "") String h_name,
                              @RequestParam(defaultValue = "1") int page,
                              Model model) {
        int pageSize = 5; // 페이지당 항목 수
        List<Map<String, Object>> list = showDao.hall_search(h_name, (page - 1) * pageSize, pageSize);
        int totalCount = showDao.hall_search_count(h_name);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        model.addAttribute("list", list);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("page", page);

        return "seller/hallList";
    }

    /*
    @GetMapping("/list")
    public String hallList(@PageableDefault(size = 5) Pageable pageable,
                           @RequestParam(defaultValue = "") String h_name, Model model) {

        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int offset = currentPage * pageSize;

        List<HallEntity> halls;
        int totalElements;

        if (!word.isEmpty()) {
            if (field.equals("hname")) {
                halls = hallRepository.findByHnameContainingWithoutDash(word, pageSize, offset);
                totalElements = hallRepository.countByHnameContainingWithoutDash(word);
            } else if (field.equals("addr")) {
                halls = hallRepository.findByAddrContainingWithoutDash(word, pageSize, offset);
                totalElements = hallRepository.countByAddrContainingWithoutDash(word);
            } else {
                halls = hallRepository.findByHallIdWithoutDash(pageSize, offset);
                totalElements = hallRepository.countByHallIdWithoutDash();
            }
        } else {
            halls = hallRepository.findByHallIdWithoutDash(pageSize, offset);
            totalElements = hallRepository.countByHallIdWithoutDash();
            //halls = hallRepository.findHallsWithMiniHallNotNull(pageSize, offset);
        }
        

        Page<HallEntity> ulist = new PageImpl<>(halls, pageable, totalElements);

        int pageNumber = ulist.getPageable().getPageNumber(); //현재페이지
        int totalPages = ulist.getTotalPages();  //총 페이지 수. 검색에따라 10개면 10개..
        int pageBlock = 10; //블럭의 수 1, 2, 3, 4, 5
        int startBlockPage = ((pageNumber) / pageBlock) * pageBlock + 1; //현재 페이지가 7이라면 1*5
        int endBlockPage = startBlockPage + pageBlock - 1; //6+5-1=10. 6,7,8,9,10해서 10.
        endBlockPage = totalPages < endBlockPage ? totalPages : endBlockPage;

        model.addAttribute("startBlockPage", startBlockPage);
        model.addAttribute("endBlockPage", endBlockPage);
        model.addAttribute("ulist", ulist);
        model.addAttribute("field", field);
        model.addAttribute("word", word);
        
        return "hall/hallList";
    }*/
    
    
    
    

    
    @GetMapping("/list")
    public ModelAndView list(HttpSession session, Model model) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("userInfo", loggedInUser);
            
            ModelAndView mav = new ModelAndView();
    	    mav.setViewName("show/list");
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

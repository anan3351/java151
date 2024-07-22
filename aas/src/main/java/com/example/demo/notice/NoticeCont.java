package com.example.demo.notice;

import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.io.File;
import java.nio.file.Files;
import java.io.IOException;
import java.util.HashMap;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import org.springframework.http.HttpStatus;
import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;
import java.io.InputStream;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ClassPathResource;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.user.UserDAO;
import com.example.demo.user.UserDTO;

import jakarta.servlet.http.HttpSession;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/notice")
public class NoticeCont {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeCont.class);
	
	public NoticeCont() {
		System.out.println("-----NoticeCont() 객체생성됨");
	}//NoticeCont() end

	@Autowired
    private UserDAO userDao;
	
	@Autowired
    private SqlSession sqlSession;
	
	private static final String UPLOAD_DIR = "src/main/resources/static/uploads/";
	
	 
	@GetMapping("/notice")
	public String noticeList(Model model, HttpSession session, 
	                         @RequestParam(defaultValue = "1") int page,
	                         @RequestParam(defaultValue = "10") int size,
	                         @RequestParam(required = false) String field,
	                         @RequestParam(required = false) String word) {

	    UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
	    if (loggedInUser != null) {
	        String userId = loggedInUser.getUser_id();
	        String userAuth = loggedInUser.getAuth();
	        model.addAttribute("userAuth", userAuth);

	        // 검색 파라미터 추가
	        Map<String, Object> params = new HashMap<>();
	        params.put("offset", (page - 1) * size);
	        params.put("size", size);
	        params.put("field", field);
	        params.put("word", word);

	        List<Map<String, Object>> noticeList = sqlSession.selectList("notice.getNoticeList", params);

	        int totalCount = sqlSession.selectOne("notice.getTotalNoticeCount", params);

	        // 페이징 정보 계산
	        int totalPages = (int) Math.ceil((double) totalCount / size);
	        int startPage = Math.max(1, page - 4);
	        int endPage = Math.min(totalPages, page + 4);

	        model.addAttribute("noticeList", noticeList);
	        model.addAttribute("currentPage", page);
	        model.addAttribute("totalPages", totalPages);
	        model.addAttribute("startPage", startPage);
	        model.addAttribute("endPage", endPage);
	        model.addAttribute("field", field);
	        model.addAttribute("word", word);
	    } else {
	        return "redirect:/user/login";
	    }
	    return "notice/notice";
	}

	  
	
	@RequestMapping("/noticeform")
	public ModelAndView noticeform() {      
	        ModelAndView mav=new ModelAndView();
	        mav.setViewName("notice/noticeform");
	        return mav;        
	    }//noticeform() end
	
	@GetMapping("/noticedetail/{n_id}")
	public String detail(@PathVariable Long n_id, Model model) {
	    sqlSession.update("notice.increaseViewCount", n_id);
	    
	    Map<String, Object> notice = sqlSession.selectOne("notice.getNotice", n_id);
	    if (notice != null) {
	        String nText = (String) notice.get("n_text");
	        System.out.println("Original n_text content: " + nText);
	        
	        // HTML 내용을 안전하게 처리하되, 이미지 태그의 src 속성 유지
	        Safelist safelist = Safelist.relaxed()
	            .addAttributes("img", "src", "title", "alt", "width", "height")
	            .addProtocols("img", "src", "data");
	        
	        String safeHtml = Jsoup.clean(nText, safelist);
	        System.out.println("Safe HTML content: " + safeHtml);
	        
	        notice.put("n_text", safeHtml);
	        model.addAttribute("notice", notice);
	    } else {
	        model.addAttribute("errorMessage", "Notice not found");
	    }
	    return "notice/noticedetail";
	}
	
	@PostMapping("/insert")
	public String insertNotice(@RequestParam String title, @RequestParam String content, HttpSession session) {
	    UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
	    if (loggedInUser != null && "M".equals(loggedInUser.getAuth())) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("user_id", loggedInUser.getUser_id());
	        params.put("title", title);
	        params.put("n_text", content);  // 이미지를 포함한 전체 HTML 내용
	        
	        sqlSession.insert("notice.insertNotice", params);
	        return "redirect:/notice/notice";
	    } else {
	        return "redirect:/user/login";
	    }
	}
	
	
	@ResponseBody
	public ResponseEntity<Map<String, String>> uploadImage(@RequestParam("file") MultipartFile file) {
	    Map<String, String> result = new HashMap<>();
	    try {
	        String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
	        Path uploadPath = Paths.get(UPLOAD_DIR);

	        System.out.println("Upload directory: " + uploadPath.toAbsolutePath());
	        System.out.println("File name: " + fileName);

	        if (!Files.exists(uploadPath)) {
	            Files.createDirectories(uploadPath);
	            System.out.println("Created directory: " + uploadPath);
	        }

	        Path filePath = uploadPath.resolve(fileName);
	        System.out.println("Full file path: " + filePath.toAbsolutePath());

	        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

	        String imageUrl = "/uploads/" + fileName;
	        System.out.println("Image URL: " + imageUrl);

	        result.put("location", imageUrl);
	        return ResponseEntity.ok(result);
	    } catch (IOException e) {
	        System.out.println("Failed to upload image: " + e.getMessage());
	        e.printStackTrace();
	        result.put("error", "Failed to upload image: " + e.getMessage());
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
	    }
	}
	
	@GetMapping("/edit/{n_id}")
	public String editForm(@PathVariable Long n_id, Model model, HttpSession session) {
	    UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
	    if (loggedInUser != null && "M".equals(loggedInUser.getAuth())) {
	        Map<String, Object> notice = sqlSession.selectOne("notice.getNotice", n_id);
	        if (notice != null) {
	            model.addAttribute("notice", notice);
	            return "notice/noticeupdate";
	        }
	    }
	    return "redirect:/notice/notice";
	}

	@PostMapping("/update")
	public String updateNotice(@RequestParam Long n_id, @RequestParam String title, 
	                           @RequestParam String content, HttpSession session) {
	    UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
	    if (loggedInUser != null && "M".equals(loggedInUser.getAuth())) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("n_id", n_id);
	        params.put("title", title);
	        params.put("n_text", content);
	        
	        sqlSession.update("notice.updateNotice", params);
	        return "redirect:/notice/noticedetail/" + n_id;
	    }
	    return "redirect:/notice/notice";
	}
	
	@PostMapping("/delete")
	public String deleteNotice(@RequestParam Long n_id, HttpSession session) {
	    UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
	    if (loggedInUser != null && "M".equals(loggedInUser.getAuth())) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("n_id", n_id);
	        
	        // 데이터베이스에서 게시글 삭제
	        sqlSession.delete("notice.deleteNotice", params);
	        
	        return "redirect:/notice/notice";
	    } else {
	        return "redirect:/user/login";
	    }
	}

	private void deleteImagesFromContent(String content) {
	    // HTML 파싱
	    Document doc = Jsoup.parse(content);
	    
	    // 모든 img 태그 찾기
	    Elements imgTags = doc.select("img");
	    
	    for (Element img : imgTags) {
	        String src = img.attr("src");
	        if (src.startsWith("/uploads/")) {
	            // 파일 시스템 경로 구성
	            String filePath = System.getProperty("user.dir") + "/src/main/resources/static" + src;
	            File file = new File(filePath);
	            
	            // 파일 삭제
	            if (file.exists()) {
	                boolean deleted = file.delete();
	                if (deleted) {
	                    System.out.println("Deleted file: " + filePath);
	                } else {
	                    System.out.println("Failed to delete file: " + filePath);
	                }
	            }
	        }
	    }
	}
	
}//class end

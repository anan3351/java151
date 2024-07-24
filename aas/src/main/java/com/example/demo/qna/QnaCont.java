package com.example.demo.qna;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.user.UserDAO;
import com.example.demo.user.UserDTO;

import jakarta.servlet.http.HttpSession;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

@Controller
@RequestMapping("/qna")
public class QnaCont {

	public QnaCont() {
		System.out.println("-----Qna() 객체생성됨");
	}//NoticeCont() end

	@Autowired
    private UserDAO userDao;

	
	@Autowired
    private SqlSession sqlSession;
	 
	@GetMapping("/qna")
	public String qnaList(Model model, HttpSession session, 
	                      @RequestParam(defaultValue = "1") int page,
	                      @RequestParam(defaultValue = "10") int size,
	                      @RequestParam(required = false) String field,
	                      @RequestParam(required = false) String word) {
	    UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
	    if (loggedInUser == null) {
	        return "redirect:/user/login";
	    }

	    model.addAttribute("loggedInUser", loggedInUser);
	    String userId = loggedInUser.getUser_id();
	    String userAuth = loggedInUser.getAuth();
	    model.addAttribute("userAuth", userAuth);

	    Map<String, Object> params = new HashMap<>();
	    params.put("offset", (page - 1) * size);
	    params.put("size", size);
	    params.put("field", field);
	    params.put("word", word);
	    params.put("userId", userId);

	    List<Map<String, Object>> qnaListWithAnswers;
	    int totalCount;

	    // 모든 사용자에 대해 동일한 쿼리를 사용합니다.
	    qnaListWithAnswers = sqlSession.selectList("qna.getAllQnaListWithAnswers", params);
	    totalCount = sqlSession.selectOne("qna.getTotalQnaCount", params);

	    List<Map<String, Object>> structuredQnaList = new ArrayList<>();
	    Map<String, Object> currentQuestion = null;
	    List<Map<String, Object>> currentAnswers = null;

	    for (Map<String, Object> row : qnaListWithAnswers) {
	        if (currentQuestion == null || !currentQuestion.get("question_id").equals(row.get("question_id"))) {
	            if (currentQuestion != null) {
	                currentQuestion.put("answers", currentAnswers);
	                structuredQnaList.add(currentQuestion);
	            }
	            currentQuestion = new HashMap<>(row);
	            currentAnswers = new ArrayList<>();
	            
	            // 접근 권한 확인 (Boolean 타입 처리)
	            boolean isOpen = row.get("q_open") instanceof Boolean ? (Boolean)row.get("q_open") : ((Integer)row.get("q_open") == 1);
	            boolean canAccess = isOpen || 
	                                userId.equals(row.get("user_id")) ||
	                                "M".equals(userAuth) || 
	                                "S".equals(userAuth);
	            currentQuestion.put("canAccess", canAccess);
	        }
	        if (row.get("answer_id") != null) {
	            Map<String, Object> answer = new HashMap<>(row);
	            answer.put("question_id", row.get("answer_id"));
	            answer.put("q_title", row.get("answer_title"));
	            answer.put("q_text", row.get("answer_text"));
	            answer.put("q_date", row.get("answer_date"));
	            answer.put("user_id", row.get("answer_user_id"));  // 답변 작성자 ID 사용
	         // 답변의 접근 권한 확인 (Boolean 타입 처리)
	            boolean isAnswerOpen = row.get("answer_q_open") instanceof Boolean ? (Boolean)row.get("answer_q_open") : ((Integer)row.get("answer_q_open") == 1);
	            boolean canAccessAnswer = isAnswerOpen || 
	                                      userId.equals(row.get("answer_user_id")) ||  // 답변 작성자 ID와 비교
	                                      "M".equals(userAuth) || 
	                                      "S".equals(userAuth);
	            answer.put("canAccess", canAccessAnswer);
	            currentAnswers.add(answer);
	        }
	    }
	    if (currentQuestion != null) {
	        currentQuestion.put("answers", currentAnswers);
	        structuredQnaList.add(currentQuestion);
	    }

	    // 페이징 정보 계산
	    int totalPages = (int) Math.ceil((double) totalCount / size);
	    int startPage = Math.max(1, page - 4);
	    int endPage = Math.min(totalPages, page + 4);

	    model.addAttribute("qnaList", structuredQnaList);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", totalPages);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("field", field);
	    model.addAttribute("word", word);

	    return "qna/qna";
	}

	  
	
	@GetMapping("/qnaform")
	public String qnaForm(Model model, HttpSession session) {
	    UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
	    if (loggedInUser == null) {
	        return "redirect:/user/login";
	    }
	    return "qna/qnaform";
	}
	
	@GetMapping("/qnadetail")
	public String qnaDetail(@RequestParam("id") int question_id, Model model, HttpSession session) {
	    UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
	    if (loggedInUser == null) {
	        return "redirect:/user/login";
	    }

	    try {
	        Map<String, Object> qna = sqlSession.selectOne("qna.getQnaById", question_id);
	        
	        if (qna != null) {
	        	// 비공개 글인 경우 작성자와 관리자, 그리고 S 권한 사용자만 볼 수 있음
	        	if ("0".equals(qna.get("q_open").toString()) && 
	        	    !loggedInUser.getUser_id().equals(qna.get("user_id")) &&
	        	    !"M".equals(loggedInUser.getAuth()) &&
	        	    !"S".equals(loggedInUser.getAuth())) {
	        	    return "error/403"; // 접근 권한 없음
	        	}
	            
	            model.addAttribute("qna", qna);
	            model.addAttribute("userAuth", loggedInUser.getAuth());
	            return "qna/qnadetail";
	        } else {
	            return "error/404";
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error/500";
	    }
	}
	
	@PostMapping("/insert")
	public String insertQna(@RequestParam Map<String, String> params, HttpSession session) {
	    UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
	    if (loggedInUser == null) {
	        return "redirect:/user/login";
	    }

	    params.put("user_id", loggedInUser.getUser_id());
	    
	 // 사용자의 auth에 따라 카테고리 설정
	    if ("M".equals(loggedInUser.getAuth()) || "S".equals(loggedInUser.getAuth())) {
	        params.put("category", "A");  // 관리자 또는 S인 경우
	    } else {
	        params.put("category", "Q");  // 그 외의 경우
	    }
	    
	    try {
	        int result = sqlSession.insert("qna.insertQna", params);
	        if (result > 0) {
	            return "redirect:/qna/qna";
	        } else {
	            // 에러 처리
	            return "error/500";
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error/500";
	    }
	}
	
	
	@GetMapping("/answerform")
	public String answerForm(@RequestParam("id") int parentId, Model model, HttpSession session) {
	    UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
	    if (loggedInUser == null || (!"M".equals(loggedInUser.getAuth()) && !"S".equals(loggedInUser.getAuth()))) {
	        return "redirect:/user/login";
	    }
	    
	    Map<String, Object> qna = sqlSession.selectOne("qna.getQnaById", parentId);
	    if (qna == null || "A".equals(qna.get("category"))) {
	        return "error/400"; // 잘못된 요청
	    }
	    
	    model.addAttribute("parentId", parentId);
	    return "qna/answerform";
	}

	@PostMapping("/insertAnswer")
	public String insertAnswer(@RequestParam Map<String, String> params, HttpSession session) {
	    UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
	    if (loggedInUser == null || (!"M".equals(loggedInUser.getAuth()) && !"S".equals(loggedInUser.getAuth()))) {
	        return "redirect:/user/login";
	    }

	    params.put("user_id", loggedInUser.getUser_id());
	    params.put("category", "A"); // 답변은 항상 카테고리 'A'

	    if (!params.containsKey("parent_id")) {
	        return "error/400";
	    }

	    String parentIdStr = params.get("parent_id");
	    Integer parentId;
	    try {
	        parentId = Integer.parseInt(parentIdStr);
	    } catch (NumberFormatException e) {
	        return "error/400";
	    }

	    try {
	        Map<String, Object> parentQna = sqlSession.selectOne("qna.getQnaById", parentId);
	        if (parentQna == null) {
	            return "error/404";
	        }

	        Boolean parentQOpen = (Boolean) parentQna.get("q_open");
	        params.put("q_open", parentQOpen ? "1" : "0");

	        int result = sqlSession.insert("qna.insertAnswer", params);
	        if (result > 0) {
	            // 새로 삽입된 답변의 ID를 별도 쿼리로 조회
	            Integer newAnswerId = sqlSession.selectOne("qna.getLastInsertId");
	            if (newAnswerId != null) {
	                return "redirect:/qna/qnadetail?id=" + newAnswerId;
	            } else {
	                // 새 ID를 얻지 못했을 경우 부모 글 상세 페이지로 리다이렉트
	                return "redirect:/qna/qnadetail?id=" + parentId;
	            }
	        } else {
	            return "error/500";
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error/500";
	    }
	}
	
	@GetMapping("/update")
	public String editForm(@RequestParam("id") int questionId, Model model, HttpSession session) {
	    UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
	    if (loggedInUser == null) {
	        return "redirect:/user/login";
	    }
	    
	    Map<String, Object> qna = sqlSession.selectOne("qna.getQnaById", questionId);
	    
	    if (qna == null || !loggedInUser.getUser_id().equals(qna.get("user_id"))) {
	        return "error/403"; // 권한 없음
	    }
	    
	    model.addAttribute("qna", qna);
	    return "qna/qnaedit";
	}

	@PostMapping("/update")
	public String updateQna(@RequestParam Map<String, String> params, HttpSession session, RedirectAttributes redirectAttributes) {
	    UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
	    if (loggedInUser == null) {
	        return "redirect:/user/login";
	    }
	    
	    Map<String, Object> qna = sqlSession.selectOne("qna.getQnaById", params.get("question_id"));
	    if (qna == null || !loggedInUser.getUser_id().equals(qna.get("user_id"))) {
	        redirectAttributes.addFlashAttribute("error", "수정 권한이 없습니다.");
	        return "redirect:/qna/qna";
	    }
	    
	    int result = sqlSession.update("qna.updateQna", params);
	    if (result > 0) {
	        redirectAttributes.addFlashAttribute("message", "글이 성공적으로 수정되었습니다.");
	        return "redirect:/qna/qnadetail?id=" + params.get("question_id");
	    } else {
	        redirectAttributes.addFlashAttribute("error", "글 수정에 실패했습니다.");
	        return "redirect:/qna/qna";
	    }
	}
	
	@PostMapping("/delete")
	public String deleteQna(@RequestParam("id") int questionId, HttpSession session, RedirectAttributes redirectAttributes) {
	    UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
	    if (loggedInUser == null) {
	        return "redirect:/user/login";
	    }
	    
	    Map<String, Object> qna = sqlSession.selectOne("qna.getQnaById", questionId);
	    
	    if (qna == null || (!loggedInUser.getUser_id().equals(qna.get("user_id")) && !"M".equals(loggedInUser.getAuth()))) {
	        redirectAttributes.addFlashAttribute("error", "삭제 권한이 없습니다.");
	        return "redirect:/qna/qna";
	    }
	    
	    int result = sqlSession.delete("qna.deleteQna", questionId);
	    if (result > 0) {
	        redirectAttributes.addFlashAttribute("message", "글이 성공적으로 삭제되었습니다.");
	    } else {
	        redirectAttributes.addFlashAttribute("error", "글 삭제에 실패했습니다.");
	    }
	    
	    return "redirect:/qna/qna";
	}
	
}//class end



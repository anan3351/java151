package com.example.demo.hall;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.user.UserDTO;

import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/hall")
public class HallCont {
	
	public HallCont() {
		System.out.println("----------HallCont 객체생성완료");
	}
	
	private UserDTO userDto;
	
    @Autowired
    private HallDAO hallDao;
    
    @Autowired
	SqlSession sqlSession;
    
    //@Autowired
    //private HallService hallService;
    
    @Autowired
    private HallRepository	hallRepository;
    
  
    //결과확인 공연장 목록
    //->http://localhost:9095/hall/list
    //
    /*@RequestMapping("/list")
    public ModelAndView list() {
        ModelAndView mav=new ModelAndView();
        mav.setViewName("hall/hallList");
        mav.addObject("list", hallDao.list());
        return mav;
    }//list() end*/
    
    
	
	/*
	 * @PostMapping("/hall/order")
	 * 
	 * @ResponseBody public String orderHall(@RequestBody HallOrderDTO request) {
	 * HallOrderService hallOrderService = new HallOrderService();
	 * hallOrderService.saveOrder(request); return "success"; }
	 */

   
    //http://localhost:9095/list/detail/25
    @GetMapping("/detail/{hall_id}")
    public ModelAndView detail(@PathVariable String hall_id, HttpSession session, Model model) {
    //public ModelAndView detail(@PathVariable("product_code") int product_code) { 위의 코드가 에러나는 경우 
    	
    	UserDTO loggedInUser  = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser  == null) {
            return new ModelAndView("redirect:/login");  // 로그인 페이지로 리다이렉트
        }
        model.addAttribute("loggedInUser", loggedInUser);
    	
    	
    	ModelAndView mav=new ModelAndView();
        mav.setViewName("hall/hallListDetail"); //파일위치
        
        List<Map<String, Object>> list = hallDao.hallDetail(hall_id);
        List<Map<String, Object>> list2 = hallDao.hallDetailMini(hall_id);
        
        mav.addObject("hall", list.isEmpty() ? null : list.get(0));
        mav.addObject("list", list);
        mav.addObject("list2", list2);
        mav.addObject("user_id", loggedInUser.getUser_id()); // 사용자 ID 추가
        
        return mav;
    }//detail() end
    
    
    
    
    //게시판 페이징 및 검색 메서드
    @GetMapping("/list")
    public String hallList(Model model,
                           @PageableDefault(size = 5) Pageable pageable,
                           @RequestParam(required = false, defaultValue = "") String field,
                           @RequestParam(required = false, defaultValue = "") String word) {

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
                halls = hallRepository.findByHallIdWithNonNullHDayAndWithoutDash(pageSize, offset);
                totalElements = hallRepository.countByHallIdWithoutDash();
            }
        } else {
            halls = hallRepository.findByHallIdWithNonNullHDayAndWithoutDash(pageSize, offset);
            totalElements = hallRepository.countByHallIdWithoutDash();
            //halls = hallRepository.findHallsWithMiniHallNotNull(pageSize, offset);
        }
        

        Page<HallEntity> ulist = new PageImpl<>(halls, pageable, totalElements);

        int pageNumber = ulist.getPageable().getPageNumber(); //현재페이지
        int totalPages = ulist.getTotalPages();  //총 페이지 수. 검색에따라 10개면 10개..
        int pageBlock = 5; //블럭의 수 1, 2, 3, 4, 5
        int startBlockPage = ((pageNumber) / pageBlock) * pageBlock + 1; //현재 페이지가 7이라면 1*5
        int endBlockPage = startBlockPage + pageBlock - 1; //6+5-1=10. 6,7,8,9,10해서 10.
        endBlockPage = totalPages < endBlockPage ? totalPages : endBlockPage;

        model.addAttribute("startBlockPage", startBlockPage);
        model.addAttribute("endBlockPage", endBlockPage);
        model.addAttribute("ulist", ulist);
        model.addAttribute("field", field);
        model.addAttribute("word", word);
        
        return "hall/hallList";
    }
    
    
   
   
}//end HallCont

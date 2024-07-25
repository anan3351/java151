package com.example.demo.show;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.actor.ActorDTO;


@Controller
public class ShowCont {

	@Autowired
    private ShowDAO showDao;
	
	@GetMapping("/")
	public String main() {
		return "main";
	}
	
	// 뮤지컬 목록
	@GetMapping("/musical")
	public ModelAndView musical() {
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("show/musical");
	    List<Map<String, Object>> musicalList = showDao.musicalList();
	    mav.addObject("musicals", musicalList);
	    mav.setViewName("show/musical");
	    return mav;
	}

	// 연극 목록
	@GetMapping("/play")
	public ModelAndView play() {
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("show/play");
	    List<Map<String, Object>> playList = showDao.playList();
	    mav.addObject("plays", playList);
	    mav.setViewName("show/play");
	    return mav;
	}
		
	// 상세페이지
	@GetMapping("/{show_id}")
    public ModelAndView detail(@PathVariable String show_id) {
        ModelAndView mav = new ModelAndView();
        Map<String, Object> show = showDao.showDetail(show_id);
            
        if (show == null) {
        	mav.setViewName("seller/showNotFound");
            return mav;
        }

        List<Map<String, Object>> priceList = showDao.sellerDetail2(show_id);
            
        mav.addObject("show", show);
        mav.addObject("priceList", priceList);

        String[] imgKeys = {"notice_img", "dis_img", "event_img", "detail_img", "casting_img"};
        Map<String, List<String>> imgMap = new HashMap<>();

        for (String key : imgKeys) {
        	String imgData = (String) show.get(key);
            if (imgData != null && !imgData.isEmpty()) {
            	List<String> imgList = new ArrayList<>();
                if (imgData.contains("\n")) {
                	String[] parts = imgData.split("\n");
                    imgList = new ArrayList<>(Arrays.asList(parts));
                } else {
                	imgList.add(imgData);
                }

                String displayKey = switch (key) {
                	case "notice_img" -> "공지사항";
                    case "dis_img" -> "할인정보";
                    case "event_img" -> "이벤트";
                    case "detail_img" -> "상세정보";
                    case "casting_img" -> "캐스팅 일정";
                    default -> key;
                };

                imgMap.put(displayKey, imgList);
            }
        }
        mav.addObject("imgMap", imgMap);
        mav.setViewName("show/detail");
        return mav;
    }

	// 공연 상세 - 전체가격 모달
	@GetMapping("/allPrice")
	public ModelAndView allPrice(String show_id) {
	    ModelAndView mav = new ModelAndView();
	    List<Map<String, Object>> priceList = showDao.allPrice(show_id);
	    mav.addObject("priceList", priceList);
	    mav.setViewName("show/allPrice");
	    return mav;
	}
	
	
	// 공연 검색
	// Controller Method
	@GetMapping("/search")
	public ModelAndView search(@RequestParam("title") String title,
	                           @RequestParam(defaultValue = "0") int page,
	                           @PageableDefault(size = 5) Pageable pageable) {
	    
	    int pageSize = pageable.getPageSize();
	    int currentPage = page;
	    int offset = currentPage * pageSize;

	    List<ShowDTO> shows = showDao.allShow(title, pageSize, offset);
	    int totalElements = showDao.countByAllShow(title);

	    Page<ShowDTO> ulist = new PageImpl<>(shows, pageable, totalElements);

	    int totalPages = ulist.getTotalPages();
	    int pageBlock = 5;
	    int startBlockPage = (currentPage / pageBlock) * pageBlock + 1;
	    int endBlockPage = Math.min(startBlockPage + pageBlock - 1, totalPages - 1);

	    ModelAndView mav = new ModelAndView("show/search");
	    mav.addObject("startBlockPage", startBlockPage);
	    mav.addObject("endBlockPage", endBlockPage);
	    mav.addObject("ulist", ulist);
	    mav.addObject("title", title);
	    mav.addObject("totalElements", totalElements);
	    mav.addObject("currentPage", currentPage);
	    mav.addObject("totalPages", totalPages);

	    return mav;
	}




}

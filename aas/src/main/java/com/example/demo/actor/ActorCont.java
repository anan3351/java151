package com.example.demo.actor;

import java.util.Collections;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/actor")
public class ActorCont {
    public ActorCont() {
        System.out.println("-----ActorCont객체생성");
    }

    @Autowired
    private ActorDAO actorDao;

    @RequestMapping("")
    public ModelAndView actorlist(HttpServletRequest req) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("actor/list");

        int totalRowCount = actorDao.totalRowCount(); // 총 글갯수

        // 페이징
        int numPerPage = 5; // 한 페이지당 레코드 갯수
        int pagePerBlock = 10; // 페이지 리스트

        String pageNum = req.getParameter("pageNum");
        if (pageNum == null) {
            pageNum = "1";
        }

        int currentPage = Integer.parseInt(pageNum);
        int startRow = (currentPage - 1) * numPerPage;
        int endRow = numPerPage; // LIMIT 절에서 필요한 값으로 수정

        // 페이지 수
        double totcnt = (double) totalRowCount / numPerPage;
        int totalPage = (int) Math.ceil(totcnt);

        double d_page = (double) currentPage / pagePerBlock;
        int Pages = (int) Math.ceil(d_page) - 1;
        int startPage = Pages * pagePerBlock + 1;
        int endPage = startPage + pagePerBlock - 1;
        if (endPage > totalPage) {
            endPage = totalPage;
        }

        List<ActorDTO> list = null;
        if (totalRowCount > 0) {
            list = actorDao.list2(startRow, endRow);
        } else {
            list = Collections.emptyList();
        }
        
      

        mav.addObject("pageNum", currentPage);
        mav.addObject("count", totalRowCount);
        mav.addObject("totalPage", totalPage);
        mav.addObject("startPage", startPage);
        mav.addObject("endPage", endPage);
        mav.addObject("list", list);

        return mav;
    }// list end

    @RequestMapping("/list")
    public ModelAndView alllist(HttpServletRequest req) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("actor/alllist");

        int totalRowCount = actorDao.totalRowCount(); // 총 글갯수

        // 페이징
        int numPerPage = 20; // 한 페이지당 레코드 갯수
        int pagePerBlock = 10; // 페이지 리스트

        String pageNum = req.getParameter("pageNum");
        if (pageNum == null) {
            pageNum = "1";
        }

        int currentPage = Integer.parseInt(pageNum);
        int startRow = (currentPage - 1) * numPerPage;
        int endRow = numPerPage; // LIMIT 절에서 필요한 값으로 수정

        // 페이지 수
        double totcnt = (double) totalRowCount / numPerPage;
        int totalPage = (int) Math.ceil(totcnt);

        double d_page = (double) currentPage / pagePerBlock;
        int Pages = (int) Math.ceil(d_page) - 1;
        int startPage = Pages * pagePerBlock + 1;
        int endPage = startPage + pagePerBlock - 1;
        if (endPage > totalPage) {
            endPage = totalPage;
        }

        List<ActorDTO> list = null;
        if (totalRowCount > 0) {
            list = actorDao.list2(startRow, endRow);
        } else {
            list = Collections.emptyList();
        }

        mav.addObject("pageNum", currentPage);
        mav.addObject("count", totalRowCount);
        mav.addObject("totalPage", totalPage);
        mav.addObject("startPage", startPage);
        mav.addObject("endPage", endPage);
        mav.addObject("list", list);

        return mav;
    }

    
    
    
}//class end
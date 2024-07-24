package com.example.demo.show.seller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.example.demo.actor.ActorDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.hall.HallDTO;
import com.example.demo.show.ShowDAO;
import com.example.demo.show.ShowDTO;
import com.example.demo.show.discount.DiscountDTO;
import com.example.demo.show.price.PriceDTO;
import com.example.demo.showcasting.ShowCastingDTO;
import com.example.demo.user.UserDTO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/seller")
public class SellerCont {
    
    @Autowired
    private ShowDAO showDao;

    // 공연 등록 페이지
    @GetMapping("/create")
    public String create(HttpSession session, Model model) {
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
        HttpServletRequest req, HttpSession session) {

        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        String show_id = showDao.showid_make();
        map.put("show_id", show_id);

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
    }


    // 공연 등록 - 공연장 검색
    @GetMapping("/hallSearch")
    public String hallSearch(HttpSession session, Model model) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("userInfo", loggedInUser);
            return "seller/hallSearch"; 
        } else {
            return "redirect:/user/login";
        }
    }
    
    // 공연 등록 - 공연장 목록 페이징
    @GetMapping("/hallList")
    public ModelAndView hallList(@PageableDefault(size = 5, page = 0) Pageable pageable,
                                 @RequestParam(required = false, defaultValue = "") String h_name) {

        // 페이지 관련 정보
        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int offset = currentPage * pageSize;

        // 검색 결과 및 총 데이터 개수 가져오기
        List<HallDTO> halls;
        int totalElements;

        halls = showDao.findByHName(h_name, pageSize, offset);
        totalElements = showDao.countByHname(h_name);

        Page<HallDTO> ulist = new PageImpl<>(halls, pageable, totalElements);
        int pageNumber = pageable.getPageNumber();
        int totalPages = ulist.getTotalPages();
        int pageBlock = 5;
        int startBlockPage = (pageNumber / pageBlock) * pageBlock + 1;
        int endBlockPage = Math.min(startBlockPage + pageBlock - 1, totalPages);

        // 모델과 뷰 이름을 설정한 ModelAndView 객체 생성
        ModelAndView mav = new ModelAndView("seller/hallList");
        mav.addObject("startBlockPage", startBlockPage);
        mav.addObject("endBlockPage", endBlockPage);
        mav.addObject("ulist", ulist);
        mav.addObject("h_name", h_name);
        mav.addObject("totalElements", totalElements);

        return mav;
    }
    
    // 공연 수정 페이지
    @GetMapping("/detail/{show_id}/showUpdate")
    public ModelAndView showUpdate(@PathVariable String show_id, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        ShowDTO showDto = showDao.showSelect(show_id);

        if (loggedInUser != null) {
        	String user_id = loggedInUser.getUser_id();
            mav.addObject("userInfo", loggedInUser);
            mav.addObject("data", showDto);
            mav.addObject("now", LocalDate.now().toString());
            
            Map<String, Object> show = showDao.sellerDetail(show_id, user_id);
            
            String[] imgKeys = {"notice_img", "dis_img", "event_img", "detail_img", "casting_img"};
            Map<String, List<String>> imgMap = new HashMap<>();
            int i = 0;
            
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

                    imgMap.put(imgKeys[i], imgList);
                    i++;
                }
            }
            mav.addObject("imgMap", imgMap); 
            mav.setViewName("seller/showUpdate");
        } else {
            mav.setViewName("user/login");
        }

        return mav;
    }
    
    // 공연 수정 - 업데이트
    /*
    	1. x 버튼을 클릭하면 이미지 파일 삭제 -> 저장 경로에서도 삭제
    	2. 해당 공연 데이터 불러와서 이미지가 비어있다면 리네임된 파일을 그대로 저장, 아니라면 \n을 붙여서 저장
    */
    @PostMapping("/detail/{show_id}/showUpdate")
    public String showUpdate2(@PathVariable String show_id, HttpSession session, ShowDTO showDto) {
        showDao.showUpdate(showDto);
        return "redirect:/seller/detail/" + show_id;
    }
    
    /*// 공연 - 파일 삭제
    @PostMapping("/detail/{show_id}/fileDelete")
    public String fileDelete(@PathVariable String show_id, 
                             @RequestParam("file") String file) {
        showDao.fileDelete(show_id, file);
        return "redirect:/seller/detail/" + show_id + "/showUpdate";
    }*/
    
    /*
    @PostMapping("/detail/{show_id}/fileDelete")
    public String disDelete(@PathVariable int dis_id, HttpSession session) {
    	String show_id = showDao.findByDisShowID(dis_id);
    	showDao.disDelete(dis_id);
        return "redirect:/seller/detail/" + show_id + "/disList";
    }*/
    
    
    // 공연 삭제
	/*
	 * @PostMapping("/detail/{dis_id}/disDelete") public String
	 * disDelete(@PathVariable int dis_id, HttpSession session) { String show_id =
	 * showDao.findByDisShowID(dis_id); showDao.disDelete(dis_id); return
	 * "redirect:/seller/detail/" + show_id + "/disList"; }
	 */
    
    
    
    // ---------------------
    
    
    // 공연 목록 페이지 - 진행 중, 진행 예정
    @GetMapping("/list")
    public ModelAndView list(HttpSession session,
                             @RequestParam(defaultValue = "0") int page,
                             @PageableDefault(size = 10, page = 0) Pageable pageable) {

        ModelAndView mav = new ModelAndView();

        // 페이지 관련 정보
        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int offset = currentPage * pageSize;

        // 세션에서 로그인 정보 가져오기
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            String user_id = loggedInUser.getUser_id();

            // 현재 날짜 설정
            Date now = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
            String currentDate = dateFormat.format(now);

            // 공연 목록 조회
            List<HashMap<String, Object>> showList = showDao.findByShow(user_id, offset, pageSize, currentDate);
            int today = Integer.parseInt(dateFormat.format(now));

            // 공연 진행 상태 계산
            for (HashMap<String, Object> show : showList) {
                try {
                    Date startDate = (Date) show.get("start_day");
                    Date endDate = (Date) show.get("end_day");
                    int start_day = Integer.parseInt(dateFormat.format(startDate));
                    int end_day = Integer.parseInt(dateFormat.format(endDate));

                    if (start_day <= today) {
                        if (today <= end_day) {
                            show.put("state", "공연 중");
                        }
                    } else if (today < start_day) {
                        show.put("state", "공연 예정");
                    }
                } catch (Exception e) {
                    System.out.println("error : " + e);
                }
            }

            // 페이지 관련 정보 설정
            int totalElements = showDao.countByShow(user_id, currentDate);
            int totalPages = (int) Math.ceil((double) totalElements / pageSize);
            int startBlockPage = Math.max(0, currentPage - 2);
            int endBlockPage = Math.min(totalPages - 1, currentPage + 2);

            // 모델에 데이터 추가
            mav.addObject("userInfo", loggedInUser);
            mav.addObject("ulist", showList);
            mav.addObject("currentPage", currentPage);
            mav.addObject("totalPages", totalPages);
            mav.addObject("startBlockPage", startBlockPage);
            mav.addObject("endBlockPage", endBlockPage);
            mav.addObject("totalElements", totalElements);

            mav.setViewName("seller/list");
        } else {
            mav.setViewName("user/login");
        }

        return mav;
    }
    
    // 공연 목록 페이지 - 종료
    @GetMapping("/endList")
    public ModelAndView endList(HttpSession session,
                                @RequestParam(defaultValue = "0") int page,
                                @PageableDefault(size = 10, page = 0) Pageable pageable) {

        // 페이지 관련 정보
        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int offset = currentPage * pageSize;

        ModelAndView mav = new ModelAndView();
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            String user_id = loggedInUser.getUser_id();

            // 현재 날짜 설정
            Date now = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
            String currentDate = dateFormat.format(now);
            String state = "공연 종료";

            // 공연 목록 조회
            List<HashMap<String, Object>> showList = showDao.findByEndShow(user_id, offset, pageSize, currentDate);

            // 페이지 관련 정보 설정
            int totalElements = showDao.countByEndShow(user_id, currentDate);
            int totalPages = (int) Math.ceil((double) totalElements / pageSize);
            int startBlockPage = Math.max(0, currentPage - 2);
            int endBlockPage = Math.min(totalPages - 1, currentPage + 2);

            // 모델에 데이터 추가
            mav.addObject("state", state);
            mav.addObject("userInfo", loggedInUser);
            mav.addObject("ulist", showList);
            mav.addObject("currentPage", currentPage);
            mav.addObject("totalPages", totalPages);
            mav.addObject("startBlockPage", startBlockPage);
            mav.addObject("endBlockPage", endBlockPage);
            mav.addObject("totalElements", totalElements);

            mav.setViewName("seller/endList");
        } else {
            mav.setViewName("user/login");
        }

        return mav;
    }
    // ---------------------
    
    
    @GetMapping("/detail/{show_id}")
    public ModelAndView detail(@PathVariable String show_id, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            String user_id = loggedInUser.getUser_id();
            Map<String, Object> show = showDao.sellerDetail(show_id, user_id);
            
            if (show == null) {
                mav.setViewName("seller/showNotFound");
                return mav;
            }

            List<Map<String, Object>> priceList = showDao.sellerDetail2(show_id);
            
            mav.addObject("show", show);
            mav.addObject("priceList", priceList);
            mav.addObject("userInfo", loggedInUser);

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
            mav.setViewName("seller/detail");
        } else {
            mav.setViewName("user/login");
        }

        return mav;
    }

    
    // 공연 상세 - 전체가격 모달
    @GetMapping("/detail/allPrice")
    public ModelAndView allPrice(String show_id, HttpSession session) {
    	ModelAndView mav = new ModelAndView();
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        
        if (loggedInUser != null) {
        	String user_id = loggedInUser.getUser_id();
        	mav.addObject("userInfo", loggedInUser);
            List<Map<String, Object>> priceList = showDao.allPrice(show_id);
            mav.addObject("priceList", priceList);
            mav.setViewName("seller/allPrice");
        } else {
        	mav.setViewName("seller/detail");
        }
        
        return mav;
    }


    // 공연상세 - 할인 목록
    @GetMapping("/detail/{show_id}/disList")
    public ModelAndView disList(HttpSession session, @PathVariable String show_id,
					            @RequestParam(defaultValue = "0") int page,
					            @PageableDefault(size = 10, page = 0) Pageable pageable) {
    	
    	ModelAndView mav = new ModelAndView();
        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int offset = currentPage * pageSize;

        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        
        if (loggedInUser != null) {
            String user_id = loggedInUser.getUser_id();
            
            // 할인 목록 조회
            List<HashMap<String, Object>> disList = showDao.findByDiscount(show_id, user_id, offset, pageSize);
            
            // 날짜 형식 변환
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH시");
            for (HashMap<String, Object> dis : disList) {
                Date disStart = (Date) dis.get("dis_start");
                Date disEnd = (Date) dis.get("dis_end");
                dis.put("start", dateFormat.format(disStart));
                dis.put("end", dateFormat.format(disEnd));
            }

            // 페이지 관련 정보 설정
            int totalElements = showDao.countByDiscount(show_id, user_id);
            int totalPages = (int) Math.ceil((double) totalElements / pageSize);
            int startBlockPage = Math.max(0, currentPage - 2);
            int endBlockPage = Math.min(totalPages - 1, currentPage + 2);

            // 모델에 데이터 추가
            mav.addObject("userInfo", loggedInUser);
            mav.addObject("ulist", disList);
            mav.addObject("currentPage", currentPage);
            mav.addObject("totalPages", totalPages);
            mav.addObject("startBlockPage", startBlockPage);
            mav.addObject("endBlockPage", endBlockPage);
            mav.addObject("totalElements", totalElements);

            mav.setViewName("seller/disList");
        } else {
            mav.setViewName("user/login");
        }

        return mav;
    }
    
    // 공연상세 - 종료된 할인 목록
    @GetMapping("/detail/{show_id}/endDisList")
    public ModelAndView endDisList(HttpSession session, @PathVariable String show_id,
					            @RequestParam(defaultValue = "0") int page,
					            @PageableDefault(size = 10, page = 0) Pageable pageable) {
    	
    	ModelAndView mav = new ModelAndView();
        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int offset = currentPage * pageSize;

        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        
        if (loggedInUser != null) {
            String user_id = loggedInUser.getUser_id();
            
            // 할인 목록 조회
            List<HashMap<String, Object>> disList = showDao.findByEndDiscount(show_id, user_id, offset, pageSize);
            
            // 날짜 형식 변환
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH시");
            for (HashMap<String, Object> dis : disList) {
                Date disStart = (Date) dis.get("dis_start");
                Date disEnd = (Date) dis.get("dis_end");
                dis.put("start", dateFormat.format(disStart));
                dis.put("end", dateFormat.format(disEnd));
            }

            // 페이지 관련 정보 설정
            int totalElements = showDao.countByEndDiscount(show_id, user_id);
            int totalPages = (int) Math.ceil((double) totalElements / pageSize);
            int startBlockPage = Math.max(0, currentPage - 2);
            int endBlockPage = Math.min(totalPages - 1, currentPage + 2);

            // 모델에 데이터 추가
            mav.addObject("userInfo", loggedInUser);
            mav.addObject("ulist", disList);
            mav.addObject("currentPage", currentPage);
            mav.addObject("totalPages", totalPages);
            mav.addObject("startBlockPage", startBlockPage);
            mav.addObject("endBlockPage", endBlockPage);
            mav.addObject("totalElements", totalElements);

            mav.setViewName("seller/endDisList");
        } else {
            mav.setViewName("user/login");
        }

        return mav;
    }
    // ---------------------
    
    
    // 할인 등록 페이지
    @GetMapping("/detail/{show_id}/discount")
    public ModelAndView discount(@PathVariable String show_id, HttpSession session) {
    	
    	ModelAndView mav = new ModelAndView();
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            mav.addObject("userInfo", loggedInUser);
            List<String> seatList = showDao.seatList(show_id);
            mav.addObject("seatList", seatList);
            mav.setViewName("seller/discount");
        } else {
            mav.setViewName("user/login");
        }
        
        return mav;
    }
    
    // 할인 등록
    @PostMapping("/detail/{show_id}/disInsert")
    public String disInsert(DiscountDTO disDto, @PathVariable String show_id, HttpSession session) {
    	disDto.setShow_id(show_id);
        showDao.disInsert(disDto);
        return "redirect:/seller/detail/" + show_id + "/disList";
    }
    
    // 할인 수정(페이지)
    @GetMapping("/detail/{dis_id}/disUpdate")
    public ModelAndView disUpdate(@PathVariable int dis_id, HttpSession session) {

        ModelAndView mav = new ModelAndView();
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        DiscountDTO disDto = showDao.discountSelect(dis_id);

        if (loggedInUser != null) {
            mav.addObject("userInfo", loggedInUser);
            mav.addObject("data", disDto);

            String disRange = disDto.getDis_range();
            List<String> disRanges = Arrays.asList(disRange.split(","));
            List<String> disRangeList = new ArrayList<>();
            for (String range : disRanges) {
                disRangeList.add(range.trim());
            }

            List<String> seatList = showDao.seatList(disDto.getShow_id());
            mav.addObject("disRangeList", disRangeList);
            mav.addObject("seatList", seatList);

            mav.setViewName("seller/disUpdate");
        } else {
            mav.setViewName("user/login");
        }

        return mav;
    }


    // 할인 수정(업데이트)
    @PostMapping("/detail/{dis_id}/disUpdate")
    public String disUpdate(DiscountDTO disDto, @PathVariable int dis_id, HttpSession session) {
    	String show_id = showDao.findByDisShowID(dis_id);
        disDto.setShow_id(show_id);
        showDao.disUpdate(disDto);
        return "redirect:/seller/detail/" + show_id + "/disList";
    }
    
    // 할인 삭제
    @PostMapping("/detail/{dis_id}/disDelete")
    public String disDelete(@PathVariable int dis_id, HttpSession session) {
    	String show_id = showDao.findByDisShowID(dis_id);
    	showDao.disDelete(dis_id);
        return "redirect:/seller/detail/" + show_id + "/disList";
    }
    // ---------------------
    
    
    // 공연 상세 - 좌석 금액 리스트
    @GetMapping("/detail/{show_id}/priList")
    public ModelAndView priList(HttpSession session, @PathVariable String show_id,
					            @RequestParam(defaultValue = "0") int page,
					            @PageableDefault(size = 10, page = 0) Pageable pageable) {
    	
    	ModelAndView mav = new ModelAndView();
        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int offset = currentPage * pageSize;

        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        
        if (loggedInUser != null) {
            String user_id = loggedInUser.getUser_id();
            
            // 좌석금액 목록 조회
            List<HashMap<String, Object>> priList = showDao.findByPrice(show_id, user_id, offset, pageSize);

            int totalElements = showDao.countByPrice(show_id, user_id);
            int totalPages = (int) Math.ceil((double) totalElements / pageSize);
            int startBlockPage = Math.max(0, currentPage - 2);
            int endBlockPage = Math.min(totalPages - 1, currentPage + 2);

            mav.addObject("userInfo", loggedInUser);
            mav.addObject("ulist", priList);
            mav.addObject("currentPage", currentPage);
            mav.addObject("totalPages", totalPages);
            mav.addObject("startBlockPage", startBlockPage);
            mav.addObject("endBlockPage", endBlockPage);
            mav.addObject("totalElements", totalElements);

            mav.setViewName("seller/priList");
        } else {
            mav.setViewName("user/login");
        }

        return mav;
    }
    
    // 좌석금액 등록
    @GetMapping("/detail/{show_id}/price")
    public ModelAndView price(@PathVariable String show_id, HttpSession session) {
    	
    	ModelAndView mav = new ModelAndView();
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        
        if (loggedInUser != null) {
            mav.addObject("userInfo", loggedInUser);
            mav.setViewName("seller/price");
        } else {
            mav.setViewName("user/login");
        }
        
        return mav;
    }
    
    // 좌석금액 등록
    @PostMapping("/detail/{show_id}/priInsert")
    public String priInsert(PriceDTO priDto, @PathVariable String show_id, HttpSession session) {
    	if (priDto.getAdd_p() == null) {
            priDto.setAdd_p(null);
        }
    	priDto.setShow_id(show_id);
        showDao.priInsert(priDto);
        return "redirect:/seller/detail/" + show_id + "/priList";
    }
    
    // 좌석금액 수정(페이지)
    @GetMapping("/detail/{price_id}/priUpdate")
    public ModelAndView priceUpdate(@PathVariable int price_id, HttpSession session) {
    	
    	ModelAndView mav = new ModelAndView();
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        PriceDTO priDto = showDao.priceSelect(price_id);
        
        if (loggedInUser != null) {
            mav.addObject("userInfo", loggedInUser);
            mav.addObject("data", priDto);
            mav.setViewName("seller/priUpdate");
        } else {
            mav.setViewName("user/login");
        }
        
        return mav;
    }
    
    // 좌석금액 수정(업데이트)
    @PostMapping("/detail/{price_id}/priUpdate")
    public String priUpdate(PriceDTO priDto, @PathVariable int price_id, HttpSession session) {
    	if (priDto.getAdd_p() == null) {
            priDto.setAdd_p(null);
        }
    	String show_id = showDao.findByPriShowID(price_id);
        priDto.setShow_id(show_id);
        showDao.priUpdate(priDto);
        return "redirect:/seller/detail/" + show_id + "/priList";
    }
    
    // 좌석금액 삭제
    @PostMapping("/detail/{price_id}/priDelete")
    public String priDelete(@PathVariable int price_id, HttpSession session) {
    	String show_id = showDao.findByPriShowID(price_id);
    	showDao.priDelete(price_id);
        return "redirect:/seller/detail/" + show_id + "/priList";
    }
    // ---------------------

    
    // 캐스트 관리 페이지
    @GetMapping("/detail/{show_id}/castList")
    public ModelAndView findByCast(HttpSession session, @PathVariable String show_id,
                                    @RequestParam(defaultValue = "0") int page,
                                    @PageableDefault(size = 10, page = 0) Pageable pageable) {

        ModelAndView mav = new ModelAndView();
        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int offset = currentPage * pageSize;

        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            List<HashMap<String, Object>> castList = showDao.findByCast(show_id, offset, pageSize);

            // 날짜 및 시간 형식화 설정
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd(E)");
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");

            // 회차에 따른 캐스팅 일정
            Map<String, Map<String, List<String>>> castingList = new LinkedHashMap<>();
            
            for (HashMap<String, Object> cast : castList) {                
                Date timestamp = (Date) cast.get("ticket_date");
                String dateStr = dateFormat.format(timestamp); // 날짜 및 요일
                String timeStr = timeFormat.format(timestamp); // 시간
                String dateTimeStr = dateStr + " " + timeStr; // 날짜 + 시간
                String casting = (String) cast.get("casting");
                String a_name = (String) cast.get("a_name");

                castingList.computeIfAbsent(dateTimeStr, k -> new LinkedHashMap<>())
                           .computeIfAbsent(casting, k -> new ArrayList<>())
                           .add(a_name);
            }

            int totalElements = showDao.countByCast(show_id);
            int totalPages = (int) Math.ceil((double) totalElements / pageSize);
            int startBlockPage = Math.max(0, currentPage - 2);
            int endBlockPage = Math.min(totalPages - 1, currentPage + 2);

            mav.addObject("userInfo", loggedInUser);
            mav.addObject("dateCastingMap", castingList); // 날짜와 배역별 배우
            mav.addObject("currentPage", currentPage);
            mav.addObject("totalPages", totalPages);
            mav.addObject("startBlockPage", startBlockPage);
            mav.addObject("endBlockPage", endBlockPage);
            mav.addObject("totalElements", totalElements);

            mav.setViewName("seller/castList");
        } else {
            mav.setViewName("user/login");
        }

        return mav;
    }



    // 배역 등록
    @GetMapping("/detail/{show_id}/role")
    public ModelAndView role(@PathVariable String show_id, HttpSession session) {

        ModelAndView mav = new ModelAndView();
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            String user_id = loggedInUser.getUser_id();
            mav.addObject("userInfo", loggedInUser);
            Map<String, Object> roles = showDao.sellerDetail(show_id, user_id);
            String role = (String) roles.get("c_role");

            if (role != null && role.contains(",")) {
                String[] parts = role.split(",");
                List<String> roleList = new ArrayList<>();
                for (String part : parts) {
                    roleList.add(part.trim());
                }
                mav.addObject("roleList", roleList);
            } else {
                List<String> roleList = new ArrayList<>();
                if (role != null) {
                    roleList.add(role);
                }
                mav.addObject("roleList", roleList);
            }
            mav.setViewName("seller/role");
        } else {
            mav.setViewName("user/login");
        }
        return mav;
    }

    // 배역 등록 - 배우 검색
    @GetMapping("/actorSearch")
    public String actorSearch(HttpSession session, Model model) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("userInfo", loggedInUser);
            return "seller/actorSearch";
        } else {
            return "redirect:/user/login";
        }
    }

    // 배역 등록 - 배우 조회
    @GetMapping("/actorList")
    public ModelAndView actorList(@PageableDefault(size = 5, page = 0) Pageable pageable,
                                 @RequestParam(required = false, defaultValue = "") String a_name) {

        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int offset = currentPage * pageSize;

        List<ActorDTO> actors;
        int totalElements;

        actors = showDao.findByActor(a_name, pageSize, offset);
        totalElements = showDao.countByActor(a_name);

        Page<ActorDTO> ulist = new PageImpl<>(actors, pageable, totalElements);
        int pageNumber = pageable.getPageNumber();
        int totalPages = ulist.getTotalPages();
        int pageBlock = 5;
        int startBlockPage = (pageNumber / pageBlock) * pageBlock + 1;
        int endBlockPage = Math.min(startBlockPage + pageBlock - 1, totalPages);

        // 모델과 뷰 이름을 설정한 ModelAndView 객체 생성
        ModelAndView mav = new ModelAndView("seller/actorList");
        mav.addObject("startBlockPage", startBlockPage);
        mav.addObject("endBlockPage", endBlockPage);
        mav.addObject("ulist", ulist);
        mav.addObject("a_name", a_name);
        mav.addObject("totalElements", totalElements);

        return mav;
    }
    
    // 배역 등록
    @PostMapping("/detail/{show_id}/roleInsert")
    public String roleInsert(ShowCastingDTO scDto, @PathVariable String show_id, HttpSession session) {
    	scDto.setShow_id(show_id);
        showDao.roleInsert(scDto);
        return "redirect:/seller/detail/" + show_id + "/roleList";
    }

    // 배역 리스트
    @GetMapping("/detail/{show_id}/roleList")
    public ModelAndView roleList(@PathVariable String show_id, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            List<Map<String, Object>> rolesList = showDao.roleList(show_id);
            Map<String, List<Map<String, Object>>> roles = new HashMap<>(); // 역할과 배우 리스트를 저장

            for (Map<String, Object> entry : rolesList) {
                String casting = (String) entry.get("casting");
                String a_name = (String) entry.get("a_name");
                int actor_id = (int) entry.get("actor_id");
                int casting_id = (int) entry.get("casting_id"); // casting_id 추가

                if (!roles.containsKey(casting)) {
                    roles.put(casting, new ArrayList<>());
                }

                Map<String, Object> actorInfo = new HashMap<>();
                actorInfo.put("a_name", a_name);
                actorInfo.put("actor_id", actor_id);
                actorInfo.put("casting_id", casting_id);

                roles.get(casting).add(actorInfo);
            }

            mav.addObject("userInfo", loggedInUser);
            mav.addObject("roles", roles);
            mav.setViewName("seller/roleList");
        } else {
            mav.setViewName("user/login");
        }

        return mav;
    }

    // 배역 - 배우 수정 페이지
    @GetMapping("/detail/{casting_id}/roleUpdate")
    public ModelAndView roleUpdate(@PathVariable int casting_id, HttpSession session) {
        
        ModelAndView mav = new ModelAndView();
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        
        if (loggedInUser != null) {
        	ShowCastingDTO scDto = showDao.roleSelect(casting_id);
            String show_id = scDto.getShow_id();
            String user_id = loggedInUser.getUser_id();
            
            Map<String, Object> roles2 = showDao.sellerDetail(show_id, user_id);
            String role = (String) roles2.get("c_role");

            List<String> roleList = new ArrayList<>();
            if (role != null) {
                String[] parts = role.split(",");
                for (String part : parts) {
                    roleList.add(part.trim());
                }
            }
            mav.addObject("roleList", roleList);
            mav.addObject("scDto", scDto);
            mav.addObject("userInfo", loggedInUser);
            mav.setViewName("seller/roleUpdate");
        } else {
            mav.setViewName("user/login");
        }
        return mav;
    }

    // 배역 - 배우 수정 업데이트
    @PostMapping("/detail/{casting_id}/roleUpdate")
    public String roleUpdate2(
            @PathVariable("casting_id") int castingId,
            @RequestParam("actorId") int actorId,
            @RequestParam("casting") String casting,
            HttpSession session) {
        
        ShowCastingDTO scDto = showDao.roleSelect(castingId);
        String showId = scDto.getShow_id();
        
        showDao.roleUpdate(actorId, casting, castingId);
        return "redirect:/seller/detail/" + showId + "/roleList";
    }


    // 배역 - 배우 삭제
    @PostMapping("/detail/{show_id}/roleDelete")
    public String roleDelete(@RequestParam int actor_id, @PathVariable String show_id, HttpSession session) {
        showDao.actorDelete(actor_id);
        return "redirect:/seller/detail/" + show_id + "/roleList";
    }






}
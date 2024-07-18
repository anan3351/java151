package com.example.demo.myschedule;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.orderdetail.OrderDetailDAO;
import com.example.demo.orderdetail.OrderDetailDTO;
import com.example.demo.user.UserDTO;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/myschedule")
public class MyScheduleCont {

    @Autowired
    OrderDetailDAO orderDetailDao;

    @Autowired 
    MyScheduleDAO myScheduleDao;

    // 업로드할 디렉토리 경로 설정
    private final String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads";

    @PostConstruct
    public void init() {
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            boolean created = dir.mkdirs();
            if(!created) {
                throw new RuntimeException("Failed to create upload directory: " + uploadDir);
            }
        }
        System.out.println("Upload directory: " + dir.getAbsolutePath());
    }

    @GetMapping("/list")
    public String getAllSchedules(HttpSession session, Model model) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            System.out.println("User is not logged in.");
            return "redirect:/user/login";
        }
        String user_id = loggedInUser.getUser_id();
        List<MyScheduleDTO> schedules = myScheduleDao.getAllSchedules(user_id);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        List<String> formattedDates = schedules.stream()
            .map(schedule -> {
                if (schedule.getShowdate() != null) {
                    return schedule.getShowdate().format(formatter);
                } else {
                    return "";
                }
            })
            .collect(Collectors.toList());

        model.addAttribute("schedules", schedules);
        model.addAttribute("formattedDates", formattedDates);
        return "myschedule/list";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model, HttpSession session) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/user/login";
        }
        String user_id = loggedInUser.getUser_id();
        List<OrderDetailDTO> orderDetails = orderDetailDao.getOrderDetailsByUserId(user_id);
        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("schedule", new MyScheduleDTO());
        return "myschedule/form";
    }

    @PostMapping("/save")
    public String saveSchedule(@ModelAttribute MyScheduleDTO schedule, @RequestParam("posterFile") MultipartFile posterFile, @RequestParam(required = false) Integer order_id, HttpSession session) throws IOException {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/user/login";
        }
        String userId = loggedInUser.getUser_id();
        schedule.setUser_id(userId);

        if (order_id != null) {
            OrderDetailDTO orderDetail = orderDetailDao.getOrderDetailById(order_id);
            schedule.setOrder_id(order_id);
            schedule.setSeat(orderDetail.getSeat_id() + "");
            schedule.setFair(orderDetail.getTotal_amount() + "");
            schedule.setTitle(orderDetail.getOrder_info());
        } else {
            schedule.setOrder_id(null);
        }

        if (!posterFile.isEmpty()) {
            String fileName = System.currentTimeMillis() + "_" + posterFile.getOriginalFilename();
            Path path = Paths.get(uploadDir, fileName);
            Files.copy(posterFile.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
            schedule.setPoster(fileName);
        }

        myScheduleDao.saveSchedule(schedule);
        return "redirect:/myschedule/list";
    }

    @GetMapping("/edit")
    public String showEditForm(@RequestParam("id") int mysch_id, Model model) {
        MyScheduleDTO schedule = myScheduleDao.getScheduleById(mysch_id);
        model.addAttribute("schedule", schedule);
        return "myschedule/form";
    }

    @PostMapping("/update")
    public String updateSchedule(@ModelAttribute("schedule") MyScheduleDTO schedule, @RequestParam("posterFile") MultipartFile posterFile) throws IOException {
        if (!posterFile.isEmpty()) {
            String fileName = System.currentTimeMillis() + "_" + posterFile.getOriginalFilename();
            Path path = Paths.get(uploadDir, fileName);
            Files.copy(posterFile.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
            schedule.setPoster(fileName);
        }
        myScheduleDao.updateSchedule(schedule);
        return "redirect:/myschedule/list";
    }

    @GetMapping("/delete")
    public String deleteSchedule(@RequestParam("id") int mysch_id) {
        myScheduleDao.deleteSchedule(mysch_id);
        return "redirect:/myschedule/list";
    }
}
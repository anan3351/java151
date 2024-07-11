package com.example.demo.mail;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.mail.MailService;

@Controller
@RequestMapping("/mail")
public class MailCont {


    @Autowired
    private MailService mailService;

    @GetMapping("/mailform")
    public String mailform() {
        return "mail/mailform";  // mailForm.jsp를 가리킴
    }

    @PostMapping("/sendMail")
    public String sendMail(@RequestParam String to, 
                           @RequestParam String subject, 
                           @RequestParam String body,
                           Model model) {
        try {
            mailService.sendSimpleMail(to, subject, body);
            model.addAttribute("message", "메일 전송 완료");
        } catch (Exception e) {
            model.addAttribute("message", "메일 전송 실패: " + e.getMessage());
            e.printStackTrace(); // 콘솔에 스택 트레이스 출력
        }
        return "mail/mailform";
    }
}

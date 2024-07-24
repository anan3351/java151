package com.example.demo.favorites;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.actor.ActorDTO;
import com.example.demo.user.UserDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class FavoritesCont {

    @Autowired
    private FavoritesDAO favoritesDAO;

    @PostMapping("/favorite/toggle")
    @ResponseBody
    public String toggleFavorite(@RequestParam("actor_id") int actorId, HttpSession session) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "not_logged_in";
        }

        String user_id = loggedInUser.getUser_id();
        FavoritesDTO favoritesDTO = new FavoritesDTO();
        favoritesDTO.setUser_id(user_id);
        favoritesDTO.setActor_id(actorId);

        FavoritesDTO existingFavorite = favoritesDAO.findFavorite(favoritesDTO);
        if (existingFavorite == null) {
            int favoriteCount = favoritesDAO.countFavoritesByUserId(user_id);
            if (favoriteCount >= 4) {
                return "limit_reached";
            }
            favoritesDAO.insertFavorite(favoritesDTO);
            return "added";
        } else {
            favoritesDAO.deleteFavorite(existingFavorite.getFavorites_id());
            return "removed";
        }
    }

    @GetMapping("/favorite/check")
    @ResponseBody
    public String checkFavorite(@RequestParam("actor_id") int actorId, HttpSession session) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "not_logged_in";
        }

        String user_id = loggedInUser.getUser_id();
        FavoritesDTO favoritesDTO = new FavoritesDTO();
        favoritesDTO.setUser_id(user_id);
        favoritesDTO.setActor_id(actorId);

        FavoritesDTO existingFavorite = favoritesDAO.findFavorite(favoritesDTO);
        return (existingFavorite == null) ? "not_added" : "added";
    }

    @GetMapping("/favorite/schedule")
    public String getFavoriteSchedule(HttpSession session, Model model) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/user/login"; // 로그인 페이지로 리디렉션
        }

        String user_id = loggedInUser.getUser_id();
        List<Map<String, Object>> favoriteSchedule = favoritesDAO.getFavoriteSchedule(user_id);
        List<Map<String, Object>> favoriteActors = favoritesDAO.getFavoriteActors(user_id);

        // 날짜별로 데이터를 그룹화하여 새로운 구조로 변환
        Map<String, Map<String, String>> scheduleMap = new LinkedHashMap<>();
        Set<String> actorNames = new LinkedHashSet<>();
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MM-dd");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
        
        for (Map<String, Object> entry : favoriteSchedule) {
            String actorName = (String) entry.get("actor_name");
            String role = (String) entry.get("role");
            String showTitle = (String) entry.get("show_title");
            Timestamp showTimeStamp = (Timestamp) entry.get("show_time");
            LocalDateTime showTime = showTimeStamp.toLocalDateTime();

            String date = showTime.format(dateFormatter); // "MM-dd" 형식으로 변환

            scheduleMap.putIfAbsent(date, new LinkedHashMap<>());
            scheduleMap.get(date).put(actorName, showTime.format(timeFormatter) + " " + showTitle); // "HH:mm 공연명" 형식으로 저장
            actorNames.add(actorName);
        }

        model.addAttribute("scheduleMap", scheduleMap);
        model.addAttribute("actorNames", actorNames);
        model.addAttribute("actorList", favoriteActors); // 배우 목록 추가
        return "favorites/list"; // view 이름 반환
    }


    @GetMapping("/favorite/top")
    public String getTopFavoriteActors(Model model) {
        List<ActorDTO> topFavoriteActors = favoritesDAO.getTopFavoriteActors();
        model.addAttribute("topFavoriteActors", topFavoriteActors);
        return "actor/list"; // view 이름 반환
    }

}

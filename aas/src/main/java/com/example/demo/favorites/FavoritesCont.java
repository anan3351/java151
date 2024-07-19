package com.example.demo.favorites;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
}

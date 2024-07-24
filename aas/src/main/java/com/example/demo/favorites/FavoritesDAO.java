package com.example.demo.favorites;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.actor.ActorDTO;

@Repository
public class FavoritesDAO {

    @Autowired
    private SqlSession sqlSession;

    public void insertFavorite(FavoritesDTO favoritesDTO) {
        sqlSession.insert("favorites.insertFavorite", favoritesDTO);
    }

    public FavoritesDTO findFavorite(FavoritesDTO favoritesDTO) {
        return sqlSession.selectOne("favorites.findFavorite", favoritesDTO);
    }

    public void deleteFavorite(int favorites_id) {
        sqlSession.delete("favorites.deleteFavorite", favorites_id);
    }
    
    public List<Map<String, Object>> getFavoriteSchedule(String user_id) {
        return sqlSession.selectList("favorites.getFavoriteSchedule", user_id);
    }

    public int countFavoritesByUserId(String user_id) {
        return sqlSession.selectOne("favorites.countFavoritesByUserId", user_id);
    }

    public List<Map<String, Object>> getFavoriteActors(String user_id) {
        return sqlSession.selectList("favorites.getFavoriteActors", user_id);
    }
    
    public List<ActorDTO> getTopFavoriteActors() {
        return sqlSession.selectList("favorites.getTopFavoriteActors");
    }
    
    public boolean isShowFavorite(String user_id, String show_id) {
        int count = sqlSession.selectOne("favorites.isShowFavorite", new FavoritesDTO(user_id, show_id));
        return count > 0;
    }

    public void addShowFavorite(FavoritesDTO favoritesDTO) {
        sqlSession.insert("favorites.addShowFavorite", favoritesDTO);
    }
    
    public List<Map<String, Object>> getFavoriteShowList(String user_id) {
        return sqlSession.selectList("favorites.getFavoriteShowList", user_id);
    }

    public void removeShowFavorite(FavoritesDTO favoritesDTO) {
        sqlSession.delete("favorites.removeShowFavorite", favoritesDTO);
    }
}

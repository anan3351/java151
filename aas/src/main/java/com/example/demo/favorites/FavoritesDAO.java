package com.example.demo.favorites;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
}

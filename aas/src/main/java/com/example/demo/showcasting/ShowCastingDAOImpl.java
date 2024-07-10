package com.example.demo.showcasting;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ShowCastingDAOImpl implements ShowCastingDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String Namespace = "com.example.demo.showcasting.ShowCastingMapper";

    @Override
    public List<ShowCastingDTO> getAllShowCastings() {
        return sqlSession.selectList(Namespace + ".getAllShowCastings");
    }

    @Override
    public ShowCastingDTO getShowCastingById(String showId) {
        return sqlSession.selectOne(Namespace + ".getShowCastingById", showId);
    }
    
    @Override
    public void addShowCasting(ShowCastingDTO showCasting) {
        sqlSession.insert(Namespace + ".addShowCasting", showCasting);
    }

    @Override
    public void updateShowCasting(ShowCastingDTO showCasting) {
        sqlSession.update(Namespace + ".updateShowCasting", showCasting);
    }

    @Override
    public void deleteById(String id) { // 이 부분을 수정했습니다
        sqlSession.delete(Namespace + ".deleteShowCasting", id);
    }
}

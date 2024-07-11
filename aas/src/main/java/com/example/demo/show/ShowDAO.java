package com.example.demo.show;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShowDAO {
	@Autowired 
	SqlSession sqlSession;
	
	// 공연 추가
	public void insert(Map<String, Object> map) {
		sqlSession.insert("show.insert", map);
	}
	
	// 공연 아이디 검색
	public List<String> id_list() {
        return sqlSession.selectList("show.list");
    }
	
	// 공연장 검색
	public List<Map<String, Object>> hall_search(String h_name) {
		return sqlSession.selectList("show.hallsearch", "%" + h_name + "%");
	}
	
	
	// show_id 네이밍
	public String showid_make() {
        String showid = "SHOW";
        List<String> show = id_list();
        
        if (show != null && !show.isEmpty()) {
            List<Integer> showNum = new ArrayList<>();
            
            for (String a : show) {
                try {
                    int num = Integer.parseInt(a.substring(4).trim());
                    showNum.add(num);
                } catch (NumberFormatException e) {
                    System.out.println("error : " + e);
                }
            }
            
            if (!showNum.isEmpty()) {
                Integer max = Collections.max(showNum);
                if (max == null || max == 0) showid += "1";
                else showid += (max + 1);
            } else showid += "1";
        } else showid += "1";

        return showid;
    }
	
	
	// 목록 조회
	public List<HashMap<String, Object>> list() {
        return sqlSession.selectList("show.list");
    }
}

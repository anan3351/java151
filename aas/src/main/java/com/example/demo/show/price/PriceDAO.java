package com.example.demo.show.price;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PriceDAO {
    @Autowired
	SqlSession sqlSession;

    public int priceInsert(PriceDTO priceDto) {
		return sqlSession.insert("show.priceInsert", priceDto);
	}
}

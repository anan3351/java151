package com.example.demo.hall;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;


@Repository
public interface HallRepository extends JpaRepository<HallEntity, String>{
	
	Page<HallEntity> findByHnameContaining(String hname, Pageable pageable);
    Page<HallEntity> findByAddrContaining(String addr, Pageable pageable);

    @Query(value = "SELECT h.* " +
            "FROM tb_hall h " +
            "JOIN tb_hallPay p ON h.hall_id = p.hall_id " +
            "WHERE p.h_day IS NOT NULL " +
            "AND h.hall_id LIKE '%-01' " +
            "ORDER BY h.h_code ASC " +
            "LIMIT :limit OFFSET :offset", 
    nativeQuery = true)
    List<HallEntity> findByHallIdWithNonNullHDayAndWithoutDash(@Param("limit") int limit, @Param("offset") int offset);
    
    @Query(value = "  SELECT COUNT(*) FROM tb_hall h"
    		+ "		 		  JOIN tb_hallPay p ON h.hall_id = p.hall_id"
    		+ "				  WHERE p.h_day IS NOT NULL"
    		+ "               AND h.hall_id LIKE '%-01%'"
    		+ "               ORDER BY h.h_code ASC ", nativeQuery = true)
    int countByHallIdWithoutDash();

    @Query(value = "SELECT * FROM tb_hall WHERE hall_id NOT LIKE '%-%' AND h_name LIKE %:word% ORDER BY seat LIMIT :limit OFFSET :offset", nativeQuery = true)
    List<HallEntity> findByHnameContainingWithoutDash(@Param("word") String word, @Param("limit") int limit, @Param("offset") int offset);
    //공연장명으로 검색했을시 나오는 공연장 데이터

    @Query(value = "SELECT COUNT(*) FROM tb_hall WHERE hall_id NOT LIKE '%-%' AND h_name LIKE %:word%", nativeQuery = true)
    int countByHnameContainingWithoutDash(@Param("word") String word);
    //공연장명으로 검색했을 시 나오는 공연장 갯수 데이터

    @Query(value = "SELECT * FROM tb_hall WHERE hall_id NOT LIKE '%-%' AND addr LIKE %:word% ORDER BY hall_id DESC LIMIT :limit OFFSET :offset", nativeQuery = true)
    List<HallEntity> findByAddrContainingWithoutDash(@Param("word") String word, @Param("limit") int limit, @Param("offset") int offset);
    //주소명으로 검색했을 시 나오는 공연장 데이터

    @Query(value = "SELECT COUNT(*) FROM tb_hall WHERE hall_id NOT LIKE '%-%' AND addr LIKE %:word%", nativeQuery = true)
    int countByAddrContainingWithoutDash(@Param("word") String word);
    //주소명으로 검색했을 시 나오는 공연장 데이터 갯수
    
    @Query(value = "SELECT * FROM tb_hall WHERE hall_id LIKE '%-%' AND miniHall IS NOT NULL", nativeQuery = true)
    List<HallEntity> findHallsWithMiniHallNotNull(@Param("limit") int limit, @Param("offset") int offset);
    
    
    @Query(value = "SELECT * FROM tb_hall WHERE miniHall IS NULL ORDER BY hall_id DESC LIMIT :limit OFFSET :offset", nativeQuery = true)
    List<HallEntity> findAllHallsWithMiniHall(@Param("limit") int limit, @Param("offset") int offset);
    //공연장 미니홀을 제외한 공연장만 보여주는 리스트 
   
    @Query(value = "SELECT COUNT(*) FROM tb_hall WHERE miniHall IS NULL", nativeQuery = true)
    int countAllHallsWithMiniHall();
    //공연장 미니홀을 제외한 공연만 갯수 리스트
}

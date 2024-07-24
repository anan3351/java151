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
	
	//공연장 대관가능 목록으로 검색했을때 나오는 리스트
    @Query(value = "SELECT h.* " +
            "FROM tb_hall h " +
            "JOIN tb_hallPay p ON h.hall_id = p.hall_id " +
            "WHERE p.h_day IS NOT NULL " +
            "AND h.hall_id LIKE '%-01' " +
            "ORDER BY h.h_code ASC " +
            "LIMIT :limit OFFSET :offset", 
    nativeQuery = true)
    List<HallEntity> findByHallIdWithNonNullHDayAndWithoutDash(@Param("limit") int limit, @Param("offset") int offset);
    
    //공연장 대관가능 목록으로 검색했을때 나오는 갯수 리스트
    @Query(value = "  SELECT COUNT(*) FROM tb_hall h"
    		+ "		 		  JOIN tb_hallPay p ON h.hall_id = p.hall_id"
    		+ "				  WHERE p.h_day IS NOT NULL"
    		+ "               AND h.hall_id LIKE '%-01%'"
    		+ "               ORDER BY h.h_code ASC ", nativeQuery = true)
    int countByHallIdWithoutDash();

    //공연장 대관가능 목록으로 공연장명 검색했을때 나오는 리스트
    @Query(value = "SELECT h.* " +
            "FROM tb_hall h " +
            "JOIN tb_hallPay p ON h.hall_id = p.hall_id " +
            "WHERE p.h_day IS NOT NULL " +
            "AND h.hall_id LIKE '%-01' " +
            "AND h.h_name LIKE CONCAT('%', :word, '%')" +
            "ORDER BY h.h_code ASC " +
            "LIMIT :limit OFFSET :offset", 
    nativeQuery = true)
    List<HallEntity> findByHallIdWithNonNullHDayAndHname(@Param("word") String word, @Param("limit") int limit, @Param("offset") int offset);
    
    //공연장 대관가능 목록으로 공연장명 검색했을때 나오는 갯수 리스트
    @Query(value = "  SELECT COUNT(*) FROM tb_hall h"
    		+ "		 		  JOIN tb_hallPay p ON h.hall_id = p.hall_id"
    		+ "				  WHERE p.h_day IS NOT NULL"
    		+ "               AND h.hall_id LIKE '%-01%'"
    		+ "               AND h.h_name LIKE CONCAT('%', :word, '%')"
    		+ "               ORDER BY h.h_code ASC ", nativeQuery = true)
    int countByHallIdWithoutDashAndHname(@Param("word") String word);
    
  //공연장 대관가능 목록으로 주소명 검색했을때 나오는 리스트
    @Query(value = "SELECT h.* " +
            "FROM tb_hall h " +
            "JOIN tb_hallPay p ON h.hall_id = p.hall_id " +
            "WHERE p.h_day IS NOT NULL " +
            "AND h.hall_id LIKE '%-01' " +
            "AND h.addr LIKE CONCAT('%', :word, '%')" +
            "ORDER BY h.h_code ASC " +
            "LIMIT :limit OFFSET :offset", 
    nativeQuery = true)
    List<HallEntity> findByHallIdWithNonNullHDayAndAddr(@Param("word") String word, @Param("limit") int limit, @Param("offset") int offset);
    
    //공연장 대관가능 목록으로 주소명 검색했을때 나오는 갯수 리스트
    @Query(value = "  SELECT COUNT(*) FROM tb_hall h"
    		+ "		 		  JOIN tb_hallPay p ON h.hall_id = p.hall_id"
    		+ "				  WHERE p.h_day IS NOT NULL"
    		+ "               AND h.hall_id LIKE '%-01%'"
    		+ "               AND h.addr LIKE CONCAT('%', :word, '%')"
    		+ "               ORDER BY h.h_code ASC ", nativeQuery = true)
    int countByHallIdWithoutDashAndAddr(@Param("word") String word);
    
    
    
    //공연관 전체목록 공연장명으로 검색했을때 리스트
    @Query(value = "SELECT * FROM tb_hall WHERE hall_id NOT LIKE '%-%' AND h_name LIKE CONCAT('%', :word, '%') ORDER BY seat LIMIT :limit OFFSET :offset", nativeQuery = true)
    List<HallEntity> findByHnameContainingWithoutDash(@Param("word") String word, @Param("limit") int limit, @Param("offset") int offset);

    //공연관 전체목록 공연장명으로 검색했을때 갯수 리스트
    @Query(value = "SELECT COUNT(*) FROM tb_hall WHERE hall_id NOT LIKE '%-%' AND h_name LIKE CONCAT('%', :word, '%')", nativeQuery = true)
    int countByHnameContainingWithoutDash(@Param("word") String word);

    //공연관 전체목록 주소명으로 검색했을때 리스트
    @Query(value = "SELECT * FROM tb_hall WHERE hall_id NOT LIKE '%-%' AND addr LIKE CONCAT('%', :word, '%') ORDER BY hall_id DESC LIMIT :limit OFFSET :offset", nativeQuery = true)
    List<HallEntity> findByAddrContainingWithoutDash(@Param("word") String word, @Param("limit") int limit, @Param("offset") int offset);

    //공연관 전체목록 주소명으로 검색했을때 갯수 리스트
    @Query(value = "SELECT COUNT(*) FROM tb_hall WHERE hall_id NOT LIKE '%-%' AND addr LIKE CONCAT('%', :word, '%')", nativeQuery = true)
    int countByAddrContainingWithoutDash(@Param("word") String word);
    
    
    //공연장 미니홀을 제외한 공연장만 보여주는 리스트 (공연관전체목록)
    @Query(value = "SELECT * FROM tb_hall WHERE miniHall IS NULL ORDER BY hall_id DESC LIMIT :limit OFFSET :offset", nativeQuery = true)
    List<HallEntity> findAllHallsWithMiniHall(@Param("limit") int limit, @Param("offset") int offset);
    
    //공연장 미니홀을 제외한 공연만 갯수 리스트 (공연관전체목록)
    @Query(value = "SELECT COUNT(*) FROM tb_hall WHERE miniHall IS NULL", nativeQuery = true)
    int countAllHallsWithMiniHall();
    
}

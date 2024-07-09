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

    @Query(value = "SELECT * FROM tb_hall WHERE hall_id NOT LIKE '%-%' ORDER BY hall_id DESC LIMIT :limit OFFSET :offset", nativeQuery = true)
    List<HallEntity> findByHallIdWithoutDash(@Param("limit") int limit, @Param("offset") int offset);
    
    @Query(value = "SELECT COUNT(*) FROM tb_hall WHERE hall_id NOT LIKE '%-%'", nativeQuery = true)
    int countByHallIdWithoutDash();

    @Query(value = "SELECT * FROM tb_hall WHERE hall_id NOT LIKE '%-%' AND hname LIKE %:word% ORDER BY hall_id DESC LIMIT :limit OFFSET :offset", nativeQuery = true)
    List<HallEntity> findByHnameContainingWithoutDash(@Param("word") String word, @Param("limit") int limit, @Param("offset") int offset);

    @Query(value = "SELECT COUNT(*) FROM tb_hall WHERE hall_id NOT LIKE '%-%' AND hname LIKE %:word%", nativeQuery = true)
    int countByHnameContainingWithoutDash(@Param("word") String word);

    @Query(value = "SELECT * FROM tb_hall WHERE hall_id NOT LIKE '%-%' AND addr LIKE %:word% ORDER BY hall_id DESC LIMIT :limit OFFSET :offset", nativeQuery = true)
    List<HallEntity> findByAddrContainingWithoutDash(@Param("word") String word, @Param("limit") int limit, @Param("offset") int offset);

    @Query(value = "SELECT COUNT(*) FROM tb_hall WHERE hall_id NOT LIKE '%-%' AND addr LIKE %:word%", nativeQuery = true)
    int countByAddrContainingWithoutDash(@Param("word") String word);
    
    @Query(value = "SELECT * FROM tb_hall WHERE hall_id LIKE '%-%' AND miniHall IS NOT NULL", nativeQuery = true)
    List<HallEntity> findHallsWithMiniHallNotNull(@Param("limit") int limit, @Param("offset") int offset);
    
    
}

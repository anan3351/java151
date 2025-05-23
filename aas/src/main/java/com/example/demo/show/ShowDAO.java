package com.example.demo.show;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.example.demo.actor.ActorDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.hall.HallDTO;
import com.example.demo.show.discount.DiscountDTO;
import com.example.demo.show.price.PriceDTO;
import com.example.demo.showcasting.ShowCastingDTO;

@Repository
public class ShowDAO {
	@Autowired
	SqlSession sqlSession;
	
	// Show
	
	// 뮤지컬 목록
	public List<Map<String, Object>> musicalList() {
	    return sqlSession.selectList("show.musicalList");
	}
	
	// 연극 목록
	public List<Map<String, Object>> playList() {
	    return sqlSession.selectList("show.playList");
	}
	
	// 공연 상세정보 조회
	public Map<String, Object> showDetail(String show_id) {
		return sqlSession.selectOne("show.showDetail", show_id);
	}
	
	// 공연 삭제
	public int showDelete(String show_id) {
	    int result = sqlSession.delete("show.showDelete", show_id);
	    return result; // 삭제된 행의 수 반환
	}

	// 공연 수정 페이지
	public ShowDTO showSelect(String show_id) {
		return sqlSession.selectOne("show.showSelect", show_id);
	}

	public int showUpdate(Map<String, Object> map) {
		int result = sqlSession.update("show.showUpdate", map);
		return result;
	}
	

	// ----------------------------------------------------------------------------------------------------------------------------------
	// Seller
	
	// 공연 추가
	public void insert(Map<String, Object> map) {
		sqlSession.insert("show.insert", map);
	}

	// 공연 추가 - 공연 아이디 검색
	public List<String> id_list() {
		return sqlSession.selectList("show.id_list");
	}

	// 공연 추가 - show_id 설정
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
				if (max == null || max == 0)
					showid += "1";
				else
					showid += (max + 1);
			} else
				showid += "1";
		} else
			showid += "1";

		return showid;
	}
	// -----

	
	
	// 공연 추가 - 검색된 공연장
	public List<HallDTO> findByHName(String h_name, int pageSize, int offset) {
		Map<String, Object> params = new HashMap<>();
		params.put("h_name", h_name);
		params.put("limit", pageSize);
		params.put("offset", offset);
		return sqlSession.selectList("show.findByHName", params);
	}

	// 공연 추가 - 검색된 공연장 개수
	public int countByHname(String h_name) {
		return sqlSession.selectOne("show.countByHname", h_name);
	}

	
	
	// 공연 목록 조회 - 진행 중, 예정
	public List<HashMap<String, Object>> findByShow(String user_id, int offset, long limit, String currentDate) {
		Map<String, Object> params = new HashMap<>();
		params.put("user_id", user_id);
		params.put("offset", offset);
		params.put("limit", limit);
		params.put("currentDate", currentDate);
		return sqlSession.selectList("show.findByShow", params);
	}

	// 공연 총 개수 조회 - 진행 중, 예정
	public int countByShow(String user_id, String currentDate) {
		Map<String, Object> params = new HashMap<>();
		params.put("user_id", user_id);
		params.put("currentDate", currentDate);
		return sqlSession.selectOne("show.countByShow", params);
	}

	// 종료 공연 목록 조회
	public List<HashMap<String, Object>> findByEndShow(String user_id, int offset, long limit, String currentDate) {
		Map<String, Object> params = new HashMap<>();
		params.put("user_id", user_id);
		params.put("offset", offset);
		params.put("limit", limit);
		params.put("currentDate", currentDate);
		return sqlSession.selectList("show.findByEndShow", params);
	}

	// 종료 공연 총 개수 조회
	public int countByEndShow(String user_id, String currentDate) {
		Map<String, Object> params = new HashMap<>();
		params.put("user_id", user_id);
		params.put("currentDate", currentDate);
		return sqlSession.selectOne("show.countByEndShow", params);
	}
	// -----

	
	
	// 공연 상세정보 조회
	public Map<String, Object> sellerDetail(String show_id, String user_id) {
		Map<String, Object> params = new HashMap<>();
		params.put("show_id", show_id);
		params.put("user_id", user_id);
		return sqlSession.selectOne("show.sellerDetail", params);
	}
	
	// 공연 상세정보 조회2 (좌석금액)
	public List<Map<String, Object>> sellerDetail2(String show_id) {
	    return sqlSession.selectList("show.sellerDetail2", show_id);
	}
	
	// 공연 상세정보 조회3 (전체금액(할인 적용))
	public List<Map<String, Object>> allPrice(String show_id) {
	    return sqlSession.selectList("show.allPrice", show_id);
	}
	

	// 할인 리스트(적용가능)
	public List<HashMap<String, Object>> findByDiscount(String show_id, String user_id, int offset, long limit) {
		Map<String, Object> params = new HashMap<>();
		params.put("show_id", show_id);
		params.put("user_id", user_id);
		params.put("offset", offset);
		params.put("limit", limit);
		return sqlSession.selectList("show.findByDiscount", params);
	}

	// 적용 가능 할인 개수
	public int countByDiscount(String show_id, String user_id) {
		Map<String, Object> params = new HashMap<>();
		params.put("show_id", show_id);
		params.put("user_id", user_id);
		return sqlSession.selectOne("show.countByDiscount", params);
	}

	// 할인 리스트(적용불가)
	public List<HashMap<String, Object>> findByEndDiscount(String show_id, String user_id, int offset, long limit) {
		Map<String, Object> params = new HashMap<>();
		params.put("show_id", show_id);
		params.put("user_id", user_id);
		params.put("offset", offset);
		params.put("limit", limit);
		return sqlSession.selectList("show.findByEndDiscount", params);
	}

	// 적용 불가능 할인 개수
	public int countByEndDiscount(String show_id, String user_id) {
		Map<String, Object> params = new HashMap<>();
		params.put("show_id", show_id);
		params.put("user_id", user_id);
		return sqlSession.selectOne("show.countByEndDiscount", params);
	}
	
	
	
	// 할인 등록
	public void disInsert(DiscountDTO disDto) {
		sqlSession.insert("show.disInsert", disDto);
	}

	// 할인 - 공연아이디 조회
	public String findByDisShowID(int dis_id) {
		return sqlSession.selectOne("show.findByDisShowID", dis_id);
	}
	
	// 할인 수정(페이지)
	public DiscountDTO discountSelect(int dis_id) {
		return sqlSession.selectOne("show.discountSelect", dis_id);
	}
	
	// 할인 수정(업데이트)
	public void disUpdate(DiscountDTO disDto) {
		sqlSession.update("show.disUpdate", disDto);
	}
	
	// 할인 삭제
	public void disDelete(int dis_id) {
		sqlSession.delete("show.disDelete", dis_id);
	}
	
	// -----------------------------------------------------------------------------------------------------------------------------------------
	
	// 좌석금액 리스트
	public List<HashMap<String, Object>> findByPrice(String show_id, String user_id, int offset, long limit) {
		Map<String, Object> params = new HashMap<>();
		params.put("show_id", show_id);
		params.put("user_id", user_id);
		params.put("offset", offset);
		params.put("limit", limit);
		return sqlSession.selectList("show.findByPrice", params);
	}
	
	// 좌석금액 개수
	public int countByPrice(String show_id, String user_id) {
		Map<String, Object> params = new HashMap<>();
		params.put("show_id", show_id);
		params.put("user_id", user_id);
		return sqlSession.selectOne("show.countByPrice", params);
	}
	
	// 좌석금액 - 좌석등급 리스트
	public List<String> seatList(String show_id) {
		return sqlSession.selectList("show.seatList", show_id);
	}
	
	// 좌석금액 등록
	public void priInsert(PriceDTO priDto) {
		sqlSession.insert("show.priInsert", priDto);
	}
	
	// 좌석금액 - 공연아이디 조회
	public String findByPriShowID(int price_id) {
		return sqlSession.selectOne("show.findByPriShowID", price_id);
	}
	
	// 좌석금액 수정(조회)
	public PriceDTO priceSelect(int price_id) {
		return sqlSession.selectOne("show.priceSelect", price_id);
	}
	
	// 좌석금액 수정(업데이트)
	public void priUpdate(PriceDTO priDto) {
		sqlSession.update("show.priUpdate", priDto);
	}
		
	// 좌석금액 삭제
	public void priDelete(int price_id) {
		sqlSession.delete("show.priDelete", price_id);
	}
	// -----------------------------------------------------------------------------------------------------------------------------------------
	
	// 캐스트 관리 목록
	public List<HashMap<String, Object>> findByCast(String show_id, int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("show_id", show_id);
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList("show.findByCast", params);
    }

    public int countByCast(String show_id) {
        return sqlSession.selectOne("show.countByCast", show_id);
    }

	// 배우 조회
	public List<ActorDTO> findByActor(String a_name, int pageSize, int offset) {
		Map<String, Object> params = new HashMap<>();
		params.put("a_name", a_name);
		params.put("limit", pageSize);
		params.put("offset", offset);
		return sqlSession.selectList("show.findByActor", params);
	}

	// 배역 추가 - 검색된 배우 수
	public int countByActor(String a_name) {
		return sqlSession.selectOne("show.countByActor", a_name);
	}
	
	// 배역추가
	public void roleInsert(ShowCastingDTO scDto) {
		sqlSession.insert("show.roleInsert", scDto);
	}
	
	// 배역 리스트
	public List<Map<String, Object>> roleList(String show_id) {
	    return sqlSession.selectList("show.roleList", show_id);
	}

	// 배역 - 배우 삭제
	public void actorDelete(int actor_id, String show_id) {
		Map<String, Object> params = new HashMap<>();
	    params.put("actor_id", actor_id);
	    params.put("show_id", show_id);
		sqlSession.delete("show.actorDelete", params);
	}
	
	// 배역 수정 페이지
	public ShowCastingDTO roleSelect(int casting_id) {
	    return sqlSession.selectOne("show.roleSelect", casting_id);
	}
	
	// 배역 - 배우 수정
	public void roleUpdate(int actorId, String casting, int castingId) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("actorId", actorId);
	    params.put("casting", casting);
	    params.put("castingId", castingId);
	    sqlSession.update("show.roleUpdate", params);
	}
	
	
	
	// 전체 공연 검색
	public List<ShowDTO> allShow(String title, int pageSize, int offset) {
		Map<String, Object> params = new HashMap<>();
		params.put("title", title);
		params.put("limit", pageSize);
		params.put("offset", offset);
		return sqlSession.selectList("show.allShow", params);
	}

	public int countByAllShow(String title) {
		return sqlSession.selectOne("show.countByAllShow", title);
	}



}
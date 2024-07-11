package com.example.demo.user;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import jakarta.servlet.http.HttpSession;

@Controller
public class KakaoLoginController {
    @Autowired
    private UserDAO userDAO;

    @GetMapping("/kakao/callback")
    public String kakaoCallback(@RequestParam String code, HttpSession session) {
        try {
            String accessToken = getAccessToken(code);
            String kakaoUserId = getKakaoUserId(accessToken);
            
            // "KAKAO_" 접두사와 카카오 ID의 앞 10자리를 조합 (총 16자)
            String uniqueKakaoId = "KAKAO_" + kakaoUserId.substring(0, Math.min(kakaoUserId.length(), 10));
            
            UserDTO existingUser = userDAO.getUserByUserId(uniqueKakaoId);
            if (existingUser == null) {
                // 새 사용자 등록
                UserDTO newUser = new UserDTO();
                newUser.setUser_id(uniqueKakaoId);
                newUser.setAuth("U"); // 기본 권한 설정
                userDAO.insertKakaoUser(newUser);
                existingUser = newUser;
            }
            
            // 세션에 사용자 정보 저장
            session.setAttribute("loggedInUser", existingUser);
            
            return "redirect:/"; // 메인 페이지로 리다이렉트
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/login?error=kakao"; // 에러 발생 시 로그인 페이지로 리다이렉트
        }
    }
    
    // getAccessToken 메서드는 이전과 동일

    private String getKakaoUserId(String accessToken) {
        try {
            RestTemplate rt = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.setBearerAuth(accessToken);
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

            HttpEntity<MultiValueMap<String, String>> kakaoUserInfoRequest = new HttpEntity<>(headers);

            ResponseEntity<String> response = rt.exchange(
                    "https://kapi.kakao.com/v2/user/me",
                    HttpMethod.POST,
                    kakaoUserInfoRequest,
                    String.class
            );

            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(response.getBody());
            return jsonNode.get("id").asText();
        } catch (HttpClientErrorException e) {
            System.out.println("HTTP Error: " + e.getStatusCode() + " " + e.getStatusText());
            System.out.println("Response Body: " + e.getResponseBodyAsString());
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to get Kakao user info", e);
        }
    }

    
    private String getAccessToken(String code) {
        RestTemplate rt = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", "ed2700534e63214f5b299b09f4b82bb0");  // 실제 클라이언트 ID로 교체
        params.add("redirect_uri", "http://localhost:9095/kakao/callback");  // 실제 리다이렉트 URI로 교체
        params.add("code", code);

        HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest =
                new HttpEntity<>(params, headers);

        try {
            ResponseEntity<String> response = rt.exchange(
                    "https://kauth.kakao.com/oauth/token",
                    HttpMethod.POST,
                    kakaoTokenRequest,
                    String.class
            );

            // 응답 바디에서 액세스 토큰 추출
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(response.getBody());
            String accessToken = jsonNode.get("access_token").asText();

            System.out.println("Access Token: " + accessToken);
            return accessToken;
        } catch (Exception e) {
            System.out.println("Error getting access token: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to get access token from Kakao", e);
        }
    }
    
    
}
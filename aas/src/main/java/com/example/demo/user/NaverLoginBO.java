package com.example.demo.user;

import java.io.IOException;
import java.util.UUID;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import jakarta.servlet.http.HttpSession;

@Component
public class NaverLoginBO {
    private final static String CLIENT_ID = "Q7zyZZocbassirssUAsd";
    private final static String CLIENT_SECRET = "FJk5sGlfVf";
    private final static String REDIRECT_URI = "http://localhost:9095/naver/callback";
    private final static String SESSION_STATE = "oauth_state";
    private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";
    
    public String getAuthorizationUrl(HttpSession session) {
        String state = generateRandomString();
        setSession(session, state);
        OAuth20Service oauthService = new ServiceBuilder()
                .apiKey(CLIENT_ID)
                .apiSecret(CLIENT_SECRET)
                .callback(REDIRECT_URI)
                .state(state)
                .build(NaverLoginApi.instance());
        return oauthService.getAuthorizationUrl();
    }

    public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException {
        String sessionState = getSession(session);
        if(StringUtils.pathEquals(sessionState, state)){
            OAuth20Service oauthService = new ServiceBuilder()
                    .apiKey(CLIENT_ID)
                    .apiSecret(CLIENT_SECRET)
                    .callback(REDIRECT_URI)
                    .state(state)
                    .build(NaverLoginApi.instance());
            try {
                OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
                return accessToken;
            } catch (IOException e) {
                throw new IOException("Failed to get access token: " + e.getMessage(), e);
            }
        }
        throw new IllegalStateException("Session state does not match");
    }
    
    private String generateRandomString() {
        return UUID.randomUUID().toString();
    }
    
    private void setSession(HttpSession session, String state){
        session.setAttribute(SESSION_STATE, state);     
    }
    
    private String getSession(HttpSession session){
        return (String) session.getAttribute(SESSION_STATE);
    }
    
    public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException {
        OAuth20Service oauthService = new ServiceBuilder()
                .apiKey(CLIENT_ID)
                .apiSecret(CLIENT_SECRET)
                .callback(REDIRECT_URI)
                .build(NaverLoginApi.instance());
        OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
        oauthService.signRequest(oauthToken, request);
        try {
            Response response = request.send();
            if (response.getCode() != 200) {
                throw new IOException("Failed to get user profile. HTTP error code: " + response.getCode());
            }
            return response.getBody();
        } catch (IOException e) {
            throw new IOException("Failed to get user profile: " + e.getMessage(), e);
        }
    }
}
package com.example.demo.favorites;

public class FavoritesDTO {
    private int favorites_id;
    private String user_id;
    private Integer actor_id;
    private String show_id;
    private int favor;

    // 기본 생성자
    public FavoritesDTO() {}

    // user_id와 actor_id를 받는 생성자
    public FavoritesDTO(String user_id, Integer actor_id) {
        this.user_id = user_id;
        this.actor_id = actor_id;
    }

    // user_id와 show_id를 받는 생성자
    public FavoritesDTO(String user_id, String show_id) {
        this.user_id = user_id;
        this.show_id = show_id;
    }

    // Getters and setters
    public int getFavorites_id() {
        return favorites_id;
    }

    public void setFavorites_id(int favorites_id) {
        this.favorites_id = favorites_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public Integer getActor_id() {
        return actor_id;
    }

    public void setActor_id(Integer actor_id) {
        this.actor_id = actor_id;
    }

    public String getShow_id() {
        return show_id;
    }

    public void setShow_id(String show_id) {
        this.show_id = show_id;
    }

    public int getFavor() {
        return favor;
    }

    public void setFavor(int favor) {
        this.favor = favor;
    }
}

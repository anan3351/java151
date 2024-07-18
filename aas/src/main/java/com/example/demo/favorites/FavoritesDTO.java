package com.example.demo.favorites;

public class FavoritesDTO {
    private int favorites_id;
    private String user_id;
    private Integer actor_id;
    private String show_id;
    private int favor;

    public FavoritesDTO() {}

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

    @Override
    public String toString() {
        return "FavoritesDTO [favorites_id=" + favorites_id + ", user_id=" + user_id + ", actor_id=" + actor_id + ", show_id=" + show_id + ", favor=" + favor + "]";
    }
}

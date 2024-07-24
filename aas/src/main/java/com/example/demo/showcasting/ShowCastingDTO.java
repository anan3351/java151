package com.example.demo.showcasting;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ShowCastingDTO {
    private int casting_id;
    private String show_id;
    private int actor_id;
    private String casting;
    
    public ShowCastingDTO() {}
    
    public ShowCastingDTO(String show_id, int actor_id, String casting) {
        this.show_id = show_id;
        this.actor_id = actor_id;
        this.casting = casting;
    }
    
}

package com.example.demo.showcasting;

import java.util.List;

public interface ShowCastingDAO {
    List<ShowCastingDTO> getAllShowCastings();
    ShowCastingDTO getShowCastingById(String showId);
    void addShowCasting(ShowCastingDTO showCasting);
    void updateShowCasting(ShowCastingDTO showCasting);
    void deleteById(String id);
}

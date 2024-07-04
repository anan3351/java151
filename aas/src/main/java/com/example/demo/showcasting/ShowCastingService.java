package com.example.demo.showcasting;

import java.util.List;

public interface ShowCastingService {
    List<ShowCastingDTO> getAllShowCastings();
    ShowCastingDTO getShowCastingById(String id);
    void addShowCasting(ShowCastingDTO showCasting);
    void updateShowCasting(ShowCastingDTO showCasting);
    void deleteShowCasting(String id);
}

package com.example.demo.showcasting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShowCastingServiceImpl implements ShowCastingService {

    @Autowired
    private ShowCastingDAO showCastingDAO;

    @Override
    public List<ShowCastingDTO> getAllShowCastings() {
        return showCastingDAO.getAllShowCastings();
    }

    @Override
    public ShowCastingDTO getShowCastingById(String id) {
        return showCastingDAO.getShowCastingById(id);
    }

    @Override
    public void addShowCasting(ShowCastingDTO showCasting) {
        showCastingDAO.addShowCasting(showCasting);
    }

    @Override
    public void updateShowCasting(ShowCastingDTO showCasting) {
        showCastingDAO.updateShowCasting(showCasting);
    }

    @Override
    public void deleteShowCasting(String id) {
        showCastingDAO.deleteById(id);
    }
}

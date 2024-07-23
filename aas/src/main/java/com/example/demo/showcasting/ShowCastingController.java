package com.example.demo.showcasting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/showcasting")
public class ShowCastingController {

    @Autowired
    private ShowCastingService showCastingService;

    @GetMapping
    public String getAllShowCastings(Model model) {
        List<ShowCastingDTO> showCastings = showCastingService.getAllShowCastings()
                .stream()
                .sorted((sc1, sc2) -> Integer.compare(sc1.getCasting_id(), sc2.getCasting_id()))
                .collect(Collectors.toList());
        model.addAttribute("showCastings", showCastings);
        return "showcasting/showcasting";
    }

    @GetMapping("/{id}")
    public String getShowCastingById(@PathVariable String id, Model model) {
        ShowCastingDTO showCasting = showCastingService.getShowCastingById(id);
        model.addAttribute("showCasting", showCasting);
        return "showcasting/showcastingDetail";
    }

    @PostMapping
    public String addShowCasting(@ModelAttribute ShowCastingDTO showCasting) {
        showCastingService.addShowCasting(showCasting);
        return "redirect:/showcasting";
    }

    @PutMapping("/{id}")
    public String updateShowCasting(@PathVariable String id, @ModelAttribute ShowCastingDTO showCasting) {
        showCasting.setShow_id(id);
        showCastingService.updateShowCasting(showCasting);
        return "redirect:/showcasting";
    }

    @DeleteMapping("/{id}")
    public String deleteShowCasting(@PathVariable String id) {
        showCastingService.deleteShowCasting(id);
        return "redirect:/showcasting";
    }
}

package net.koreate.cinema.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.koreate.cinema.services.MovieService;

@Controller
@RequestMapping("/movie")
public class MovieController {
	
    @Autowired
    private MovieService service;	

    // 현재 상영작 (DB 연결)
	@GetMapping("/goingMov")
	public String goingMov(Model model) {
		
        model.addAttribute("list", service.list());

        return "movie/goingMov";
	}
	
	// 상영 예정작 (일단 그대로)
	@GetMapping("/willGoMov")
    public String willGoMov() {

        return "movie/willGoMov";
	}
	
}

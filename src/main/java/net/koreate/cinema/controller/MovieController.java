package net.koreate.cinema.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.koreate.cinema.services.MovieService;
import net.koreate.cinema.vo.MovieVO;

@Controller
@RequestMapping("/movie")
public class MovieController {
	
    @Autowired
    private MovieService service;	

    // 현재 상영작 (DB 연결)
	@GetMapping("/goingMov")
	public String goingMov(Model model) {
		
		System.out.println("Controller 진입");
		
		List<MovieVO> list = service.list();
		
        model.addAttribute("list", list);
        System.out.println("list: " + list);

        return "movie/goingMov";
	}
	
	// 상영 예정작 (일단 그대로)
	@GetMapping("/willGoMov")
    public String willGoMov() {

        return "movie/willGoMov";
	}
	
}

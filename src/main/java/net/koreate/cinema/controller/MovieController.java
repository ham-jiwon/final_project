package net.koreate.cinema.controller;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
		
		//날짜 필터링
		Date today = new Date();

		List<MovieVO> filtered = list.stream()
		    .filter(m -> m.getRelease_date().before(today) || m.getRelease_date().equals(today))
		    .collect(Collectors.toList());

		model.addAttribute("list", filtered);
        System.out.println("list: " + filtered);

        return "movie/goingMov";
	}
	
	// 상영 예정작 (일단 그대로)
	@GetMapping("/willGoMov")
    public String willGoMov(Model model) {
		
	    List<MovieVO> list = service.list();

	    Date today = new Date();

	    List<MovieVO> filtered = list.stream()
	        .filter(m -> m.getRelease_date().after(today))  // 미래 시점에 상영할 영화
	        .collect(Collectors.toList());

	    model.addAttribute("list", filtered);		

        return "movie/willGoMov";
	}
	
	@GetMapping("/movieDetail")
	public String movieDetail(@RequestParam("code") int code, Model model) {
	    
		MovieVO movie = service.read(code);
		
	    model.addAttribute("movie", movie);
	    
	    return "movie/movieDetail";
	}
	
}

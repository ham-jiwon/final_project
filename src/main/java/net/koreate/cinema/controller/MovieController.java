package net.koreate.cinema.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/movie")
public class MovieController {

	@GetMapping("/goingMov")
	public String goingMov() {
		
		return "movie/goingMov";
	}
	
	@GetMapping("/willGoMov")
	public String willGoMov() {
		
		return "movie/willGoMov";
	}
	
}

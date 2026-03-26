package net.koreate.cinema.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/theater")
public class TheaterController {

	@GetMapping("/cgv")
	public String cgv() {
		
		return "theater/cgv";
	}
	
	@GetMapping("/lotte")
	public String lotte() {
		
		return "theater/lotte";
	}
	
	@GetMapping("/mega")
	public String mega() {
		
		return "theater/mega";
	}	
	
}

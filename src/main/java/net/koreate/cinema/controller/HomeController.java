package net.koreate.cinema.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import net.koreate.cinema.services.MovieService;
import net.koreate.cinema.vo.MovieVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private MovieService service;
		
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		List<MovieVO> list = service.list();
		model.addAttribute("list", list);		
		
		return "home";
	}
	
}

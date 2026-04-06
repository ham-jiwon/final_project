package net.koreate.cinema.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.koreate.cinema.services.TheaterService;
import net.koreate.cinema.vo.BranchVO;
import net.koreate.cinema.vo.MovieVO;
import net.koreate.cinema.vo.ScheduleVO;
import net.koreate.cinema.vo.TheaterVO;

@Controller
@RequestMapping("/theater")
public class TheaterController {

	@Autowired
	private TheaterService service;
	
	@GetMapping("/cgv")
	public String cgv(Model model) {
		List<TheaterVO> list = service.theaterList();
		model.addAttribute("theaterList", list);
		model.addAttribute("selectedTheater", 1);
		return "theater/bookingByTheater";
	}
	
	@GetMapping("/lotte")
	public String lotte(Model model) {
		List<TheaterVO> list = service.theaterList();
		model.addAttribute("theaterList", list);
		model.addAttribute("selectedTheater", 2);
		return "theater/bookingByTheater";
	}
	
	@GetMapping("/mega")
	public String mega(Model model) {
		List<TheaterVO> list = service.theaterList();
		model.addAttribute("theaterList", list);
		model.addAttribute("selectedTheater", 3);
		return "theater/bookingByTheater";
	}
	
	// 지점 목록 Ajax
	@GetMapping("/branchList")
	@ResponseBody
	public List<BranchVO> branchList(@RequestParam int theaterCode){
		return service.branchList(theaterCode);
	}
	
	// 영화 목록 Ajax
	@GetMapping("/movieByBranch")
	@ResponseBody
	public List<MovieVO> movieList(@RequestParam int branchCode){
		return service.moviByBranch(branchCode);
	}
	
	// 스케쥴 Ajax
	@GetMapping("/scheduleByMovie")
	@ResponseBody
	public List<ScheduleVO> scheduleList(@RequestParam int branchCode, @RequestParam int movieCode){
		return service.scheduleBymovie(branchCode, movieCode);
	}
	
	
	
	
	
	
	
	
}//end TheaterController

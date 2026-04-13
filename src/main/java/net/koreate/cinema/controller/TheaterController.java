package net.koreate.cinema.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.koreate.cinema.services.MovieListService;
import net.koreate.cinema.services.TheaterService;
import net.koreate.cinema.vo.BranchVO;
import net.koreate.cinema.vo.MovieVO;
import net.koreate.cinema.vo.ScheduleVO;
import net.koreate.cinema.vo.ScreenVO;
import net.koreate.cinema.vo.TheaterVO;

@Controller
@RequestMapping("/theater")
public class TheaterController {

	@Autowired
	private TheaterService service;
	
	@Autowired
	private MovieListService movieService;
	
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
	
	@GetMapping("bookingByTheater")
	public String bookingByTheater(Model model) {
		List<TheaterVO> list = service.theaterList();
		model.addAttribute("theaterList", list);
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
		return service.movieByBranch(branchCode);
	}
	
	// 영화별 스케쥴 Ajax
	@GetMapping("/scheduleByMovie")
	@ResponseBody
	public List<ScheduleVO> scheduleList(@RequestParam int branchCode, @RequestParam int movieCode){
		return service.scheduleBymovie(branchCode, movieCode);
	}
	
	// 날짜별 스케쥴 Ajax
	@GetMapping("/scheduleByDate")
	@ResponseBody
	public List<ScheduleVO> scheduleList(@RequestParam int branchCode, 
										 @RequestParam int movieCode, 
										 @RequestParam String date){
		return service.scheduleByDate(branchCode, movieCode, date);
	}
	
	////////////////////////////////////////////////////////////////////////////
	// 영화 상세 페이지에서 예매(스케쥴 확인) 눌렀을 때
	
	@GetMapping("/bookingByMovie")
	public String bookingByMovie(@RequestParam(required = false) Integer movie_code, Model model) {
		List<MovieVO> movieList = movieService.getList();
		List<TheaterVO> theaterList = service.theaterList();
		model.addAttribute("theaterList", theaterList);
		model.addAttribute("movieList", movieList);
		model.addAttribute("selectedMovie", movie_code);
		return "theater/bookingByMovie";
	}
	
	// 영화관 목록 Ajax
	@GetMapping("/theaterList")
	@ResponseBody
	public List<TheaterVO> theaterList(){
		return service.theaterList();
	}
	
	
	////////////////////////////////////////////////////////////////////////////
	// 스케줄 관리
	
	@GetMapping("/scheduleAdd")
	public String scheduleSetting(Model model) {
		List<TheaterVO> theaterList = service.theaterList();
		List<MovieVO> movieList = movieService.getList();
		model.addAttribute("theaterList", theaterList);
		model.addAttribute("movieList", movieList);
		return "theater/scheduleAdd";
	}//end scheduleSetting
	
	
	@GetMapping("/screenByBranch")
	@ResponseBody
	public List<ScreenVO> screenByBranch(int branchCode){
	    return service.screenByBranch(branchCode);
	}
	
	@PostMapping("/scheduleAdd")
	public String scheduleAdd(ScheduleVO vo){
	    service.insertSchedule(vo);
	    return "redirect:/theater/scheduleAdd?success=true";
	}
	
	
	// 스케줄 목록 페이지
	@GetMapping("/scheduleList")
	public String scheduleList(Model model) {
	    List<TheaterVO> theaterList = service.theaterList();
	    model.addAttribute("theaterList", theaterList);
	    return "theater/scheduleList";
	}

	// 스케줄 목록 Ajax
	@GetMapping("/scheduleListAjax")
	@ResponseBody
	public List<ScheduleVO> scheduleListAjax(@RequestParam int branchCode, @RequestParam String date) {
	    return service.scheduleList(branchCode, date);
	}

	// 스케줄 삭제
	@PostMapping("/scheduleDelete")
	public String scheduleDelete(@RequestParam int scheduleCode) {
	    service.deleteSchedule(scheduleCode);
	    return "redirect:/theater/scheduleList?success=true";
	}

	// 스케줄 수정 페이지
	@GetMapping("/scheduleUpdate")
	public String scheduleUpdate(@RequestParam int scheduleCode, Model model) {
	    ScheduleVO vo = service.getSchedule(scheduleCode);
	    model.addAttribute("schedule", vo);
	    return "theater/scheduleUpdate";
	}

	// 스케줄 수정 처리
	@PostMapping("/scheduleUpdate")
	public String scheduleUpdate(ScheduleVO vo) {
	    service.updateSchedule(vo);
	    return "redirect:/theater/scheduleList?success=true";
	}
	
	
	
}//end TheaterController

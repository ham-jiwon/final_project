package net.koreate.cinema.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.koreate.cinema.services.MovieListService;
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
	
	// 吏��젏 紐⑸줉 Ajax
	@GetMapping("/branchList")
	@ResponseBody
	public List<BranchVO> branchList(@RequestParam int theaterCode){
		return service.branchList(theaterCode);
	}
	
	// �쁺�솕 紐⑸줉 Ajax
	@GetMapping("/movieByBranch")
	@ResponseBody
	public List<MovieVO> movieList(@RequestParam int branchCode){
		return service.moviByBranch(branchCode);
	}
	
	// �쁺�솕蹂� �뒪耳�伊� Ajax
	@GetMapping("/scheduleByMovie")
	@ResponseBody
	public List<ScheduleVO> scheduleList(@RequestParam int branchCode, @RequestParam int movieCode){
		return service.scheduleBymovie(branchCode, movieCode);
	}
	
	// �궇吏쒕퀎 �뒪耳�伊� Ajax
	@GetMapping("/scheduleByDate")
	@ResponseBody
	public List<ScheduleVO> scheduleList(@RequestParam int branchCode, 
										 @RequestParam int movieCode, 
										 @RequestParam String date){
		return service.scheduleByDate(branchCode, movieCode, date);
	}
	
	////////////////////////////////////////////////////////////////////////////
	// �쁺�솕 �긽�꽭 �럹�씠吏��뿉�꽌 �삁留�(�뒪耳�伊� �솗�씤) �닃���쓣 �븣
	
	@GetMapping("/bookingByMovie")
	public String bookingByMovie(@RequestParam(required = false) Integer movie_code, Model model) {
		List<MovieVO> movieList = movieService.getList();
		List<TheaterVO> theaterList = service.theaterList();
		model.addAttribute("theaterList", theaterList);
		model.addAttribute("movieList", movieList);
		model.addAttribute("selectedMovie", movie_code);
		return "theater/bookingByMovie";
	}
	
	// �쁺�솕愿� 紐⑸줉 Ajax
	@GetMapping("/theaterList")
	@ResponseBody
	public List<TheaterVO> theaterList(){
		return service.theaterList();
	}
	
	
	
	
}//end TheaterController

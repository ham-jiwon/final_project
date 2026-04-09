package net.koreate.cinema.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.koreate.cinema.services.CommentService;
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
	
	@Autowired
	private CommentService commentService;	
	
	@GetMapping("/movieDetail")
	public String movieDetail(@RequestParam("code") int code, Model model) {
	    
		MovieVO movie = service.read(code);
		
	    model.addAttribute("movie", movie);
	    
	    // 리뷰 목록 가져오기
	    List<Integer> ratings = commentService.getRatings(code);
	    // 개수
	    int ratingCount = ratings.size();
	    // 별점 평균
	    double avgRating = 0.0;
	    
	    if(ratingCount > 0){
	        avgRating = ratings.stream()
	            .mapToInt(Integer::intValue)
	            .average()
	            .orElse(0.0);
	    }
	    // 분포
	    Map<Integer, Integer> ratingMap = new HashMap<>();

	    for(int i=1; i<=5; i++){
	        ratingMap.put(i, 0);
	    }

	    for(int r : ratings){
	        ratingMap.put(r, ratingMap.get(r) + 1);
	    }
	    
	    model.addAttribute("avgRating", avgRating);
	    model.addAttribute("ratingCount", ratingCount);
	    model.addAttribute("ratingMap", ratingMap);
	    
	    return "movie/movieDetail";
	}
	
}

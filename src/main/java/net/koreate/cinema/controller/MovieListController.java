package net.koreate.cinema.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import net.koreate.cinema.services.MovieListService;
import net.koreate.cinema.vo.MemberVO;
import net.koreate.cinema.vo.MovieVO;

@Controller
@RequestMapping("/admin")
public class MovieListController {

    @Autowired
    private MovieListService service;

    @GetMapping("/movieList")
    public String movieList(Model model, HttpSession session){

        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        if(loginMember == null || !loginMember.getId().equals("admin")){
            return "redirect:/";
        }

        model.addAttribute("list", service.getList());
        return "admin/movieList";
    }
    
    @GetMapping("/movieUpdate")
    public String movieUpdateForm(@RequestParam("movie_code") int movie_code,
            Model model, HttpSession session) {
    	
    	System.out.println("movieUpdate 진입: " + movie_code);
    	
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        if(loginMember == null || !loginMember.getId().equals("admin")){
            return "redirect:/";
        }   	
    	
        model.addAttribute("movie", service.getMovie(movie_code));
        return "admin/movieUpdate";
    }
	
    @PostMapping("/movieUpdate")
    public String movieUpdate(
    		@ModelAttribute MovieVO movie, 
            @RequestParam(value="posterFile", required=false) MultipartFile file,
            @RequestParam("oldPoster") String oldPoster,    		
    		HttpSession session,
    		HttpServletRequest request) {

        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        if(loginMember == null || !loginMember.getId().equals("admin")){
            return "redirect:/";
        }
        
        // 파일 처리
        if (file != null && !file.isEmpty()) {

            String fileName = file.getOriginalFilename();

            String uploadPath = request.getServletContext()
                    .getRealPath("/resources/img/movies/");

            File saveFile = new File(uploadPath, fileName);

            try {
                file.transferTo(saveFile);
                movie.setPoster("/resources/img/movies/" + fileName); // 풀경로 저장
            } catch (Exception e) {
                e.printStackTrace();
            }

        } else {
            movie.setPoster(oldPoster); // 기존 유지 (이미 풀경로 상태)
        }        

        service.updateMovie(movie);

        return "redirect:/admin/movieList";
    } 
    
    @GetMapping("/movieDelete")
    public String movieDelete(int movie_code, HttpSession session) {
    	
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        if(loginMember == null || !loginMember.getId().equals("admin")){
            return "redirect:/";
        }    	
    	
        service.deleteMovie(movie_code);
        return "redirect:/admin/movieList";
    }     
    
}

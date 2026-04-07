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

            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();

            // ✅ 기존 방식 (톰캣)
            String serverPath = request.getSession()
            		.getServletContext()
                    .getRealPath("/resources/img/movies/");
            
            // ✅ 추가 기능 (프로젝트 폴더 - git용)
            String projectPath = System.getProperty("user.dir");
            String gitPath = projectPath + "/src/main/webapp/resources/img/movies/";            
            
            System.out.println("서버 경로: " + serverPath);
            System.out.println("프로젝트 경로: " + gitPath);           

            try {
            	// 1️) 톰캣 저장 (기존 유지)                
                if(serverPath != null) {
                    File serverFile = new File(serverPath, fileName);
                    file.transferTo(serverFile);
                }
                
                // 2) 프로젝트 폴더 저장 (추가 기능)
                File dir = new File(gitPath);
                if(!dir.exists()) dir.mkdirs();

                File gitFile = new File(gitPath, fileName);
                file.transferTo(gitFile);
                
                // 기존 이미지 삭제
                if(oldPoster != null && !oldPoster.isEmpty()) {
                    String oldFileName = oldPoster.substring(oldPoster.lastIndexOf("/") + 1);

                    File oldFile = new File(gitPath, oldFileName);
                    if(oldFile.exists()) {
                        oldFile.delete();
                    }
                }                
                
                // DB 저장 경로
                movie.setPoster("/resources/img/movies/" + fileName);
                
            } catch (Exception e) {
                e.printStackTrace();
            }

        } else {
            movie.setPoster(oldPoster); // 기존 유지
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

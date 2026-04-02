package net.koreate.cinema.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.koreate.cinema.services.MovieListService;
import net.koreate.cinema.vo.MemberVO;

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
	
}

package net.koreate.cinema.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import net.koreate.cinema.services.MemberService;
import net.koreate.cinema.services.MovieService;
import net.koreate.cinema.vo.MemberVO;
import net.koreate.cinema.vo.MovieVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private MovieService service;
	
	@Autowired
	private MemberService memberService;
		
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest request, HttpSession session) {
		
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie c : cookies) {
				String cookieName = c.getName();
				if(cookieName.equals("rememberMe")) {
					String loginId = c.getValue();
					MemberVO loginMember = memberService.readMember(loginId);
					session.setAttribute("loginMember", loginMember);
				}
			}
		}
		
		List<MovieVO> list = service.list();
		model.addAttribute("list", list);		
		
		return "home";
	}
	
}

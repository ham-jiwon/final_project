package net.koreate.cinema.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.koreate.cinema.services.MemberService;
import net.koreate.cinema.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	
	@PostMapping("joinAction")
	public String joinAction(MemberVO member) {
		service.insertMember(member);
		return "redirect:/member/login";
	}
	
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/loginAction")
	public String loginAction(MemberVO member, HttpSession session) {
		MemberVO loginResult = service.loginMember(member);
		
		if(loginResult != null) {
			session.setAttribute("loginMember", loginResult);
			return "redirect:/";
		}else {
			return "member/login";
		}
	}

	
	@GetMapping("/logout")
	public String logout(HttpSession session){
		session.invalidate();
		return "replace:/";
	}
	
	
	
	
}//end calss

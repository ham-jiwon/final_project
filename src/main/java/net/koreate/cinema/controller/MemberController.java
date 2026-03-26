package net.koreate.cinema.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.koreate.cinema.services.MemberService;
import net.koreate.cinema.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@GetMapping("/join")
	public String join() {
		
		return "member/join";
	}
	
	@GetMapping("/login")
	public String login() {
		
		return "member/login";
	}
	
	@GetMapping("/info")
	public String info() {
		
		return "member/info";
	}

	@GetMapping("/logout")
	public String logout() {
		
		return "member/logout";
	}	
	
	@GetMapping("/memberList")
	public String memberList() {
		
		return "member/memberList";
	}	
	
	@PostMapping("joinAction")
	public String joinAction(MemberVO member) {
		MemberService.insertMember(member);
		return "redirect:/";
	}
	
}//end calss

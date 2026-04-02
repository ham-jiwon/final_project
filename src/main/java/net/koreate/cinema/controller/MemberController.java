package net.koreate.cinema.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.koreate.cinema.services.MemberService;
import net.koreate.cinema.utils.Criteria;
import net.koreate.cinema.utils.PageMaker;
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
	public String joinAction(MemberVO member, String passAgain) {
		if(!member.getPass().equals(passAgain)) {
			return "redirect:/member/join?pwFail=true";
		}
		
		int idCheck = service.idCheck(member.getId());
		if(idCheck > 0) {
			return "redirect:/member/join?fail=true"; // 아이디 중복이면 다시
		}
		service.insertMember(member);
		return "redirect:/member/login";
	}
	
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	

	@GetMapping("/info")
	public String info() {
		
		return "member/info";
	}
	
	@GetMapping("/passConfirm")
	public String passConfirm() {
		return "member/passConfirm";
	}//end update

	@PostMapping("/update")
	public String update(String pass, String passAgain, HttpSession session) {
		if(!pass.equals(passAgain)) {
			return "redirect:/member/info?passAgainFail=true";
		}else {
			MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");
			
			if(loginMember.getPass().equals(pass)){
				return "member/update";
			}
			return "redirect:/member/info?passAgainFail=true";			
		}
	}//end update
	
	@PostMapping("/updateAction")
	public String updateAction(MemberVO member, HttpSession session) {
		int result = service.updateMember(member);
		if(result == 1) {
			session.setAttribute("loginMember", member);
			return "redirect:/member/info";
		}else {
			return "redirect:/member/update?updateFail=true";
		}
	}//end updateAction
	

	
	
	@PostMapping("/remove")
	public String remove(String pass, String passAgain, HttpSession session) {
		MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");
		if(!pass.equals(passAgain)) {
			return "redirect:/member/info?passAgainFail=true";
		}else {
			if(loginMember.getPass().equals(pass)){
				int result = service.removeMember(loginMember.getNum());
				if(result < 1) {
					return "redirect:/member/info?removeFail=true";
				}
				session.invalidate();
				return "redirect:/?removeSuccess=true";
			}
			return "redirect:/member/info?passAgainFail=true";
		}
	}//end remove
	

	
	@GetMapping("/memberList")
	public String memberList(Model model, Criteria cri) {
		int totalCount = service.totalMemberCount(); 
		PageMaker pm = new PageMaker(cri, totalCount, 10);
		List<MemberVO> list = service.readMemberList(cri.offset(), cri.getPerPageNum());
		model.addAttribute("memberList", list);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("criteria", cri);
		model.addAttribute("pageMaker", pm);
		return "member/memberList";
	}
	
	

	@PostMapping("/loginAction")
	public String loginAction(MemberVO member, HttpSession session, boolean rememberMe, HttpServletResponse response) {
		MemberVO loginResult = service.loginMember(member);
		if(rememberMe == true) {
			Cookie cookie = new Cookie("rememberMe", member.getId());
			cookie.setMaxAge(60*60*24*15);
			cookie.setPath("/");
			response.addCookie(cookie);
		}
		if(loginResult != null) {
			session.setAttribute("loginMember", loginResult);
			return "redirect:/";
		}else {
			return "redirect:/member/login?fail=true";
		}

	}

	
	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletResponse response){
		session.invalidate();
		Cookie cookie = new Cookie("rememberMe", "");
		cookie.setPath("/");
		cookie.setMaxAge(0);
		response.addCookie(cookie);
		return "redirect:/";
	}
	
	@GetMapping("adminUpdate")
	public String adminUpdate(String id, Model model) {
		MemberVO member = service.readMember(id);
		model.addAttribute("updateMember", member);
		return "member/adminUpdate";
	}
	
	@PostMapping("adminUpdateAction")
	public String adminUpdateAction(MemberVO member, Model model) {
		int result = service.updateMember(member);
		if(result >0) {
			return "redirect:/member/memberList?updateSuccess=true";
		}else {
			model.addAttribute("updateMember", member);			
			return "redirect:/member/adminUpdate?updateFail=true";
		}
	}
	
	@GetMapping("adminRemove")
	public String adminRemove(String id) {
		MemberVO member = service.readMember(id);
		int result = service.removeMember(member.getNum());
		if(result > 0) {
			return "redirect:/member/memberList?removeSuccess=true";
		}else {
			return "redirect:/member/memberList?removeSuccess=false";
		}
	}
	
}//end calss

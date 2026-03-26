package net.koreate.cinema.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.koreate.cinema.repositories.MemberDAO;
import net.koreate.cinema.vo.MemberVO;

@Service
public class MemberService {
	
	@Autowired
	private MemberDAO memberDAO;
	
	public void insertMember(MemberVO member) {
		memberDAO.insertMember(member);
	}
	
	public MemberVO loginMember(MemberVO member) {
		return memberDAO.readMemberWithPass(member.getId(), member.getPass());
		
	}

}

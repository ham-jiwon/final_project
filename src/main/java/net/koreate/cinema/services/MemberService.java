package net.koreate.cinema.services;

import java.util.List;

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
	
	public int idCheck(String id){
		int result = memberDAO.idCheck(id);
		return result;
	}
	
	
	public MemberVO loginMember(MemberVO member) {
		return memberDAO.readMemberWithPass(member.getId(), member.getPass());
		
	}
	
	public int updateMember(MemberVO member) {
		int result = memberDAO.updateMember(member);
		return result;
	}
	
	public int removeMember(int num) {
		int result = memberDAO.removeMember(num);
		return result;
	}//end removeeMember()

	public List<MemberVO> readMemberList(){
		List<MemberVO> list = memberDAO.readMemberList();
		return list;
	}
	
	
	
	
	
	
	
}//end class

package net.koreate.cinema.repositories;

import java.util.List;

import net.koreate.cinema.vo.MemberVO;

public interface MemberDAO {
	
	/**
	 * @param member - final_member 테이블에 저장할 사용자 정보를 저장하는 MemberVO 객체
	 * @return int - final_member 테이블에 회원 정보 삽입 후 삽입된 행 개수 반환
	 */
	int insertUser(MemberVO member);

	
	/**
	 * @param memberid  - 검색할 사용자 아이디 문자열
	 * @return MemberVO - 아이디가 일치하는 검색된 한 명의 회원 정보를 저장하는 객체
	 * 				 	- 일치하는 사용자가 없을 경우 null
	 */
	MemberVO readMember(String memberid);
	
	
	/**
	 * 
	 * @param memberid - 검색할 사용자 아이디
	 * @param memberpw - 검색할 사용자 비밀번호
	 * @return - 아이디와 비밀번호가 일치하는 한 명의 사용자 반환
	 * 		   - 일치하는 사용자가 없을 경우 : null
	 */
	MemberVO readMemberWithPass(String memberid, String memberpw);
	
	
	/**
	 * @return - final_member table 에 등록된 모든 사용자 정보를 List 타입으로 반환
	 */
	List<MemberVO> readMemberList();
	
	
	/**
	 * @param num - 삭제할 회원 번호
	 * @return - 삭제된 행의 개수
	 */
	int removeMember(int num);
	
	
}//end interface

package net.koreate.cinema.repositories;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.koreate.cinema.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSession session;
	
	@Override
	public int insertMember(MemberVO member) {
		int result = session.insert("MemberMapper.insertMember", member);
		return result;
	}

	@Override
	public MemberVO readMember(String memberid) {
		return null;
	}

	@Override
	public MemberVO readMemberWithPass(String memberid, String memberpw) {
		Map<String, Object> map = new HashMap<>();
		map.put("id", memberid);
		map.put("pass", memberpw);
		MemberVO member = session.selectOne("MemberMapper.readMemberWithPass", map);
		return member;
	}

	@Override
	public List<MemberVO> readMemberList() {
		return null;
	}

	@Override
	public int removeMember(int num) {
		return 0;
	}

}

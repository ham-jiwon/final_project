package net.koreate.cinema.repositories;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.koreate.cinema.vo.BranchVO;
import net.koreate.cinema.vo.MovieVO;
import net.koreate.cinema.vo.ScheduleVO;
import net.koreate.cinema.vo.TheaterVO;

@Repository
public class TheaterDAOImpl implements TheaterDAO {

	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<TheaterVO> theaterList() {
		List<TheaterVO> list = session.selectList("TheaterMapper.theaterList");
		return list;
	}

	@Override
	public List<BranchVO> branchList(int theaterCode) {
		List<BranchVO> list = session.selectList("TheaterMapper.branchList", theaterCode);
		return list;
	}

	@Override
	public List<MovieVO> movieByBranch(int branchCode) {
		List<MovieVO> list = session.selectList("TheaterMapper.movieByBranch", branchCode);
		return list;
	}

	@Override
	public List<ScheduleVO> scheduleByMovie(int branchCode, int movieCode) {
		Map<String, Integer> map = new HashMap<>();
		map.put("branchCode", branchCode);
		map.put("movieCode", movieCode);
		List<ScheduleVO>list = session.selectList("TheaterMapper.scheduleByMovie", map);
		return list;
	}

}

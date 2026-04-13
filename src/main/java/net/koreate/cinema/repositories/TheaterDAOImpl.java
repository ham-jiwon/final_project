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
import net.koreate.cinema.vo.ScreenVO;
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
	
	@Override
	public List<ScheduleVO> scheduleByDate(int branchCode, int movieCode, String date){
		Map<String, Object> map = new HashMap<>();
		map.put("branchCode", branchCode);
		map.put("movieCode", movieCode);
		map.put("date", date);
		List<ScheduleVO> list = session.selectList("TheaterMapper.scheduleByDate", map);
		return list;
	}

	@Override
	public List<ScreenVO> screenByBranch(int branchCode) {
		List<ScreenVO> list = session.selectList("TheaterMapper.screenByBranch", branchCode);
		return list;
	}

	@Override
	public void insertSchedule(ScheduleVO vo) {
		session.insert("TheaterMapper.insertSchedule", vo);
	}

	
	@Override
	public List<ScheduleVO> scheduleList(int branchCode, String date) {
		Map<String, Object> map = new HashMap<>();
		map.put("branchCode", branchCode);
	    map.put("date", date);
		List<ScheduleVO> list = session.selectList("TheaterMapper.scheduleList", map);
		return list;
	}

	@Override
	public void deleteSchedule(int scheduleCode) {
		session.delete("TheaterMapper.deleteSchedule", scheduleCode);
		
	}

	@Override
	public ScheduleVO getSchedule(int scheduleCode) {
		ScheduleVO sc = session.selectOne("TheaterMapper.getSchedule", scheduleCode);
		return sc;
	}

	@Override
	public void updateSchedule(ScheduleVO vo) {
		session.update("TheaterMapper.updateSchedule", vo);
	}

}

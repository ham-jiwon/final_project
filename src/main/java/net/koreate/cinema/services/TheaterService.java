package net.koreate.cinema.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.koreate.cinema.repositories.TheaterDAO;
import net.koreate.cinema.vo.BranchVO;
import net.koreate.cinema.vo.MovieVO;
import net.koreate.cinema.vo.ScheduleVO;
import net.koreate.cinema.vo.ScreenVO;
import net.koreate.cinema.vo.TheaterVO;

@Service
public class TheaterService {
	
	@Autowired
	private TheaterDAO theaterDAO;
	
	public List<TheaterVO> theaterList(){
		List<TheaterVO>list = theaterDAO.theaterList();
		return list;
	}
	
	public List<BranchVO> branchList(int theaterCode){
		List<BranchVO>list = theaterDAO.branchList(theaterCode);
		return list;
	}
	
	public List<MovieVO> movieByBranch(int branchCode){
		List<MovieVO> list = theaterDAO.movieByBranch(branchCode);
		return list;
	}
	
	public List<ScheduleVO> scheduleBymovie(int branchCode, int movieCode){
		List<ScheduleVO> list = theaterDAO.scheduleByMovie(branchCode, movieCode);
		return list;
	}
	
	public List<ScheduleVO> scheduleByDate(int branchCode, int movieCode, String date){
		List<ScheduleVO> list = theaterDAO.scheduleByDate(branchCode, movieCode, date);
		return list;
	}
	
	public List<ScreenVO> screenByBranch(int branchCode){
		List<ScreenVO> list = theaterDAO.screenByBranch(branchCode);
		return list;
	}
	
	public void insertSchedule(ScheduleVO vo){
	    theaterDAO.insertSchedule(vo);
	}
	
	public List<ScheduleVO> scheduleList(int branchCode, String date) {
	    return theaterDAO.scheduleList(branchCode, date);
	}

	public void deleteSchedule(int scheduleCode) {
	    theaterDAO.deleteSchedule(scheduleCode);
	}

	public ScheduleVO getSchedule(int scheduleCode) {
	    return theaterDAO.getSchedule(scheduleCode);
	}

	public void updateSchedule(ScheduleVO vo) {
	    theaterDAO.updateSchedule(vo);
	}
	
	
	
}//end TherterService

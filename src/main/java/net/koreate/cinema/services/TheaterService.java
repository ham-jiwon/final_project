package net.koreate.cinema.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.koreate.cinema.repositories.TheaterDAO;
import net.koreate.cinema.vo.BranchVO;
import net.koreate.cinema.vo.MovieVO;
import net.koreate.cinema.vo.ScheduleVO;
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
	
	public List<MovieVO> moviByBranch(int branchCode){
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
	
}//end TherterService

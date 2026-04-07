package net.koreate.cinema.repositories;

import java.util.List;

import net.koreate.cinema.vo.BranchVO;
import net.koreate.cinema.vo.MovieVO;
import net.koreate.cinema.vo.ScheduleVO;
import net.koreate.cinema.vo.TheaterVO;

public interface TheaterDAO {
	
	/**
	 * @return - 영화관 종류를 List로 반환 <br>
	 * 		   - CGV, 메가박스, 롯데시네마 
	 */
	List<TheaterVO> theaterList();
	
	
	/**
	 * 
	 * @param TheaterCode - 영화관 종류(CGV 등)
	 * @return - 해당 영화관의 지점 리스트 반환
	 */
	List<BranchVO> branchList(int theaterCode);
	
	
	/**
	 * 
	 * @param branchCode - 해당 영화관 지점 코드
	 * @return - 해당 영화관의 해당 지점에서 상영중인 영화 리스트 반환
	 */
	List<MovieVO> movieByBranch(int branchCode);
	
	
	/**
	 * 
	 * @param branchCode - 영화관의 지점 코드
	 * @param movieCode - 영화 코드
	 * @return - 해당 지점에서 상영중인 해당 영화의  스케쥴 리스트 반환
	 */
	List<ScheduleVO> scheduleByMovie(int branchCode, int movieCode);
	
}//end TheaterDAO

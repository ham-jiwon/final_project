package net.koreate.cinema.repositories;

import java.util.List;

import net.koreate.cinema.vo.BranchVO;
import net.koreate.cinema.vo.MovieVO;
import net.koreate.cinema.vo.ScheduleVO;
import net.koreate.cinema.vo.ScreenVO;
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
	
	
	/**
	 * 
	 * @param branchCode - 영화관의 지점 코드
	 * @param movieCode - 영화 코드
	 * @param date - 문자열 타입의 날짜
	 * @return - 해당 날짜의 해당 지점에서 상영중인 영화의 스케줄 리스트 반환
	 */
	List<ScheduleVO> scheduleByDate(int branchCode, int movieCode, String date);
	
	/**
	 * 
	 * @param branchCode - 영화관 지점 코드
	 * @return - 해당 지점의 상영관 목록 리스트 반환
	 */
	List<ScreenVO> screenByBranch(int branchCode);
	
	/**
	 * 
	 * @param vo - 삽입할 스케줄 객체
	 */
	void insertSchedule(ScheduleVO vo);
	
	
	/**
	 * 
	 * @param branchCode - 해당 지점 코드
	 * @param date - 해당 날짜
	 * @return - 해당 날짜 해당 지점의 상영 일정 리스트 반환
	 */
	public List<ScheduleVO> scheduleList(int branchCode, String date);

	
	/**
	 * @param scheduleCode - 삭제할 스케줄 코드
	 */
	public void deleteSchedule(int scheduleCode);

	/**
	 * @param scheduleCode - 스케줄 코드 입력
	 * @return - 해당 스케줄 객체 반환
	 */
	public ScheduleVO getSchedule(int scheduleCode);

	
	/**
	 * @param vo - 수정할 스케줄 코드 입력
	 */
	public void updateSchedule(ScheduleVO vo);
	
}//end TheaterDAO

package net.koreate.cinema.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ScheduleVO {
	private int scheduleCode;
	private int movieCode;
	private int screenCode;
	private Date startTime;
	private Date endTime;
	
	// join 용
	private String movieTitle;
	private String screenName;
	private String screenType;
}//end ScheduleVO

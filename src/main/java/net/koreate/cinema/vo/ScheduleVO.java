package net.koreate.cinema.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ScheduleVO {
	private int schedule_code;
	private int movie_code;
	private int screen_code;
	private Date start_time;
	private Date end_time;
	
	// join 용
	private String movie_title;
	private String screen_name;
	private String screen_type;
}//end ScheduleVO

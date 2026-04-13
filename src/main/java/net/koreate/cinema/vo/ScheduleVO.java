package net.koreate.cinema.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ScheduleVO {
	private int schedule_code;
	private int movie_code;
	private int screen_code;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private Date start_time;
	
	private Date end_time;
	
	// join 용
	private String movie_title;
	private String screen_name;
	private String screen_type;
}//end ScheduleVO

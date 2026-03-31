package net.koreate.cinema.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MovieVO {
    private int movie_code;
    private String title;
    private String director;
    private String genre;
    private Date release_date;
    private int age_limit;
    private String story;
    private int running_time;
    private String poster; 
}

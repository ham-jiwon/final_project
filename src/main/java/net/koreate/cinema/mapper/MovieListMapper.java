package net.koreate.cinema.mapper;

import java.util.List;

import net.koreate.cinema.vo.MovieVO;

public interface MovieListMapper {
	List<MovieVO> selectMovieList();
	
	MovieVO getMovie(int movie_id);

	void deleteMovie(int movie_id);	
	
}

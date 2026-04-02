package net.koreate.cinema.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.koreate.cinema.mapper.MovieListMapper;
import net.koreate.cinema.vo.MovieVO;

@Service
public class MovieListService {

	@Autowired
    private MovieListMapper mapper;

    public List<MovieVO> getList(){
        return mapper.selectMovieList();
    
	}
	
}

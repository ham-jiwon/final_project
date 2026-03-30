package net.koreate.cinema.mapper;

import java.util.List;

import net.koreate.cinema.vo.MovieVO;

public interface MovieMapper {

    List<MovieVO> list();

    void insert(MovieVO vo);

    MovieVO read(int movie_code);

    void update(MovieVO vo);

    void delete(int movie_code);
}

package net.koreate.cinema.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.koreate.cinema.mapper.MovieMapper;
import net.koreate.cinema.vo.MovieVO;

@Service
public class MovieService {

    @Autowired
    private MovieMapper mapper;

    // 목록
    public List<MovieVO> list() {
        return mapper.list();
    }

    // 등록
    public void insert(MovieVO vo) {
        mapper.insert(vo);
    }

    // 상세보기
    public MovieVO read(int movie_code) {
        return mapper.read(movie_code);
    }

    // 삭제
    public void delete(int movie_code) {
        mapper.delete(movie_code);
    }
}
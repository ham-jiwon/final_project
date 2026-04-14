package net.koreate.cinema.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.koreate.cinema.mapper.CommentMapper;
import net.koreate.cinema.utils.DBUtil;
import net.koreate.cinema.vo.CommentVO;

@Service
public class CommentService {
	
	@Autowired
    private CommentMapper mapper;

    public void writeComment(CommentVO vo) {
        mapper.insertComment(vo);
    }
    
    public List<CommentVO> getComments(int movie_code){
        return mapper.selectComments(movie_code);
    }

    public void deleteComment(int comment_num){
        mapper.deleteComment(comment_num);
    }

    public void updateComment(CommentVO vo){
        mapper.updateComment(vo);
    }
    
    public List<Integer> getRatings(int movie_code){
    	return mapper.selectRatings(movie_code);
    }
    
    public CommentVO getCommentById(int comment_num){
        return mapper.selectCommentById(comment_num);
    }   
    
}

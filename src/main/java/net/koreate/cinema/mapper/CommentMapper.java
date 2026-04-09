package net.koreate.cinema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import net.koreate.cinema.vo.CommentVO;

@Mapper
public interface CommentMapper {

    void insertComment(CommentVO vo);
    
    List<CommentVO> selectComments(int movie_code);
    
    List<Integer> selectRatings(int movie_code);
    
    void deleteComment(int comment_num);
    
    void updateComment(CommentVO vo);
	
}

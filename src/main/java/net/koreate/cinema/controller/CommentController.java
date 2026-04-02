package net.koreate.cinema.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import net.koreate.cinema.services.CommentService;
import net.koreate.cinema.vo.CommentVO;



@RestController
@RequestMapping("/comment")
public class CommentController {
	
	@Autowired
	private CommentService commentService;

	@PostMapping("/write")
    public String writeComment(
            @RequestParam String member_id,
            @RequestParam int movie_code,
            @RequestParam String content,
            @RequestParam int score
        ) {
            System.out.println(member_id);
            System.out.println(movie_code);
            System.out.println(content);
            System.out.println(score);
            
            CommentVO vo = new CommentVO();
            vo.setMember_id(member_id);
            vo.setMovie_code(movie_code);
            vo.setContent(content);
            vo.setScore(score);

            commentService.writeComment(vo);

            return "ok";
        }
	
	@GetMapping(value = "/list", produces="application/json; charset=UTF-8")
	public List<CommentVO> list(@RequestParam int movie_code){

	    System.out.println("list 진입");
	    System.out.println("댓글 조회 movie_code : " + movie_code);

	    return commentService.getComments(movie_code);
	}	
	
	@PostMapping("/update")
	public String update(
	    @RequestParam int comment_num,
	    @RequestParam String content,
	    @RequestParam int score
	){
	    CommentVO vo = new CommentVO();
	    vo.setComment_num(comment_num);
	    vo.setContent(content);
	    vo.setScore(score);

	    commentService.updateComment(vo);

	    return "ok";
	}	
	
	@PostMapping("/delete")
	public String delete(@RequestParam int comment_num){
	    commentService.deleteComment(comment_num);
	    return "ok";
	}
}

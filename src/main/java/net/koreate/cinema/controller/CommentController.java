package net.koreate.cinema.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import net.koreate.cinema.services.CommentService;
import net.koreate.cinema.vo.CommentVO;
import net.koreate.cinema.vo.MemberVO;



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

            return "redirect:/movieDetail?code=" + movie_code;
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
	    @RequestParam int score,
	    HttpSession session
	){
	    String loginId = ((MemberVO)session.getAttribute("loginMember")).getId();

	    CommentVO comment = commentService.getCommentById(comment_num);		
		
	    if(loginId.equals(comment.getMember_id()) || loginId.equals("admin")){		
		    CommentVO vo = new CommentVO();
		    vo.setComment_num(comment_num);
		    vo.setContent(content);
		    vo.setScore(score);
		    
	        commentService.updateComment(vo);
	        return "ok";		    
	    } else {
	        return "fail";
	    }
	}	
	
	@PostMapping("/delete")
	public String delete(@RequestParam int comment_num, HttpSession session){
		
	    String loginId = ((MemberVO)session.getAttribute("loginMember")).getId();

	    CommentVO comment = commentService.getCommentById(comment_num);
	    
	    if(loginId.equals(comment.getMember_id()) || loginId.equals("admin")){
	        commentService.deleteComment(comment_num);
	    return "ok";
	    } else {
	        return "fail";
	    }
	}
	
	@GetMapping("/rating")
	@ResponseBody
	public Map<String, Object> getRating(int movie_code){

	    List<Integer> ratings = commentService.getRatings(movie_code);

	    Map<Integer, Integer> ratingMap = new HashMap<>();

	    for(int i=1; i<=5; i++){
	        ratingMap.put(i, 0);
	    }

	    for(int r : ratings){
	        ratingMap.put(r, ratingMap.get(r) + 1);
	    }

	    double avg = ratings.stream().mapToInt(i->i).average().orElse(0);

	    Map<String, Object> result = new HashMap<>();
	    result.put("avg", avg);
	    result.put("count", ratings.size());
	    result.put("map", ratingMap);

	    return result;
	}	
	
} // end class

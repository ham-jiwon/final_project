package net.koreate.cinema.vo;

import lombok.Data;

@Data
public class CommentVO {

    private int comment_num;   // 댓글 번호
    private String member_id;  // 작성자
    private String nickname;  // 닉네임
    private int movie_code;    // 영화 코드
    private String content;    // 내용
    private int score;         // 별점	
	
}

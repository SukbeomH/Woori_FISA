package com.example.demo.model.dto;

import com.example.demo.model.entity.Board;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class BoardDto {

    private int no;
    private String title;
    private String content;
    private String imagePath;
    private String user_id;

    public Board toEntity() {
        Board board = new Board();
        board.setNo(this.getNo());
        board.setTitle(this.getTitle());
        board.setContent(this.getContent());
        board.setImagePath(this.getImagePath());
        return board;
    }
}

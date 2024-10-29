package com.example.demo.service;

import com.example.demo.model.dto.BoardDto;
import com.example.demo.model.entity.Board;
import com.example.demo.model.entity.User;
import com.example.demo.repository.BoardRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.stereotype.Service;

@Service
public class BoardService {

    private BoardRepository brepo;
    private UserRepository urepo;
 
    // 생성자
    public BoardService(BoardRepository brepo, UserRepository urepo) {
        this.brepo = brepo;
        this.urepo = urepo;
    }
    
    // 쓰기
    public void registBoard(BoardDto dto){
        String userId = dto.getUser_id();
        User user = urepo.getReferenceById(userId); // User의 정보를 UserRepository에서 id를 가지고 끌어옵니다.
        Board board = dto.toEntity();
        board.setUser(user);
        brepo.save(board);
    }
    
    // 읽기
    
    // 1. 전체 목록 읽기 
    
    // 2. 특정 값 읽기  {no} 
    
    // 삭제
    
    // 수정
    
}

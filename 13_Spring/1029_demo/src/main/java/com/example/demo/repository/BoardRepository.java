package com.example.demo.repository;

import com.example.demo.model.entity.Board;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository                                               // entity명, 그 entity의 Id의 자료형
public interface BoardRepository extends JpaRepository<Board, Integer> {
    // Spring data jpa가 간단한 CRUD를 구현해준다
}

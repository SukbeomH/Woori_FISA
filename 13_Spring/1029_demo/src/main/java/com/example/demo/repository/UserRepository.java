package com.example.demo.repository;

import com.example.demo.model.entity.Board;
import com.example.demo.model.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

// entity명, 그 entity의 Id의 자료형
@Repository
public interface UserRepository extends JpaRepository<User, String> {
// Spring data jpa가 간단한 CRUD를 구현해준다
}

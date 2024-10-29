package com.example.demo.model.entity;


import com.example.demo.model.dto.UserDto;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.*;

import java.util.List;

// User 와 Board 에 필요한 최소 속성
// 하나의 글은 하나의 사용자를 가집니다.
// 한명의 사용자는 여러개의 글을 쓸 수 있습니다.

@NoArgsConstructor
@AllArgsConstructor
@Data  // Required 생성자만 지원
@Entity
@Builder
public class User {
    // 사용자 id, 사용자 이름, 사용자 비번, 사용자 등급

    @Id  // id가 PK
    private String id;
    private String name;
    private String pass;
    private String grade;

    @OneToMany(mappedBy = "user") // Board 클래스 기준으로 User 매핑
    List<Board> boards;

    // entity -> dto로 데이터를 넘기기 위한 메서드 작성
    public UserDto toDto() {
        UserDto dto = new UserDto();
        dto.setId(this.getId());
        dto.setName(this.getName());
        dto.setPass(this.getPass());
        dto.setGrade(this.getGrade());
        return dto;
    }
}

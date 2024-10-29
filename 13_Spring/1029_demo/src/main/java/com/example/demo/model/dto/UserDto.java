package com.example.demo.model.dto;

import com.example.demo.model.entity.Board;
import com.example.demo.model.entity.User;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserDto {

    private String id;
    private String name;
    private String pass;
    private String grade;

    // Dto -> Entity로 데이터를 전송하는 toEntity()
    public User toEntity() {
        User user = new User();
        user.setId(this.getId());
        user.setName(this.getName());
        user.setPass(this.getPass());
        user.setGrade(this.getGrade());
        return user;
    }
}

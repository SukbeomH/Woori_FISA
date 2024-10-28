package com.example.book.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Entity  // 테이블 생성, 각각의 필드들을 하나의 book 로 묶는 DTO의 역할
@Table(name="books") // 테이블명이 db에서 다르게 매핑할 때
public class Book {
    // 책번호
    @Id // pk
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto Crement
    private Long id;

    // 가격, 제목, 작가, 장르, 페이지
    @Column(nullable = true)
    private Long price;

    @Column(nullable = false)
    private String title;
    private String author;
    private String genre;
    private int page;

    @Column(nullable = false, updatable = false) // 처음 들어온 값을 변경할 수 없는 final 상태
    private LocalDateTime createdAt = LocalDateTime.now();

    private LocalDateTime updatedAt = LocalDateTime.now();

}

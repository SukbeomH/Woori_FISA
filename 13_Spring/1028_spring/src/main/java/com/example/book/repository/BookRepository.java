package com.example.book.repository;

import com.example.book.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

//               엔티티        필드
// select * from 테이블 where 컬럼=값;         <엔터티, PK>
public interface BookRepository extends JpaRepository<Book, Long> {
    List<Book> findByTitleAndAuthor(String title, String author);

    List<Book> findByTitleContaining(String title);

    // 전체 책 목록 조회 - findAll()

    // 특정 책만 내용 전체 조회

    // 수정, 삽입, 삭제

    // 특정책을 이름과 저자로 조회

}

package com.example.book.controller;

import com.example.book.model.Book;
import com.example.book.service.BookService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

//@Controller
@RestController
@RequestMapping("/books")
public class BookController {
    // 다음 계층으로 요청을 실어나르기 위한 service 객체
    private BookService bookService;

    // Controller 생성자 작성
    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping
    public List<Book> getAllBooks() {
        return bookService.getAllBooks();
    }

    @PostMapping // @RequestBody : body에 실려서 오는 데이터를 인자로 받겠음.
    public Book saveBook(@RequestBody Book book) {
        return bookService.saveBook(book);
    }

    // Optional null 예외처리를 해주는 List 자료형
    @GetMapping("/{id}") // { } 로 동적 변수명을 감싸줍니다.
    public Optional<Book> getBookById(@PathVariable Long id) {
        return bookService.getBookById(id);
    }

    @DeleteMapping("/{id}") // { } 로 동적 변수명을 감싸줍니다.
    public void deleteBookById(@PathVariable Long id) {
        bookService.deleteBookById(id);
    }

    // 1. 전체 내용을 books 테이블에서 조회한다
    // 2. 클라이언트에게 requestBody로 입력받은 book의 전체 내용을 행에 모두 갈아끼운다 - 복잡...
    // 3. 그 결과를 service가 repository로 전달한다   - save(book)
    @PutMapping("/{id}") // { } 로 동적 변수명을 감싸줍니다.
    public void updateBookById(@PathVariable Long id, @RequestBody Book book) {
        book.setId(id);
        bookService.saveBook(book);
    }

    // 1. 전체 내용을 books 테이블에서 조회한다
    // 2. 클라이언트에게 requestBody로 입력받은 book의 특정 컬럼만 테이블의 행에 갈아끼운다
    // 3. 그 결과를 service가 repository로 전달한다.
    @PatchMapping("/{id}") // { } 로 동적 변수명을 감싸줍니다.
    public void update2BookById(@PathVariable Long id, @RequestBody Book book) {
        bookService.update2BookById(id, book);
    }

    @GetMapping("/select1")  // books/select?title=책이름&author= 저자
    public List<Book> getBookByTitleAndAuthor(@RequestParam String title, @RequestParam String author) {
        return bookService.getBookByTitleAndAuthor(title, author);
    }

    @GetMapping("/select2")  // books/select?title=책이름
    public List<Book> getBookByTitle(@RequestParam String title) {
        return bookService.getBookByTitle(title);
    }

}

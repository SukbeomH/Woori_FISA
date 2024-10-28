package com.example.book.service;

import com.example.book.model.Book;
import com.example.book.repository.BookRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service  // SpringBoot가 비즈니스로직을 관리하는 Service 로 Bean을 등록하고 필요할 때 찾아옴
public class BookService {

    private BookRepository bookReposity;

    public BookService (BookRepository bookReposity){
        this.bookReposity = bookReposity;
    }

    // 전체 책 목록을 조회
    public List<Book> getAllBooks() {
        return bookReposity.findAll(); // findAll은 우리가 선언한 적 없지만 JPARepository에 만들어져 있습니다.
    }

    public Book saveBook(Book book) {
        return bookReposity.save(book); // save는 우리가 선언한 적 없지만 JpaRepository에 있음
    }

    public Optional<Book> getBookById(Long id) {
        return bookReposity.findById(id);
    }

    public void deleteBookById(Long id) {
        bookReposity.deleteById(id);
    }




    public Book update2BookById(Long id, Book book) {
        // 1. 전체 내용을 books 테이블에서 조회한다 @PathVariable id로
        Book existingBook = bookReposity.findById(id).orElse(null);

        // 2. 클라이언트에게 requestBody로 입력받은 book의 특정 컬럼만 테이블의 행에 갈아끼운다
        if (book.getTitle() != null) {
            // 책이름이 기존과 다르면 책이름 변경
            existingBook.setTitle(book.getTitle());
        } else if (book.getAuthor() != null) {
            // 작가가 기존과 다른 작가 변경
            existingBook.setTitle(book.getAuthor());
        } else if (book.getPage() != 0){
            // 기존 page와 일치하면 그대로 두고 아니면 변경
            existingBook.setPage(book.getPage());
        }
        // 3. 그 결과를 service가 repository로 전달한다.
         return bookReposity.save(existingBook);
    }

    public List<Book> getBookByTitleAndAuthor(String title, String author) {
        return bookReposity.findByTitleAndAuthor(title, author);
    }

    public List<Book> getBookByTitle(String title) {
        return bookReposity.findByTitleContaining(title);
    }
}


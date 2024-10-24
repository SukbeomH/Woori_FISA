package com.sukbeom.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/book")
public class BookController {
    @GetMapping // doGet 받아와서 overide - redirect / request.dispatcher(
    public String sayHello() {
        return "Hello, Spring Boot!";
    }
}

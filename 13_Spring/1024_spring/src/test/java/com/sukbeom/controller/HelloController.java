package com.sukbeom.controller;// controller/com.sukbeom.controller.HelloController.java

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController // RESTApi로 통신
@RequestMapping("/hello")   // @WebServlet("/hello)
public class HelloController {

    @GetMapping // doGet 받아와서 overide - redirect / request.dispatcher(
    public String sayHello() {
        return "Hello, Spring Boot!";
    }
}
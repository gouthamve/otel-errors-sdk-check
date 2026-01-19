package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@SpringBootApplication
@RestController
public class App {
    private static final Logger logger = LoggerFactory.getLogger(App.class);

    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }

    @GetMapping("/")
    public String hello() {
        return "Hello from Java Spring Boot!";
    }

    @GetMapping("/throw-error")
    public String error() {
        throw new RuntimeException("Intentional error from Java Spring Boot application");
    }

    @GetMapping("/manual-error")
    public String manualError() {
        try {
            throw new RuntimeException("Intentional error from Java Spring Boot application");
        } catch (RuntimeException e) {
            // that's what spring boot does under the hood when an unhandled exception is thrown from a controller
            logger.error("Caught an intentional error", e);
            return "we handled the error";
        }
    }
}

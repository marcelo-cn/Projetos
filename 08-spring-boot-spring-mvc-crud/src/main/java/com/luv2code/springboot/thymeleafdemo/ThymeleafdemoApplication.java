package com.luv2code.springboot.thymeleafdemo;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class ThymeleafdemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(ThymeleafdemoApplication.class, args);
	}
	
	@Bean
	public CommandLineRunner commandLinerunner(String[] arg) {
		return runner -> {
			System.out.println("Hello");
		};
	}

}

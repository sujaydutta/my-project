package com.sujay.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello() {
        return "Hello World!! Showcasing end to end build of docker image, push to Docker Hub and Deployment to Render!!!!!";
    }
}
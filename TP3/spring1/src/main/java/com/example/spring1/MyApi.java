package com.example.spring1;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController // Annotation pour dire que c'est un controller rest
public class MyApi {

    @GetMapping(value = "/b")
    public String bonjour() {
        return "Bonjour !";
    }

    @GetMapping(value = "/bn")
    public String bonsoir() {
        return "Bonsoir !";
    }

    @GetMapping(value = "/etudiant")
    public Etudiant getEtudiant() {
        return new Etudiant(1, "A", 19);
    }

    @GetMapping(value = "somme")
    public double somme(double a, double b) {
        return a+b;
    }

}

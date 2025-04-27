package com.example.spring1;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;


@RestController // Annotation pour dire que c'est un controller REST
public class MyApi {

    public static ArrayList<Etudiant> listEtudiant = new ArrayList<>();
    static {
        listEtudiant.add(new Etudiant(0, "A", 19));
        listEtudiant.add(new Etudiant(1, "B", 17));
        listEtudiant.add(new Etudiant(2, "C", 15));
        listEtudiant.add(new Etudiant(3, "D", 13));
    }
    
    @GetMapping(value = "/listEtudiant")
    public ArrayList<Etudiant> getAllEtudiant() {
        return listEtudiant;
    }

    @GetMapping(value = "/getEtudiant")
    public Etudiant getEtudiant(int identifiant) {
        return listEtudiant.get(identifiant);
    }

    @PostMapping(value = "/addEtudiant")
    public Etudiant addEtudiant(Etudiant etudiant) {
        listEtudiant.add(etudiant);
        return etudiant;
    }

    @DeleteMapping(value = "/deleteEtudiant")
    public void deleteEtudiant(int identifiant) {
        listEtudiant.remove(identifiant);
    }

    @PutMapping(value = "/updateEtudiant")
    public void UpdateEtudiant(int identifiant, String nom) {
        listEtudiant.get(identifiant).setNom(nom);
    }

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

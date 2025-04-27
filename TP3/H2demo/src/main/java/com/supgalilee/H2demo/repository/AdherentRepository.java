package com.supgalilee.H2demo.repository;
import com.supgalilee.H2demo.entities.Adherent;
import org.springframework.data.jpa.repository.JpaRepository;

// première paramètre => classe, deuxième paramètre => type de @Id
public interface AdherentRepository extends JpaRepository<Adherent, Long> {
}

package com.supgalilee.H2demo;
import com.supgalilee.H2demo.entities.Adherent;
import com.supgalilee.H2demo.repository.AdherentRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class H2demoApplication {

	public static void main(String[] args) {
		SpringApplication.run(H2demoApplication.class, args);
	}
	// @Bean Pour que la méthode runner soit exécutée
	@Bean
	CommandLineRunner runner(AdherentRepository repository) {
		return args -> {
			repository.save(new Adherent(null, "A", "Paris", 24));
			repository.save(new Adherent(null, "B", "Nîmes", 23));
			repository.save(new Adherent(null, "C", "Nantes", 22));
			repository.save(new Adherent(null, "D", "Toulouse", 21));
		};
	}
}

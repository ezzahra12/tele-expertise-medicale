
package model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "file_attente")
public class FileAttente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @Column(name = "date_ajout", nullable = false)
    private LocalDateTime dateAjout;

    @Column(nullable = false, length = 30)
    private String statut;

    public FileAttente() {
    }

    @PrePersist
    public void avantEnregistrement() {
        if (dateAjout == null) {
            dateAjout = LocalDateTime.now();
        }
        if (statut == null) {
            statut = "EN_ATTENTE";
        }
    }

    public Long getId() {
        return id;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public LocalDateTime getDateAjout() {
        return dateAjout;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }
}

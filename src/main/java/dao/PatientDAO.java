package dao;

import jakarta.persistence.EntityManager;
import model.Patient;
import util.JPAUtil;

import java.time.LocalDate;
import java.util.List;

public class PatientDAO {

    public void save(Patient patient) {

        EntityManager em = JPAUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            em.persist(patient);

            em.getTransaction().commit();

        } catch (Exception e) {

            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }

            e.printStackTrace();

        } finally {
            em.close();
        }
    }
    public List<Patient> rechercher(String recherche) {

        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.createQuery(
                            "SELECT p FROM Patient p WHERE p.nom LIKE :recherche " +
                                    "OR p.prenom LIKE :recherche " +
                                    "OR p.numeroSecuriteSociale LIKE :recherche",
                            Patient.class
                    ).setParameter("recherche", "%" + recherche + "%")
                    .getResultList();

        } finally {
            em.close();
        }
    }
    public Patient findById(Long id) {

        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.find(Patient.class, id);
        } finally {
            em.close();
        }
    }

    public List<Patient> findPatientsDuJour() {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.createQuery(
                            "SELECT p FROM Patient p " +
                                    "WHERE p.dateEnregistrement = :aujourdhui " +
                                    "ORDER BY p.heureArrivee ASC",
                            Patient.class
                    )
                    .setParameter("aujourdhui", LocalDate.now())
                    .getResultList();

        } finally {
            em.close();
        }
    }

}
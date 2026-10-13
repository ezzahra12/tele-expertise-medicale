
package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import model.FileAttente;
import model.Patient;
import util.JPAUtil;

import java.util.List;

public class FileAttenteDAO {

    public List<Patient> findPatientsDisponibles() {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.createQuery(
                            "SELECT p FROM Patient p " +
                                    "WHERE NOT EXISTS (" +
                                    "SELECT f.id FROM FileAttente f " +
                                    "WHERE f.patient = p AND f.statut = :statut" +
                                    ") ORDER BY p.nom, p.prenom",
                            Patient.class
                    )
                    .setParameter("statut", "EN_ATTENTE")
                    .getResultList();

        } finally {
            em.close();
        }
    }

    public List<FileAttente> findPatientsEnAttente() {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.createQuery(
                            "SELECT f FROM FileAttente f " +
                                    "JOIN FETCH f.patient p " +
                                    "WHERE f.statut = :statut " +
                                    "ORDER BY f.dateAjout ASC",
                            FileAttente.class
                    )
                    .setParameter("statut", "EN_ATTENTE")
                    .getResultList();

        } finally {
            em.close();
        }
    }

    public boolean ajouterPatient(Long patientId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            Patient patient = em.find(Patient.class, patientId);

            if (patient == null) {
                transaction.rollback();
                return false;
            }

            Long nombre = em.createQuery(
                            "SELECT COUNT(f) FROM FileAttente f " +
                                    "WHERE f.patient.id = :patientId " +
                                    "AND f.statut = :statut",
                            Long.class
                    )
                    .setParameter("patientId", patientId)
                    .setParameter("statut", "EN_ATTENTE")
                    .getSingleResult();

            if (nombre > 0) {
                transaction.rollback();
                return false;
            }

            FileAttente entree = new FileAttente();
            entree.setPatient(patient);
            entree.setStatut("EN_ATTENTE");

            em.persist(entree);
            transaction.commit();

            return true;

        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException(
                    "Erreur lors de l'ajout à la file d'attente.", e
            );

        } finally {
            em.close();
        }
    }
}

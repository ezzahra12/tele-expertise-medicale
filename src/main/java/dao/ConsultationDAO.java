
package dao;

import jakarta.persistence.EntityManager;
import model.Consultation;
import util.JPAUtil;

import java.util.List;

public class ConsultationDAO {

    public void save(Consultation consultation) {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            em.persist(consultation);

            em.getTransaction().commit();

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }

            throw new RuntimeException(
                    "Erreur lors de l'enregistrement de la consultation", e
            );
        } finally {
            em.close();
        }
    }

    public Consultation findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.find(Consultation.class, id);
        } finally {
            em.close();
        }
    }

    public List<Consultation> findByPatientId(Long patientId) {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.createQuery(
                            "SELECT c FROM Consultation c " +
                                    "WHERE c.patient.id = :patientId " +
                                    "ORDER BY c.dateConsultation DESC",
                            Consultation.class
                    )
                    .setParameter("patientId", patientId)
                    .getResultList();

        } finally {
            em.close();
        }
    }


    public List<Consultation> findAll() {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.createQuery(
                    "SELECT c FROM Consultation c " +
                            "JOIN FETCH c.patient " +
                            "ORDER BY c.dateConsultation DESC",
                    Consultation.class
            ).getResultList();
        } finally {
            em.close();
        }
    }


}

package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import model.SigneVital;
import util.JPAUtil;

import java.util.List;

public class SigneVitalDAO {

    public void save(SigneVital signeVital) {

        EntityManager em = JPAUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            em.persist(signeVital);

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

        public List<SigneVital> findByPatientId(Long patientId) {
            EntityManager em = JPAUtil.getEntityManager();

            try {
                TypedQuery<SigneVital> query = em.createQuery(
                        "SELECT s FROM SigneVital s " +
                                "WHERE s.patient.id = :patientId " +
                                "ORDER BY s.dateMesure DESC",
                        SigneVital.class
                );

                query.setParameter("patientId", patientId);

                return query.getResultList();

            } finally {
                em.close();
            }
        }
    }


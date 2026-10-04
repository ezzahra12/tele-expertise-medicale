package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import model.User;
import util.JPAUtil;

public class UserDAO {

    public User findByEmail(String email) {

        EntityManager em = JPAUtil.getEntityManager();

        try {
            return em.createQuery(
                            "SELECT u FROM User u WHERE u.email = :email",
                            User.class
                    )
                    .setParameter("email", email)
                    .getSingleResult();

        } catch (NoResultException e) {
            return null;

        } finally {
            em.close();
        }
    }
}
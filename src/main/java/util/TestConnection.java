package util;

import jakarta.persistence.EntityManager;

public class TestConnection {

    public static void main(String[] args) {

        EntityManager em = null;

        try {
            em = JPAUtil.getEntityManager();

            System.out.println("Connexion Hibernate réussie !");
            System.out.println("User entity جاهزة !");

        } catch (Exception e) {

            System.out.println("Erreur !");
            e.printStackTrace();

        } finally {

            if (em != null) {
                em.close();
            }
        }
    }
}
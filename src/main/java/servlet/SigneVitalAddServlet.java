
        package servlet;

import dao.PatientDAO;
import dao.SigneVitalDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Patient;
import model.SigneVital;

import java.io.IOException;

@WebServlet("/signe-vital/add")
public class SigneVitalAddServlet extends HttpServlet {

    private final PatientDAO patientDAO = new PatientDAO();
    private final SigneVitalDAO signeVitalDAO = new SigneVitalDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            // 1. Récupérer et vérifier l'identifiant du patient
            String patientIdParam = request.getParameter("patientId");

            if (patientIdParam == null || patientIdParam.isBlank()) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "ID du patient manquant."
                );
                return;
            }

            Long patientId;

            try {
                patientId = Long.parseLong(patientIdParam.trim());
            } catch (NumberFormatException e) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "ID du patient invalide. Vérifiez le formulaire."
                );
                return;
            }

            Patient patient = patientDAO.findById(patientId);

            if (patient == null) {
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Patient introuvable."
                );
                return;
            }

            // 2. Créer l'objet SigneVital
            SigneVital signeVital = new SigneVital();
            signeVital.setPatient(patient);

            String tension = request.getParameter("tension");
            if (tension != null && !tension.isBlank()) {
                signeVital.setTension(tension.trim());
            }

            // 3. Récupérer les valeurs numériques
            String frequenceCardiaque =
                    request.getParameter("frequenceCardiaque");

            if (frequenceCardiaque != null
                    && !frequenceCardiaque.isBlank()) {
                signeVital.setFrequenceCardiaque(
                        Integer.parseInt(frequenceCardiaque.trim())
                );
            }

            String temperature = request.getParameter("temperature");
            if (temperature != null && !temperature.isBlank()) {
                signeVital.setTemperature(lireDouble(temperature));
            }

            String frequenceRespiratoire =
                    request.getParameter("frequenceRespiratoire");

            if (frequenceRespiratoire != null
                    && !frequenceRespiratoire.isBlank()) {
                signeVital.setFrequenceRespiratoire(
                        Integer.parseInt(frequenceRespiratoire.trim())
                );
            }

            String poids = request.getParameter("poids");
            if (poids != null && !poids.isBlank()) {
                signeVital.setPoids(lireDouble(poids));
            }

            String taille = request.getParameter("taille");
            if (taille != null && !taille.isBlank()) {
                signeVital.setTaille(lireDouble(taille));
            }

            // 4. Vérifier si au moins une valeur est renseignée
            boolean valeursRenseignees =
                    (signeVital.getTension() != null
                            && !signeVital.getTension().isBlank())
                            || signeVital.getFrequenceCardiaque() != null
                            || signeVital.getTemperature() != null
                            || signeVital.getFrequenceRespiratoire() != null
                            || signeVital.getPoids() != null
                            || signeVital.getTaille() != null;

            // 5. Enregistrer uniquement si une valeur existe
            if (valeursRenseignees) {
                signeVitalDAO.save(signeVital);
            }

            // 6. Retourner au dashboard infirmier
            response.sendRedirect(
                    request.getContextPath()
                            + "/infirmier/dashboard.jsp"
            );

        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Une valeur numérique est invalide. "
                            + "Vérifiez la fréquence cardiaque, "
                            + "la fréquence respiratoire, "
                            + "la température, le poids et la taille."
            );
        } catch (Exception e) {
            throw new ServletException(
                    "Erreur lors du traitement des signes vitaux.", e
            );
        }
    }

    // Accepter les décimales avec un point ou une virgule
    private Double lireDouble(String valeur) {
        if (valeur == null || valeur.isBlank()) {
            return null;
        }

        return Double.parseDouble(
                valeur.trim().replace(',', '.')
        );
    }
}

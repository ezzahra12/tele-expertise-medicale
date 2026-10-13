package servlet;

import dao.PatientDAO;
import model.Patient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet("/patient/add")
public class PatientServlet extends HttpServlet {

    private PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String dateNaissance = request.getParameter("dateNaissance");
        String numeroSecuriteSociale =
                request.getParameter("numeroSecuriteSociale");
        String telephone = request.getParameter("telephone");
        String adresse = request.getParameter("adresse");

        Patient patient = new Patient();

        patient.setNom(nom);
        patient.setPrenom(prenom);

        if (dateNaissance != null && !dateNaissance.isEmpty()) {
            patient.setDateNaissance(
                    LocalDate.parse(dateNaissance)
            );
        }

        patient.setNumeroSecuriteSociale(numeroSecuriteSociale);
        patient.setTelephone(telephone);
        patient.setAdresse(adresse);

        patient.setDateEnregistrement(LocalDate.now());
        patient.setHeureArrivee(LocalTime.now());

        patientDAO.save(patient);

        // Après l'enregistrement du patient
        response.sendRedirect(
                request.getContextPath()
                        + "/patient/signes-vital?id=" + patient.getId()
        );
    }
}
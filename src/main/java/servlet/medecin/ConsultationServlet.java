
package servlet.medecin;

import dao.ConsultationDAO;
import dao.PatientDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Consultation;
import model.Patient;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/generaliste/consultation/creer")
public class ConsultationServlet extends HttpServlet {

    private final PatientDAO patientDAO = new PatientDAO();
    private final ConsultationDAO consultationDAO = new ConsultationDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<Patient> patients = patientDAO.rechercher("");

        request.setAttribute("patients", patients);

        request.getRequestDispatcher(
                "/generaliste/creer-consultation.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String patientIdParam = request.getParameter("patientId");
        String motif = request.getParameter("motif");
        String observations = request.getParameter("observations");

        if (patientIdParam == null || patientIdParam.isBlank()
                || motif == null || motif.isBlank()) {

            request.setAttribute("erreur",
                    "Veuillez sélectionner un patient et saisir le motif.");

            doGet(request, response);
            return;
        }

        try {
            Long patientId = Long.parseLong(patientIdParam);

            Patient patient = patientDAO.findById(patientId);

            if (patient == null) {
                request.setAttribute("erreur",
                        "Le patient sélectionné n'existe pas.");
                doGet(request, response);
                return;
            }

            Consultation consultation = new Consultation();
            consultation.setPatient(patient);
            consultation.setMotif(motif.trim());
            consultation.setObservations(
                    observations == null ? "" : observations.trim()
            );

            // Le coût est fixe : le client ne peut pas le modifier.
            consultation.setCout(new BigDecimal("150.00"));

            consultationDAO.save(consultation);

            response.sendRedirect(
                    request.getContextPath()
                            + "/generaliste/consultation/creer?success=1"
            );

        } catch (NumberFormatException e) {
            request.setAttribute("erreur", "Identifiant du patient invalide.");
            doGet(request, response);

        } catch (RuntimeException e) {
            throw new ServletException(
                    "Erreur lors de la création de la consultation.", e
            );
        }
    }
}

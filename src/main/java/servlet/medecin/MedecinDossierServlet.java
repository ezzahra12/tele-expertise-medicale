
package servlet.medecin;

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
import java.util.List;

@WebServlet("/generaliste/dossier")
public class MedecinDossierServlet extends HttpServlet {

    private final PatientDAO patientDAO = new PatientDAO();
    private final SigneVitalDAO signeVitalDAO = new SigneVitalDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || !idParam.matches("\\d+")) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Identifiant du patient invalide."
            );
            return;
        }

        try {
            Long patientId = Long.parseLong(idParam);

            Patient patient = patientDAO.findById(patientId);

            if (patient == null) {
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Patient introuvable."
                );
                return;
            }

            List<SigneVital> signesVitaux =
                    signeVitalDAO.findByPatientId(patientId);

            request.setAttribute("patient", patient);
            request.setAttribute("signesVitaux", signesVitaux);

            request.getRequestDispatcher(
                    "/generaliste/dossier-patient.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Identifiant du patient invalide."
            );
        }
    }
}

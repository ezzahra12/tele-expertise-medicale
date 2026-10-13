
package servlet;

import dao.PatientDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Patient;

import java.io.IOException;

@WebServlet("/signe-vital/form")
public class SigneVitalFormServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String patientIdParam = request.getParameter("patientId");

        if (patientIdParam == null || patientIdParam.isBlank()) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "ID du patient manquant."
            );
            return;
        }

        try {
            Long patientId = Long.parseLong(patientIdParam);

            PatientDAO patientDAO = new PatientDAO();

            // Cette méthode doit exister dans ton DAO.
            Patient patient = patientDAO.findById(patientId);

            if (patient == null) {
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Patient introuvable."
                );
                return;
            }

            request.setAttribute("patient", patient);

            request.getRequestDispatcher(
                    "/infirmier/addSignes-vitaux.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "ID du patient invalide."
            );
        }
    }
}

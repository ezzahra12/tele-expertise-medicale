
package servlet.medecin;

import dao.PatientDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Patient;

import java.io.IOException;
import java.util.List;

@WebServlet("/generaliste/patients")
public class MedecinPatientsServlet extends HttpServlet {

    private final PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String recherche = request.getParameter("recherche");

        if (recherche == null) {
            recherche = "";
        }

        List<Patient> patients = patientDAO.rechercher(recherche);

        request.setAttribute("patients", patients);
        request.setAttribute("recherche", recherche);

        request.getRequestDispatcher(
                "/generaliste/patients.jsp"
        ).forward(request, response);
    }
}


package servlet;

import dao.PatientDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/infirmier/patients-du-jour")
public class PatientsDuJourServlet extends HttpServlet {

    private final PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute(
                "patients",
                patientDAO.findPatientsDuJour()
        );

        request.getRequestDispatcher(
                "/infirmier/patients-du-jour.jsp"
        ).forward(request, response);
    }
}

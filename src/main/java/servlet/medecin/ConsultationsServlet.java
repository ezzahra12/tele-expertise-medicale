
package servlet.medecin;

import dao.ConsultationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Consultation;

import java.io.IOException;
import java.util.List;

@WebServlet("/generaliste/consultations")
public class ConsultationsServlet extends HttpServlet {

    private final ConsultationDAO consultationDAO =
            new ConsultationDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        List<Consultation> consultations =
                consultationDAO.findAll();

        request.setAttribute("consultations", consultations);

        request.getRequestDispatcher(
                "/generaliste/consultations.jsp"
        ).forward(request, response);
    }
}

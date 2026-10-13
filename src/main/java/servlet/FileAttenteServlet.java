
package servlet;

import dao.FileAttenteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/infirmier/file-attente")
public class FileAttenteServlet extends HttpServlet {

    private final FileAttenteDAO fileAttenteDAO = new FileAttenteDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute(
                "patientsDisponibles",
                fileAttenteDAO.findPatientsDisponibles()
        );

        request.setAttribute(
                "patientsEnAttente",
                fileAttenteDAO.findPatientsEnAttente()
        );

        request.getRequestDispatcher(
                "/infirmier/file-attente.jsp"
        ).forward(request, response);
    }
}

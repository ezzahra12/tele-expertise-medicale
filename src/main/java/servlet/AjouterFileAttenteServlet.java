
package servlet;

import dao.FileAttenteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/file-attente/ajouter")
public class AjouterFileAttenteServlet extends HttpServlet {

    private final FileAttenteDAO fileAttenteDAO = new FileAttenteDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String patientIdParam = request.getParameter("patientId");

        try {
            if (patientIdParam == null ||
                    !patientIdParam.trim().matches("\\d+")) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Identifiant du patient invalide."
                );
                return;
            }

            Long patientId = Long.parseLong(patientIdParam.trim());

            boolean ajoute = fileAttenteDAO.ajouterPatient(patientId);

            String resultat = ajoute ? "ajoute" : "existant";

            response.sendRedirect(
                    request.getContextPath()
                            + "/infirmier/file-attente?resultat=" + resultat
            );

        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Identifiant du patient invalide."
            );
        }
    }
}

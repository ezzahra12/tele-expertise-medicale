package servlet;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Chercher l'utilisateur par email
        User user = userDAO.findByEmail(email);

        // Vérifier email + mot de passe
        if (user != null && user.getPassword().equals(password)) {

            // Créer la session
            HttpSession session = request.getSession();

            // Enregistrer l'utilisateur connecté
            session.setAttribute("user", user);

            // Enregistrer son rôle
            session.setAttribute("role", user.getRole());

            // Vérifier le rôle
            if ("INFIRMIER".equalsIgnoreCase(user.getRole())) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/infirmier/dashboard.jsp"
                );

            } else if ("GENERALISTE".equalsIgnoreCase(user.getRole())) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/generaliste/dashboard.jsp"
                );

            } else if ("SPECIALISTE".equalsIgnoreCase(user.getRole())) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/specialiste/dashboard.jsp"
                );

            } else {

                request.setAttribute(
                        "error",
                        "Rôle utilisateur non reconnu"
                );

                request.getRequestDispatcher("login.jsp")
                        .forward(request, response);
            }

        } else {

            request.setAttribute(
                    "error",
                    "Email ou mot de passe incorrect"
            );

            request.getRequestDispatcher("login.jsp")
                    .forward(request, response);
        }
    }
}
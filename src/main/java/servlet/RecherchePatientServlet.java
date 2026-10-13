package servlet;

import dao.PatientDAO;
import model.Patient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/recherche-patient")
public class RecherchePatientServlet extends HttpServlet {

    private PatientDAO patientDAO = new PatientDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String recherche = request.getParameter("recherche");

        List<Patient> patients = patientDAO.rechercher(recherche);

        request.setAttribute("patients", patients);
        request.setAttribute("recherche", recherche);
        request.getRequestDispatcher("/infirmier/recherche-patient.jsp")

                .forward(request, response);
    }
}

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="model.Consultation" %>
<%@ page import="model.Patient" %>

<%
    List<Consultation> consultations =
        (List<Consultation>) request.getAttribute("consultations");

    DateTimeFormatter formatter =
        DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des consultations</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 35px;
            font-family: Arial, sans-serif;
            background: #f3f6fb;
            color: #1e293b;
        }

        .container {
            max-width: 1200px;
            margin: auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
            margin-bottom: 25px;
        }

        h1 {
            margin: 0 0 8px;
            font-size: 28px;
        }

        .subtitle {
            color: #64748b;
            margin: 0;
        }

        .back {
            text-decoration: none;
            color: #2563eb;
            font-weight: bold;
        }

        .table-container {
            background: white;
            border-radius: 14px;
            padding: 20px;
            overflow-x: auto;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 850px;
        }

        th, td {
            text-align: left;
            padding: 15px 12px;
            border-bottom: 1px solid #e5eaf2;
        }

        th {
            background: #f8fafc;
            color: #475569;
            font-size: 13px;
        }

        td {
            font-size: 14px;
        }

        .status {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            background: #dbeafe;
            color: #1d4ed8;
            font-size: 12px;
            font-weight: bold;
        }

        .empty {
            text-align: center;
            padding: 35px;
            color: #64748b;
        }

        .count {
            margin-bottom: 15px;
            color: #64748b;
        }

        @media (max-width: 600px) {
            body {
                padding: 18px;
            }
        }
    </style>
</head>

<body>
<div class="container">

    <div class="header">
        <div>
            <h1>Liste des consultations</h1>
            <p class="subtitle">
                Consultez les consultations enregistrées et leur état.
            </p>
        </div>

        <a class="back"
           href="${pageContext.request.contextPath}/generaliste/dashboard">
            ← Retour au tableau de bord
        </a>
    </div>

    <div class="count">
        Total :
        <strong><%= consultations == null ? 0 : consultations.size() %></strong>
        consultation(s)
    </div>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>Patient</th>
                <th>Motif</th>
                <th>Date</th>
                <th>Prix</th>
                <th>Statut</th>
            </tr>
            </thead>

            <tbody>
            <% if (consultations != null && !consultations.isEmpty()) {
                for (Consultation c : consultations) {
                    Patient patient = c.getPatient();
            %>
                <tr>
                    <td>
                        <%= patient.getNom() %>
                        <%= patient.getPrenom() %>
                    </td>

                    <td><%= c.getMotif() %></td>

                    <td>
                        <%= c.getDateConsultation() == null
                            ? "-"
                            : c.getDateConsultation().format(formatter) %>
                    </td>

                    <td><%= c.getCout() %> DH</td>

                    <td>
                        <span class="status">
                            <%= c.getStatut() %>
                        </span>
                    </td>
                </tr>
            <%
                }
            } else {
            %>
                <tr>
                    <td colspan="5" class="empty">
                        Aucune consultation enregistrée pour le moment.
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>

</div>
</body>
</html>

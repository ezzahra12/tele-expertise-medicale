
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Patient" %>
<%@ page import="model.FileAttente" %>

<%
    List<Patient> disponibles =
        (List<Patient>) request.getAttribute("patientsDisponibles");

    List<FileAttente> enAttente =
        (List<FileAttente>) request.getAttribute("patientsEnAttente");

    String resultat = request.getParameter("resultat");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>File d'attente</title>

    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            padding: 30px;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #243047;
        }

        .container {
            max-width: 1100px;
            margin: auto;
        }

        h1 { margin-bottom: 8px; }

        .subtitle {
            color: #687386;
            margin-bottom: 28px;
        }

        .message {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            background: #e7f7ec;
            color: #176534;
        }

        .warning {
            background: #fff1dc;
            color: #895500;
        }

        .section {
            background: white;
            padding: 22px;
            border-radius: 12px;
            margin-bottom: 25px;
            box-shadow: 0 3px 12px rgba(0,0,0,.05);
        }

        .section h2 {
            margin-top: 0;
            font-size: 20px;
        }

        .table-wrapper { overflow-x: auto; }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 14px 12px;
            text-align: left;
            border-bottom: 1px solid #edf0f5;
        }

        th {
            background: #f8f9fc;
            color: #596579;
            font-size: 13px;
        }

        .btn {
            display: inline-block;
            padding: 10px 14px;
            border: 0;
            border-radius: 7px;
            color: white;
            background: #e87524;
            cursor: pointer;
            font-weight: bold;
        }

        .btn:hover { background: #c95e15; }

        .status {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            background: #fff1dc;
            color: #895500;
            font-size: 12px;
            font-weight: bold;
        }

        .empty {
            color: #687386;
            padding: 16px 0;
        }

        .back {
            display: inline-block;
            margin-bottom: 22px;
            color: #475569;
            text-decoration: none;
        }

        @media (max-width: 600px) {
            body { padding: 16px; }
        }
    </style>
</head>

<body>
<div class="container">

    <a class="back"
       href="${pageContext.request.contextPath}/infirmier/dashboard.jsp">
        ← Retour au dashboard
    </a>

    <h1>Gestion de la file d'attente</h1>
    <p class="subtitle">
        Gérez les patients en attente d'une consultation médicale.
    </p>

    <% if ("ajoute".equals(resultat)) { %>
        <div class="message">
            Patient ajouté à la file d'attente avec succès.
        </div>
    <% } else if ("existant".equals(resultat)) { %>
        <div class="message warning">
            Ce patient est déjà dans la file d'attente.
        </div>
    <% } %>

    <section class="section">
        <h2>1. Patients enregistrés</h2>
        <p class="subtitle">
            Sélectionnez les patients à ajouter à la file d'attente.
        </p>

        <% if (disponibles == null || disponibles.isEmpty()) { %>
            <p class="empty">Aucun patient disponible pour le moment.</p>
        <% } else { %>

            <div class="table-wrapper">
                <table>
                    <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Téléphone</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Patient p : disponibles) { %>
                        <tr>
                            <td><%= p.getNom() == null ? "" : p.getNom() %></td>
                            <td><%= p.getPrenom() == null ? "" : p.getPrenom() %></td>
                            <td><%= p.getTelephone() == null ? "" : p.getTelephone() %></td>
                            <td>
                                <form method="post"
                                      action="${pageContext.request.contextPath}/file-attente/ajouter">

                                    <input type="hidden"
                                           name="patientId"
                                           value="<%= p.getId() %>">

                                    <button class="btn" type="submit">
                                        + Ajouter à la file
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

        <% } %>
    </section>

    <section class="section">
        <h2>2. Patients dans la file d'attente</h2>
        <p class="subtitle">
            Liste des patients qui attendent une consultation.
        </p>

        <% if (enAttente == null || enAttente.isEmpty()) { %>
            <p class="empty">Aucun patient dans la file d'attente.</p>
        <% } else { %>

            <div class="table-wrapper">
                <table>
                    <thead>
                    <tr>
                        <th>Ordre</th>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Heure d'ajout</th>
                        <th>Statut</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% int ordre = 1; %>
                    <% for (FileAttente f : enAttente) { %>
                        <tr>
                            <td><%= ordre++ %></td>
                            <td><%= f.getPatient().getNom() == null
                                    ? "" : f.getPatient().getNom() %></td>
                            <td><%= f.getPatient().getPrenom() == null
                                    ? "" : f.getPatient().getPrenom() %></td>
                            <td><%= f.getDateAjout().toLocalTime()
                                    .withNano(0) %></td>
                            <td>
                                <span class="status">En attente</span>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

        <% } %>
    </section>

</div>
</body>
</html>


<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Patient" %>

<%!
    public String escapeHtml(Object value) {
        if (value == null) {
            return "";
        }

        return String.valueOf(value)
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>

<%
    List<Patient> patients =
            (List<Patient>) request.getAttribute("patients");
%>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Patients du jour | Télé-Expertise</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            min-height: 100vh;
            background:
                radial-gradient(circle at 10% 20%, #dbeafe 0, transparent 30%),
                radial-gradient(circle at 90% 80%, #d1fae5 0, transparent 30%),
                #f8fafc;
            color: #172033;
            padding: 30px 0;
        }

        .container {
            width: 90%;
            max-width: 1150px;
            margin: auto;
        }

        .back {
            display: inline-block;
            margin-bottom: 25px;
            text-decoration: none;
            color: #475569;
            font-size: 14px;
        }

        .back:hover {
            color: #2563eb;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 25px;
        }

        .header h1 {
            font-size: 28px;
            margin-bottom: 8px;
        }

        .header p {
            color: #64748b;
            font-size: 14px;
        }

        .date {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 12px 16px;
            color: #2563eb;
            font-weight: bold;
            font-size: 13px;
            white-space: nowrap;
        }

        .summary {
            background: rgba(255, 255, 255, 0.9);
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 20px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 16px;
            box-shadow: 0 5px 18px rgba(15, 23, 42, 0.04);
        }

        .summary-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background: #ede9fe;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 23px;
        }

        .summary-label {
            color: #64748b;
            font-size: 13px;
            margin-bottom: 5px;
        }

        .summary-count {
            font-size: 25px;
            font-weight: bold;
            color: #172033;
        }

        .panel {
            background: rgba(255, 255, 255, 0.92);
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 8px 25px rgba(15, 23, 42, 0.05);
        }

        .panel h2 {
            font-size: 19px;
            margin-bottom: 8px;
        }

        .panel-description {
            color: #64748b;
            font-size: 13px;
            margin-bottom: 22px;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 750px;
        }

        th, td {
            padding: 15px 12px;
            text-align: left;
            border-bottom: 1px solid #edf0f5;
            font-size: 13px;
        }

        th {
            background: #f8fafc;
            color: #64748b;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.4px;
        }

        tbody tr:hover {
            background: #f8fafc;
        }

        .patient-name {
            font-weight: bold;
            color: #172033;
        }

        .patient-id {
            color: #64748b;
        }

        .time {
            display: inline-block;
            background: #dbeafe;
            color: #1d4ed8;
            border-radius: 7px;
            padding: 6px 9px;
            font-weight: bold;
        }

        .empty {
            text-align: center;
            padding: 45px 15px;
            color: #64748b;
        }

        .empty-icon {
            font-size: 40px;
            margin-bottom: 12px;
        }

        .empty h3 {
            color: #334155;
            font-size: 17px;
            margin-bottom: 8px;
        }

        .refresh {
            display: inline-block;
            margin-top: 18px;
            padding: 10px 16px;
            border-radius: 8px;
            background: #2563eb;
            color: white;
            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
        }

        .refresh:hover {
            background: #1d4ed8;
        }

        .footer {
            text-align: center;
            color: #94a3b8;
            font-size: 11px;
            margin-top: 25px;
        }

        @media (max-width: 700px) {
            .container {
                width: 92%;
            }

            .header {
                align-items: flex-start;
                flex-direction: column;
            }

            .header h1 {
                font-size: 24px;
            }

            .panel {
                padding: 16px;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <a class="back"
       href="${pageContext.request.contextPath}/infirmier/dashboard.jsp">
        ← Retour au dashboard
    </a>

    <div class="header">
        <div>
            <h1>Patients du jour 👥</h1>
            <p>Consultez les patients enregistrés aujourd'hui.</p>
        </div>

        <div class="date">
            <%= java.time.LocalDate.now()
                    .format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")) %>
        </div>
    </div>

    <div class="summary">
        <div class="summary-icon">👥</div>

        <div>
            <div class="summary-label">
                Nombre de patients enregistrés aujourd'hui
            </div>

            <div class="summary-count">
                <%= patients == null ? 0 : patients.size() %>
            </div>
        </div>
    </div>

    <div class="panel">

        <h2>Liste des patients</h2>

        <p class="panel-description">
            Voici les patients dont le dossier a été enregistré aujourd'hui.
        </p>

        <% if (patients == null || patients.isEmpty()) { %>

            <div class="empty">
                <div class="empty-icon">📋</div>

                <h3>Aucun patient enregistré aujourd'hui</h3>

                <p>
                    Les patients enregistrés au cours de la journée
                    apparaîtront ici.
                </p>

                <a class="refresh"
                   href="${pageContext.request.contextPath}/infirmier/patients-du-jour">
                    Actualiser la liste
                </a>
            </div>

        <% } else { %>

            <div class="table-wrapper">
                <table>
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>N° sécurité sociale</th>
                        <th>Téléphone</th>
                        <th>Heure d'enregistrement</th>
                    </tr>
                    </thead>

                    <tbody>

                    <% int numero = 1; %>

                    <% for (Patient patient : patients) { %>

                        <tr>
                            <td><%= numero++ %></td>

                            <td class="patient-name">
                                <%= escapeHtml(patient.getNom()) %>
                            </td>

                            <td class="patient-name">
                                <%= escapeHtml(patient.getPrenom()) %>
                            </td>

                            <td class="patient-id">
                                <%= escapeHtml(patient.getNumeroSecuriteSociale()) %>
                            </td>

                            <td>
                                <%= escapeHtml(patient.getTelephone()) %>
                            </td>

                            <td>
                                <% if (patient.getHeureArrivee() != null) { %>
                                    <span class="time">
                                        <%= patient.getHeureArrivee()
                                                .format(java.time.format.DateTimeFormatter.ofPattern("HH:mm")) %>
                                    </span>
                                <% } else { %>
                                    —
                                <% } %>
                            </td>
                        </tr>

                    <% } %>

                    </tbody>
                </table>
            </div>

        <% } %>

    </div>

    <div class="footer">
        Télé-Expertise Médicale · Espace professionnel
    </div>

</div>

</body>
</html>

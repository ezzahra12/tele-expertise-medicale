
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Patient" %>

<%!
    // Protection contre l'injection HTML / XSS
    public String escapeHtml(Object value) {
        if (value == null) {
            return "";
        }

        String text = String.valueOf(value);

        return text
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }
%>

<%
    List<Patient> patients =
            (List<Patient>) request.getAttribute("patients");

    String recherche = (String) request.getAttribute("recherche");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Télé-Expertise | Recherche patient</title>

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
        }

        .container {
            width: 88%;
            max-width: 1100px;
            margin: auto;
            padding: 28px 0;
        }

        .top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .brand-icon {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            background: linear-gradient(135deg, #2563eb, #06b6d4);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 21px;
        }

        .brand h2 {
            font-size: 16px;
        }

        .brand span {
            display: block;
            color: #64748b;
            font-size: 11px;
            margin-top: 3px;
        }

        .back {
            text-decoration: none;
            color: #64748b;
            font-size: 13px;
            padding: 9px 14px;
            border-radius: 9px;
            background: white;
            border: 1px solid #e2e8f0;
        }

        .back:hover {
            background: #f1f5f9;
        }

        .welcome {
            margin-bottom: 22px;
        }

        .small {
            color: #2563eb;
            font-size: 11px;
            font-weight: bold;
            letter-spacing: 1px;
            margin-bottom: 8px;
        }

        .welcome h1 {
            font-size: 28px;
            margin-bottom: 8px;
        }

        .welcome p {
            color: #64748b;
            font-size: 13px;
        }

        .search-box,
        .results {
            background: rgba(255, 255, 255, 0.9);
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 8px 25px rgba(15, 23, 42, 0.05);
            margin-bottom: 20px;
        }

        .search-form {
            display: flex;
            gap: 10px;
        }

        .search-form input {
            flex: 1;
            min-width: 0;
            padding: 12px 15px;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            outline: none;
            font-size: 13px;
            background: white;
        }

        .search-form input:focus {
            border-color: #2563eb;
        }

        .search-form button {
            border: none;
            border-radius: 10px;
            padding: 12px 22px;
            background: #2563eb;
            color: white;
            font-size: 13px;
            font-weight: bold;
            cursor: pointer;
        }

        .search-form button:hover {
            background: #1d4ed8;
        }

        .results-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
            margin-bottom: 16px;
        }

        .results-title h2 {
            font-size: 16px;
        }

        .count {
            color: #64748b;
            font-size: 12px;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 12px;
        }

        th {
            text-align: left;
            color: #64748b;
            font-size: 11px;
            padding: 12px 10px;
            border-bottom: 1px solid #e2e8f0;
            white-space: nowrap;
        }

        td {
            padding: 13px 10px;
            border-bottom: 1px solid #f1f5f9;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .patient-name {
            font-weight: bold;
            color: #172033;
        }

        .action-link {
            display: inline-block;
            text-decoration: none;
            background: #eff6ff;
            color: #2563eb;
            border: 1px solid #bfdbfe;
            padding: 9px 12px;
            border-radius: 8px;
            font-size: 11px;
            font-weight: bold;
            white-space: nowrap;
        }

        .action-link:hover {
            background: #dbeafe;
        }

        .empty {
            text-align: center;
            color: #94a3b8;
            padding: 30px 15px;
            font-size: 13px;
        }

        .footer {
            text-align: center;
            margin-top: 22px;
            color: #94a3b8;
            font-size: 10px;
        }

        @media (max-width: 750px) {
            .container {
                width: 92%;
                padding: 22px 0;
            }

            .welcome h1 {
                font-size: 23px;
            }

            .search-form {
                flex-direction: column;
            }

            .search-form button {
                width: 100%;
            }

            .search-box,
            .results {
                padding: 16px;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <div class="top">
        <div class="brand">
            <div class="brand-icon">✚</div>
            <div>
                <h2>Télé-Expertise</h2>
                <span>Plateforme médicale</span>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/infirmier/dashboard.jsp"
           class="back">
            ← Retour
        </a>
    </div>

    <div class="welcome">
        <div class="small">ESPACE INFIRMIER</div>
        <h1>Rechercher un patient 🔎</h1>
        <p>Retrouvez le dossier d'un patient et ajoutez de nouvelles mesures.</p>
    </div>

    <div class="search-box">
        <form action="${pageContext.request.contextPath}/recherche-patient"
              method="get"
              class="search-form">

            <input
                type="text"
                name="recherche"
                placeholder="Nom, prénom ou numéro de sécurité sociale"
                value="<%= escapeHtml(recherche) %>"
                required>

            <button type="submit">Rechercher</button>
        </form>
    </div>

    <div class="results">

        <div class="results-title">
            <h2>Résultats de recherche</h2>

            <% if (patients != null) { %>
                <span class="count">
                    <%= patients.size() %> patient(s)
                </span>
            <% } %>
        </div>

        <% if (patients != null && !patients.isEmpty()) { %>

            <div class="table-wrapper">
                <table>
                    <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Date de naissance</th>
                        <th>Téléphone</th>
                        <th>Adresse</th>
                        <th>Action</th>
                    </tr>
                    </thead>

                    <tbody>
                    <% for (Patient patient : patients) { %>
                        <tr>
                            <td class="patient-name">
                                <%= escapeHtml(patient.getNom()) %>
                            </td>

                            <td>
                                <%= escapeHtml(patient.getPrenom()) %>
                            </td>

                            <td>
                                <%= escapeHtml(patient.getDateNaissance()) %>
                            </td>

                            <td>
                                <%= escapeHtml(patient.getTelephone()) %>
                            </td>

                            <td>
                                <%= escapeHtml(patient.getAdresse()) %>
                            </td>

                            <td>
                               <a href="${pageContext.request.contextPath}/infirmier/addSignes-vitaux.jsp?patientId=<%= patient.getId() %>">
                                   Ajouter signes vitaux →
                               </a>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

        <% } else if (patients != null) { %>

            <div class="empty">
                Aucun patient trouvé. Vérifiez les informations saisies.
            </div>

        <% } else { %>

            <div class="empty">
                Entrez le nom, le prénom ou le numéro de sécurité sociale
                d'un patient pour commencer.
            </div>

        <% } %>

    </div>

    <div class="footer">
        Télé-Expertise Médicale · Espace professionnel
    </div>

</div>

</body>
</html>

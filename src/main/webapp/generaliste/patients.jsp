
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Patient" %>

<%
    List<Patient> patients =
        (List<Patient>) request.getAttribute("patients");

    String recherche =
        (String) request.getAttribute("recherche");

    if (recherche == null) recherche = "";

    String rechercheSafe = recherche
        .replace("&", "&amp;")
        .replace("\"", "&quot;")
        .replace("<", "&lt;")
        .replace(">", "&gt;");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Patients | Télé-Expertise Médicale</title>

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
            max-width: 1150px;
            margin: auto;
            padding: 28px 0;
        }

        /* HEADER */

        .top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            margin-bottom: 32px;
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
            font-size: 22px;
        }

        .brand h1 {
            font-size: 16px;
            margin-bottom: 4px;
        }

        .brand p {
            color: #64748b;
            font-size: 11px;
        }

        .back-link {
            text-decoration: none;
            color: #64748b;
            font-size: 13px;
            padding: 9px 14px;
            border-radius: 9px;
            background: rgba(255,255,255,.75);
            border: 1px solid #e2e8f0;
            transition: .2s;
        }

        .back-link:hover {
            color: #2563eb;
            background: #dbeafe;
        }

        /* PAGE TITLE */

        .page-heading {
            margin-bottom: 25px;
        }

        .page-heading .small {
            color: #2563eb;
            font-size: 11px;
            font-weight: bold;
            letter-spacing: 1px;
            margin-bottom: 7px;
        }

        .page-heading h2 {
            font-size: 30px;
            margin-bottom: 8px;
        }

        .page-heading p {
            color: #64748b;
            font-size: 13px;
            line-height: 1.6;
        }

        /* PANEL */

        .panel {
            background: rgba(255,255,255,.82);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,.9);
            border-radius: 18px;
            padding: 25px;
            box-shadow: 0 8px 25px rgba(15,23,42,.06);
        }

        .panel-heading {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 22px;
        }

        .panel-heading h3 {
            margin-bottom: 7px;
            font-size: 17px;
        }

        .panel-heading p {
            color: #64748b;
            font-size: 12px;
            line-height: 1.6;
        }

        .count {
            padding: 8px 12px;
            border-radius: 20px;
            background: #dbeafe;
            color: #2563eb;
            font-size: 11px;
            font-weight: bold;
            white-space: nowrap;
        }

        /* SEARCH */

        .search-form {
            display: flex;
            gap: 12px;
            margin-bottom: 24px;
        }

        .search-input {
            flex: 1;
            min-width: 0;
            padding: 13px 15px;
            border: 1px solid #dce3eb;
            border-radius: 10px;
            font-family: inherit;
            font-size: 13px;
            outline: none;
            background: rgba(255,255,255,.9);
            color: #172033;
            transition: .2s;
        }

        .search-input:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37,99,235,.09);
        }

        .search-input::placeholder {
            color: #94a3b8;
        }

        .search-button {
            padding: 12px 22px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg, #2563eb, #06b6d4);
            color: white;
            font-family: inherit;
            font-size: 13px;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0 5px 14px rgba(37,99,235,.17);
            transition: .25s;
        }

        .search-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(37,99,235,.25);
        }

        /* TABLE */

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            background: rgba(255,255,255,.7);
        }

        table {
            width: 100%;
            min-width: 750px;
            border-collapse: collapse;
        }

        thead {
            background: #eff6ff;
        }

        th {
            padding: 15px 13px;
            text-align: left;
            color: #475569;
            font-size: 11px;
            font-weight: bold;
            border-bottom: 1px solid #e2e8f0;
            white-space: nowrap;
        }

        td {
            padding: 14px 13px;
            border-bottom: 1px solid #eaf0f7;
            font-size: 12px;
            color: #475569;
        }

        tbody tr {
            transition: background .2s;
        }

        tbody tr:hover {
            background: #f0f7ff;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .patient-cell {
            display: flex;
            align-items: center;
            min-width: 170px;
        }

        .patient-avatar {
            display: inline-flex;
            width: 38px;
            height: 38px;
            flex-shrink: 0;
            border-radius: 12px;
            align-items: center;
            justify-content: center;
            background: #dbeafe;
            color: #2563eb;
            font-size: 14px;
            font-weight: bold;
            margin-right: 10px;
        }

        .patient-name {
            font-weight: bold;
            color: #172033;
            line-height: 1.5;
        }

        .view-button {
            display: inline-block;
            padding: 9px 12px;
            border: 1px solid #bfdbfe;
            border-radius: 9px;
            background: #eff6ff;
            color: #2563eb;
            text-decoration: none;
            font-size: 11px;
            font-weight: bold;
            white-space: nowrap;
            transition: .2s;
        }

        .view-button:hover {
            background: #2563eb;
            border-color: #2563eb;
            color: white;
            transform: translateY(-1px);
        }

        /* EMPTY STATE */

        .empty-state {
            text-align: center;
            padding: 40px 15px;
            color: #64748b;
            line-height: 1.8;
        }

        .empty-icon {
            width: 58px;
            height: 58px;
            margin: 0 auto 15px;
            border-radius: 17px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #dbeafe;
            color: #2563eb;
            font-size: 27px;
        }

        .empty-state h4 {
            color: #172033;
            margin-bottom: 7px;
            font-size: 15px;
        }

        .empty-state p {
            font-size: 12px;
        }

        /* FOOTER */

        .footer {
            text-align: center;
            margin-top: 23px;
            color: #94a3b8;
            font-size: 10px;
        }

        /* RESPONSIVE */

        @media (max-width: 750px) {
            .container {
                width: 92%;
                padding: 25px 0;
            }

            .page-heading h2 {
                font-size: 26px;
            }

            .panel {
                padding: 19px;
            }
        }

        @media (max-width: 550px) {
            .top {
                align-items: flex-start;
                flex-direction: column;
            }

            .search-form {
                flex-direction: column;
            }

            .search-button {
                width: 100%;
            }

            .panel-heading {
                align-items: flex-start;
            }

            .page-heading h2 {
                font-size: 24px;
            }
        }
    </style>
</head>

<body>

<main class="container">

    <!-- HEADER -->

    <header class="top">
        <div class="brand">
            <div class="brand-icon">✚</div>

            <div>
                <h1>Télé-Expertise</h1>
                <p>Plateforme médicale · Espace médecin généraliste</p>
            </div>
        </div>

        <a class="back-link"
           href="${pageContext.request.contextPath}/generaliste/dashboard">
            ← Tableau de bord
        </a>
    </header>

    <!-- TITLE -->

    <section class="page-heading">
        <div class="small">ESPACE MÉDECIN GÉNÉRALISTE</div>
        <h2>Liste des patients 👥</h2>
        <p>
            Retrouvez un patient et consultez son dossier médical
            en quelques clics.
        </p>
    </section>

    <!-- PATIENTS PANEL -->

    <section class="panel">

        <div class="panel-heading">
            <div>
                <h3>Patients enregistrés</h3>
                <p>
                    Recherchez par nom, prénom ou numéro de sécurité sociale.
                </p>
            </div>

            <% if (patients != null) { %>
                <span class="count">
                    <%= patients.size() %> patient(s)
                </span>
            <% } %>
        </div>

        <form class="search-form"
              method="get"
              action="${pageContext.request.contextPath}/generaliste/patients">

            <input class="search-input"
                   type="text"
                   name="recherche"
                   placeholder="🔎  Rechercher un patient..."
                   value="<%= rechercheSafe %>">

            <button class="search-button" type="submit">
                Rechercher →
            </button>
        </form>

        <% if (patients == null || patients.isEmpty()) { %>

            <div class="empty-state">
                <div class="empty-icon">♙</div>
                <h4>Aucun patient trouvé</h4>
                <p>
                    Essayez avec un autre nom ou vérifiez les informations saisies.
                </p>
            </div>

        <% } else { %>

            <div class="table-wrapper">
                <table>
                    <thead>
                    <tr>
                        <th>Patient</th>
                        <th>Date de naissance</th>
                        <th>Téléphone</th>
                        <th>Adresse</th>
                        <th>Action</th>
                    </tr>
                    </thead>

                    <tbody>

                    <% for (Patient p : patients) {
                        String nom = p.getNom() == null ? "" : p.getNom();
                        String prenom = p.getPrenom() == null ? "" : p.getPrenom();

                        String initiale = !prenom.isEmpty()
                                ? prenom.substring(0, 1).toUpperCase()
                                : (!nom.isEmpty()
                                    ? nom.substring(0, 1).toUpperCase()
                                    : "?");
                    %>

                        <tr>
                            <td>
                                <div class="patient-cell">
                                    <span class="patient-avatar"><%= initiale %></span>

                                    <span class="patient-name">
                                        <%= nom %> <%= prenom %>
                                    </span>
                                </div>
                            </td>

                            <td>
                                <%= p.getDateNaissance() == null
                                    ? "Non renseignée"
                                    : p.getDateNaissance() %>
                            </td>

                            <td>
                                <%= p.getTelephone() == null
                                    ? "Non renseigné"
                                    : p.getTelephone() %>
                            </td>

                            <td>
                                <%= p.getAdresse() == null
                                    ? "Non renseignée"
                                    : p.getAdresse() %>
                            </td>

                            <td>
                                <a class="view-button"
                                   href="${pageContext.request.contextPath}/generaliste/dossier?id=<%= p.getId() %>">
                                    Consulter le dossier →
                                </a>
                            </td>
                        </tr>

                    <% } %>

                    </tbody>
                </table>
            </div>

        <% } %>

    </section>

    <footer class="footer">
        Télé-Expertise Médicale · Espace professionnel de santé
    </footer>

</main>

</body>
</html>

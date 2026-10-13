
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="model.Patient" %>
<%@ page import="model.SigneVital" %>

<%
    Patient patient = (Patient) request.getAttribute("patient");
    List<SigneVital> signesVitaux =
            (List<SigneVital>) request.getAttribute("signesVitaux");

    if (signesVitaux == null) {
        signesVitaux = java.util.Collections.emptyList();
    }

    DateTimeFormatter formatDate =
            DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dossier patient | Télé-expertise médicale</title>

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
    max-width: 1050px;
    margin: auto;
    padding: 28px 0;
}

/* HEADER */

.top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
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
    color: #172033;
}

.brand span {
    display: block;
    color: #64748b;
    font-size: 11px;
    margin-top: 2px;
}

.role {
    color: #2563eb;
    font-size: 12px;
    padding: 9px 13px;
    border-radius: 9px;
    background: rgba(255,255,255,.75);
    border: 1px solid #e2e8f0;
}

/* BACK */

.back {
    display: inline-block;
    margin-bottom: 22px;
    text-decoration: none;
    color: #2563eb;
    font-size: 13px;
    font-weight: 600;
    padding: 9px 13px;
    border-radius: 9px;
    background: rgba(255,255,255,.75);
    border: 1px solid #dbeafe;
    transition: .25s;
}

.back:hover {
    background: #dbeafe;
    transform: translateX(-3px);
}

/* TITLE */

.page-heading {
    margin-bottom: 24px;
}

.page-heading small {
    display: block;
    color: #2563eb;
    font-size: 11px;
    font-weight: bold;
    letter-spacing: 1px;
    margin-bottom: 7px;
}

.page-heading h1 {
    font-size: 30px;
    margin-bottom: 7px;
    color: #172033;
}

.page-heading p {
    color: #64748b;
    font-size: 13px;
    line-height: 1.6;
}

/* CARDS */

.card {
    position: relative;
    background: rgba(255,255,255,.82);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255,255,255,.9);
    border-radius: 18px;
    padding: 23px;
    margin-bottom: 18px;
    box-shadow: 0 8px 25px rgba(15,23,42,.06);
    transition: box-shadow .25s ease;
}

.card:hover {
    box-shadow: 0 12px 28px rgba(15,23,42,.09);
}

.card-heading {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 22px;
}

.card-heading h2 {
    font-size: 16px;
    color: #172033;
}

.section-icon {
    width: 42px;
    height: 42px;
    border-radius: 13px;
    background: #dbeafe;
    color: #2563eb;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 21px;
    flex-shrink: 0;
}

/* PATIENT HEADER */

.patient-header {
    display: flex;
    align-items: center;
    gap: 14px;
    padding-bottom: 20px;
    margin-bottom: 22px;
    border-bottom: 1px solid #e2e8f0;
}

.patient-avatar {
    width: 54px;
    height: 54px;
    border-radius: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #dbeafe;
    color: #2563eb;
    font-size: 26px;
    flex-shrink: 0;
}

.patient-header h2 {
    font-size: 18px;
    margin-bottom: 8px;
    color: #172033;
}

.badge {
    display: inline-block;
    color: #166534;
    background: #d1fae5;
    padding: 6px 10px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: bold;
}

/* PERSONAL INFORMATION */

.patient-grid {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 23px 25px;
}

.field-label {
    color: #64748b;
    font-size: 12px;
    margin-bottom: 8px;
}

.field-value {
    color: #172033;
    font-size: 13px;
    font-weight: 600;
    overflow-wrap: anywhere;
    line-height: 1.6;
}

/* VITALS TABLE */

.table-wrapper {
    width: 100%;
    overflow-x: auto;
    border-radius: 12px;
    border: 1px solid #e2e8f0;
    background: rgba(255,255,255,.7);
}

table {
    width: 100%;
    min-width: 760px;
    border-collapse: collapse;
}

th {
    text-align: left;
    background: #eff6ff;
    color: #475569;
    font-size: 11px;
    font-weight: bold;
    padding: 14px 12px;
    white-space: nowrap;
}

td {
    padding: 14px 12px;
    border-bottom: 1px solid #eaf0f7;
    font-size: 12px;
    color: #334155;
    white-space: nowrap;
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

/* EMPTY STATE */

.empty {
    padding: 30px 15px;
    text-align: center;
    color: #64748b;
    font-size: 13px;
    line-height: 1.8;
}

.empty-icon {
    font-size: 30px;
    margin-bottom: 10px;
    color: #2563eb;
}

.empty strong {
    display: block;
    color: #172033;
    margin-bottom: 5px;
}

.empty p {
    margin: 5px 0 12px;
}

/* INFORMATION */

.info {
    margin-top: 16px;
    padding: 12px 14px;
    background: #dbeafe;
    border: 1px solid #bfdbfe;
    border-radius: 10px;
    color: #1d4ed8;
    font-size: 12px;
    line-height: 1.6;
}

/* FOOTER */

.footer {
    text-align: center;
    margin-top: 22px;
    color: #94a3b8;
    font-size: 10px;
}

/* RESPONSIVE */

@media (max-width: 750px) {
    .container {
        width: 92%;
        padding: 25px 0;
    }

    .patient-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 20px;
    }

    .page-heading h1 {
        font-size: 26px;
    }

    .card {
        padding: 19px;
    }
}

@media (max-width: 500px) {
    .top {
        align-items: flex-start;
        flex-direction: column;
    }

    .patient-grid {
        grid-template-columns: 1fr;
    }

    .page-heading h1 {
        font-size: 24px;
    }

    .patient-header h2 {
        font-size: 16px;
    }
}

    </style>
</head>

<body>

<header class="topbar">
    <div class="brand">
        <div class="brand-icon">✚</div>
        <span>Télé-Expertise Médicale</span>
    </div>
    <div class="role">Espace médecin généraliste</div>
</header>

<main class="container">

    <a class="back"
       href="<%= request.getContextPath() %>/generaliste/patients">
        ← Retour à la liste des patients
    </a>

    <div class="page-heading">
        <h1>Dossier patient</h1>
        <p>Consultez les informations et l'historique des signes vitaux du patient.</p>
    </div>

    <% if (patient == null) { %>

        <section class="card">
            <div class="empty">
                <div class="empty-icon">⚠</div>
                <strong>Dossier introuvable</strong>
                <p>Les informations du patient n'ont pas été transmises à la page.</p>
                <a class="back"
                   href="<%= request.getContextPath() %>/generaliste/patients">
                    Retour aux patients
                </a>
            </div>
        </section>

    <% } else { %>

        <section class="card">
            <div class="card-heading">
                <div class="section-icon">♙</div>
                <h2>Informations personnelles</h2>
            </div>

            <div class="patient-grid">
                <div>
                    <div class="field-label">Nom</div>
                    <div class="field-value"><%= patient.getNom() == null ? "—" : patient.getNom() %></div>
                </div>

                <div>
                    <div class="field-label">Prénom</div>
                    <div class="field-value"><%= patient.getPrenom() == null ? "—" : patient.getPrenom() %></div>
                </div>

                <div>
                    <div class="field-label">Date de naissance</div>
                    <div class="field-value"><%= patient.getDateNaissance() == null ? "—" : patient.getDateNaissance() %></div>
                </div>

                <div>
                    <div class="field-label">N° de sécurité sociale</div>
                    <div class="field-value"><%= patient.getNumeroSecuriteSociale() == null ? "—" : patient.getNumeroSecuriteSociale() %></div>
                </div>

                <div>
                    <div class="field-label">Téléphone</div>
                    <div class="field-value"><%= patient.getTelephone() == null ? "—" : patient.getTelephone() %></div>
                </div>

                <div>
                    <div class="field-label">Adresse</div>
                    <div class="field-value"><%= patient.getAdresse() == null ? "—" : patient.getAdresse() %></div>
                </div>

                <div>
                    <div class="field-label">Date d'enregistrement</div>
                    <div class="field-value"><%= patient.getDateEnregistrement() == null ? "—" : patient.getDateEnregistrement() %></div>
                </div>

                <div>
                    <div class="field-label">Heure d'arrivée</div>
                    <div class="field-value"><%= patient.getHeureArrivee() == null ? "—" : patient.getHeureArrivee() %></div>
                </div>

                <div>
                    <div class="field-label">Statut du dossier</div>
                    <div class="field-value"><span class="badge">Patient enregistré</span></div>
                </div>
            </div>
        </section>

        <section class="card">
            <div class="card-heading">
                <div class="section-icon">♡</div>
                <h2>Historique des signes vitaux</h2>
            </div>

            <% if (signesVitaux.isEmpty()) { %>

                <div class="empty">
                    <div class="empty-icon">♡</div>
                    <strong>Aucune mesure enregistrée</strong>
                    <p>Les signes vitaux de ce patient apparaîtront ici après leur enregistrement.</p>
                </div>

            <% } else { %>

                <div class="table-wrapper">
                    <table>
                        <thead>
                        <tr>
                            <th>Date de mesure</th>
                            <th>Tension</th>
                            <th>Fréquence cardiaque</th>
                            <th>Fréquence respiratoire</th>
                            <th>Température</th>
                            <th>Poids</th>
                            <th>Taille</th>
                        </tr>
                        </thead>

                        <tbody>
                        <% for (SigneVital sv : signesVitaux) { %>
                            <tr>
                                <td><%= sv.getDateMesure() == null ? "—" : sv.getDateMesure().format(formatDate) %></td>
                                <td><%= sv.getTension() == null ? "—" : sv.getTension() %></td>
                                <td><%= sv.getFrequenceCardiaque() == null ? "—" : sv.getFrequenceCardiaque() + " bpm" %></td>
                                <td><%= sv.getFrequenceRespiratoire() == null ? "—" : sv.getFrequenceRespiratoire() + " /min" %></td>
                                <td><%= sv.getTemperature() == null ? "—" : sv.getTemperature() + " °C" %></td>
                                <td><%= sv.getPoids() == null ? "—" : sv.getPoids() + " kg" %></td>
                                <td><%= sv.getTaille() == null ? "—" : sv.getTaille() + " cm" %></td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>

            <% } %>
        </section>

    <% } %>

    <div class="footer">
        Télé-Expertise Médicale · Espace professionnel de santé
    </div>

</main>

</body>
</html>
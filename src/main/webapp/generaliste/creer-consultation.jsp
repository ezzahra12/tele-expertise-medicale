
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Patient" %>

<%
    List<Patient> patients =
            (List<Patient>) request.getAttribute("patients");

    String erreur = (String) request.getAttribute("erreur");
    String success = request.getParameter("success");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer une consultation | Télé-Expertise Médicale</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            min-height: 100vh;
            padding: 35px 20px;
            font-family: "Segoe UI", Arial, sans-serif;
            color: #1e293b;
            background:
                radial-gradient(circle at top left, #dbeafe, transparent 42%),
                radial-gradient(circle at bottom right, #d1fae5, transparent 40%),
                #f8fafc;
        }

        .container {
            width: 100%;
            max-width: 850px;
            margin: 0 auto;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 25px;
            color: #2563eb;
            text-decoration: none;
            font-weight: 600;
            transition: 0.2s;
        }

        .back-link:hover {
            color: #1d4ed8;
            transform: translateX(-3px);
        }

        .header {
            display: flex;
            align-items: center;
            gap: 18px;
            margin-bottom: 28px;
        }

        .header-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            width: 65px;
            height: 65px;
            border-radius: 18px;
            color: white;
            font-size: 29px;
            background: linear-gradient(135deg, #2563eb, #06b6d4);
            box-shadow: 0 10px 25px rgba(37, 99, 235, 0.22);
        }

        h1 {
            margin-bottom: 7px;
            font-size: 29px;
            color: #0f172a;
        }

        .subtitle {
            color: #64748b;
            font-size: 14px;
            line-height: 1.6;
        }

        .card {
            padding: 32px;
            border: 1px solid rgba(255, 255, 255, 0.85);
            border-radius: 22px;
            background: rgba(255, 255, 255, 0.88);
            box-shadow: 0 15px 45px rgba(15, 23, 42, 0.07);
            backdrop-filter: blur(12px);
        }

        .section-title {
            margin-bottom: 8px;
            font-size: 19px;
            font-weight: 700;
            color: #0f172a;
        }

        .section-description {
            margin-bottom: 27px;
            color: #64748b;
            font-size: 13px;
            line-height: 1.6;
        }

        .form-group {
            margin-bottom: 23px;
        }

        label {
            display: block;
            margin-bottom: 9px;
            color: #334155;
            font-size: 14px;
            font-weight: 600;
        }

        .required {
            color: #dc2626;
        }

        input, select, textarea {
            width: 100%;
            padding: 13px 15px;
            border: 1px solid #dbe3ee;
            border-radius: 12px;
            outline: none;
            background: #fff;
            color: #1e293b;
            font-family: inherit;
            font-size: 14px;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input:focus, select:focus, textarea:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.10);
        }

        textarea {
            min-height: 125px;
            resize: vertical;
            line-height: 1.6;
        }

        .hint {
            margin-top: 7px;
            color: #94a3b8;
            font-size: 12px;
        }

        .price-box {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;
            margin: 27px 0;
            padding: 21px;
            border: 1px solid #bfdbfe;
            border-radius: 15px;
            background: linear-gradient(120deg, #eff6ff, #ecfeff);
        }

        .price-label {
            margin-bottom: 5px;
            font-weight: 700;
            color: #1e40af;
        }

        .price-description {
            color: #64748b;
            font-size: 12px;
            line-height: 1.5;
        }

        .price {
            white-space: nowrap;
            color: #1d4ed8;
            font-size: 27px;
            font-weight: 800;
        }

        .actions {
            display: flex;
            justify-content: flex-end;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 30px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            min-height: 45px;
            padding: 12px 21px;
            border: none;
            border-radius: 12px;
            font-family: inherit;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
            transition: 0.2s;
        }

        .btn-primary {
            color: white;
            background: linear-gradient(135deg, #2563eb, #0891b2);
            box-shadow: 0 7px 18px rgba(37, 99, 235, 0.18);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 24px rgba(37, 99, 235, 0.25);
        }

        .btn-secondary {
            color: #475569;
            border: 1px solid #e2e8f0;
            background: white;
        }

        .btn-secondary:hover {
            background: #f8fafc;
        }

        .alert {
            margin-bottom: 22px;
            padding: 14px 16px;
            border-radius: 12px;
            font-size: 14px;
            line-height: 1.5;
        }

        .alert-error {
            color: #991b1b;
            border: 1px solid #fecaca;
            background: #fef2f2;
        }

        .alert-success {
            color: #166534;
            border: 1px solid #bbf7d0;
            background: #f0fdf4;
        }

        .empty-state {
            padding: 18px;
            border: 1px dashed #cbd5e1;
            border-radius: 12px;
            color: #64748b;
            background: #f8fafc;
            font-size: 14px;
            line-height: 1.6;
        }

        @media (max-width: 600px) {
            body {
                padding: 22px 13px;
            }

            .card {
                padding: 22px 17px;
            }

            h1 {
                font-size: 23px;
            }

            .header-icon {
                width: 54px;
                height: 54px;
            }

            .price-box {
                align-items: flex-start;
                flex-direction: column;
            }

            .actions, .btn {
                width: 100%;
            }
        }
    </style>
</head>

<body>
<div class="container">

    <a class="back-link"
       href="<%= request.getContextPath() %>/generaliste/dashboard">
        ← Retour au tableau de bord
    </a>

    <div class="header">
        <div class="header-icon">🩺</div>
        <div>
            <h1>Créer une consultation</h1>
            <p class="subtitle">
                Enregistrer une nouvelle consultation médicale pour un patient.
            </p>
        </div>
    </div>

    <div class="card">

        <h2 class="section-title">Informations de la consultation</h2>
        <p class="section-description">
            Sélectionnez le patient puis renseignez le motif et les observations médicales.
        </p>

        <% if ("1".equals(success)) { %>
            <div class="alert alert-success">
                ✓ Consultation enregistrée avec succès !
            </div>
        <% } %>

        <% if (erreur != null) { %>
            <div class="alert alert-error">
                ⚠ <%= erreur %>
            </div>
        <% } %>

        <% if (patients == null || patients.isEmpty()) { %>

            <div class="empty-state">
                Aucun patient enregistré pour le moment.
                Veuillez d'abord enregistrer un patient avant de créer une consultation.
            </div>

            <div class="actions">
                <a class="btn btn-secondary"
                   href="<%= request.getContextPath() %>/generaliste/dashboard">
                    Retour
                </a>
                <a class="btn btn-primary"
                   href="<%= request.getContextPath() %>/infirmier/ajouter-patient.jsp">
                    + Enregistrer un patient
                </a>
            </div>

        <% } else { %>

            <form method="post"
                  action="<%= request.getContextPath() %>/generaliste/consultation/creer">

                <div class="form-group">
                    <label for="patientId">
                        Patient <span class="required">*</span>
                    </label>

                    <select id="patientId" name="patientId" required>
                        <option value="">-- Sélectionner un patient --</option>

                        <% for (Patient p : patients) { %>
                            <option value="<%= p.getId() %>">
                                <%= p.getNom() %> <%= p.getPrenom() %>
                                — N° <%= p.getNumeroSecuriteSociale() %>
                            </option>
                        <% } %>
                    </select>

                    <p class="hint">
                        Choisissez un patient déjà enregistré dans le système.
                    </p>
                </div>

                <div class="form-group">
                    <label for="motif">
                        Motif de consultation <span class="required">*</span>
                    </label>

                    <input type="text"
                           id="motif"
                           name="motif"
                           maxlength="255"
                           placeholder="Ex. : douleurs abdominales, fièvre..."
                           required>
                </div>

                <div class="form-group">
                    <label for="observations">Observations médicales</label>

                    <textarea id="observations"
                              name="observations"
                              placeholder="Saisir les symptômes, les observations et les premières constatations médicales..."></textarea>

                    <p class="hint">
                        Champ facultatif. Vous pourrez compléter les informations selon les besoins.
                    </p>
                </div>

                <div class="price-box">
                    <div>
                        <p class="price-label">Coût de la consultation</p>
                        <p class="price-description">
                            Tarif fixe défini dans le cahier des charges.
                        </p>
                    </div>

                    <div class="price">150 DH</div>
                </div>

                <div class="actions">
                    <a class="btn btn-secondary"
                       href="<%= request.getContextPath() %>/generaliste/dashboard">
                        Annuler
                    </a>

                    <button type="submit" class="btn btn-primary">
                        ✓ Créer la consultation
                    </button>
                </div>

            </form>

        <% } %>

    </div>
</div>
</body>
</html>

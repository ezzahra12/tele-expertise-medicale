
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String patientId = request.getParameter("patientId");

    boolean patientIdValide = false;

    if (patientId != null && patientId.trim().matches("\\d+")) {
        patientId = patientId.trim();
        patientIdValide = true;
    } else {
        patientId = "";
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Télé-Expertise | Signes vitaux</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            background:
                radial-gradient(circle at 10% 20%, #dbeafe 0, transparent 30%),
                radial-gradient(circle at 90% 80%, #dcfce7 0, transparent 30%),
                #f8fafc;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px 18px;
            color: #172033;
        }

        .container {
            width: 100%;
            max-width: 850px;
            background: rgba(255, 255, 255, 0.96);
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            padding: 35px;
            box-shadow: 0 20px 50px rgba(15, 23, 42, 0.09);
        }

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
            width: 45px;
            height: 45px;
            border-radius: 13px;
            background: linear-gradient(135deg, #2563eb, #06b6d4);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 23px;
        }

        .brand h2 {
            font-size: 16px;
            color: #172033;
        }

        .brand span {
            display: block;
            color: #64748b;
            font-size: 12px;
            margin-top: 4px;
        }

        .header {
            margin-bottom: 25px;
        }

        .eyebrow {
            color: #2563eb;
            font-size: 11px;
            font-weight: bold;
            letter-spacing: 1.2px;
            margin-bottom: 9px;
        }

        .header h1 {
            color: #0f172a;
            font-size: 28px;
            margin-bottom: 9px;
        }

        .header p {
            color: #64748b;
            font-size: 14px;
            line-height: 1.6;
        }

        .info {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            background: #eff6ff;
            border: 1px solid #dbeafe;
            border-left: 4px solid #2563eb;
            padding: 15px 17px;
            border-radius: 12px;
            margin-bottom: 27px;
            color: #1e40af;
            font-size: 13px;
            line-height: 1.6;
        }

        .error {
            background: #fef2f2;
            border-left: 4px solid #dc2626;
            padding: 15px 18px;
            border-radius: 12px;
            margin-bottom: 25px;
            color: #991b1b;
            line-height: 1.6;
        }

        .section-title {
            font-size: 15px;
            font-weight: bold;
            color: #334155;
            margin-bottom: 18px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 22px 20px;
        }

        .field {
            display: flex;
            flex-direction: column;
        }

        .field label {
            margin-bottom: 9px;
            font-size: 13px;
            font-weight: 600;
            color: #334155;
        }

        .field input {
            padding: 13px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 11px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
            width: 100%;
            background: #fff;
        }

        .field input:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.10);
        }

        .optional {
            color: #94a3b8;
            font-size: 11px;
            margin-top: 7px;
        }

        .actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-top: 32px;
            padding-top: 23px;
            border-top: 1px solid #e2e8f0;
        }

        .btn {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            border: none;
            padding: 13px 20px;
            border-radius: 11px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: 0.2s;
        }

        .btn-primary {
            background: #2563eb;
            color: white;
        }

        .btn-primary:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }

        .btn-secondary {
            background: #fff;
            color: #475569;
            border: 1px solid #cbd5e1;
        }

        .btn-secondary:hover {
            background: #f1f5f9;
        }

        .footer {
            margin-top: 22px;
            text-align: center;
            font-size: 11px;
            color: #94a3b8;
        }

        @media (max-width: 650px) {
            .container {
                padding: 24px 20px;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 18px;
            }

            .header h1 {
                font-size: 24px;
            }

            .actions {
                flex-direction: column-reverse;
                align-items: stretch;
            }

            .btn {
                width: 100%;
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
    </div>

    <div class="header">
        <div class="eyebrow">ESPACE INFIRMIER</div>
        <h1>🩺 Signes vitaux</h1>
        <p>
            Enregistrez les constantes vitales du patient
            pour compléter son dossier médical.
        </p>
    </div>

    <% if (!patientIdValide) { %>

        <div class="error">
            L'identifiant du patient est absent ou invalide.
            Veuillez accéder à cette page depuis le dossier d'un patient.
        </div>

        <div class="actions">
            <a href="${pageContext.request.contextPath}/infirmier/recherche-patient.jsp"
               class="btn btn-secondary">
                ← Retour à la recherche
            </a>
        </div>

    <% } else { %>

        <div class="info">
            <span>ℹ️</span>
            <div>
                <strong>Informations importantes</strong><br>
                Tous les champs sont facultatifs.
                Vous pouvez renseigner les mesures disponibles.
                Les mesures déjà enregistrées doivent être conservées
                dans l'historique du patient.
            </div>
        </div>

        <div class="section-title">
            Constantes du patient
        </div>

        <form action="${pageContext.request.contextPath}/signe-vital/add"
              method="post">

            <input type="hidden"
                   name="patientId"
                   value="<%= patientId %>">

            <div class="form-grid">

                <div class="field">
                    <label for="tension">Tension artérielle</label>
                    <input type="text"
                           id="tension"
                           name="tension"
                           placeholder="Ex. : 120/80">
                    <span class="optional">Format : systolique / diastolique</span>
                </div>

                <div class="field">
                    <label for="frequenceCardiaque">
                        Fréquence cardiaque
                    </label>
                    <input type="number"
                           id="frequenceCardiaque"
                           name="frequenceCardiaque"
                           min="1"
                           step="1"
                           placeholder="Ex. : 75">
                    <span class="optional">Battements par minute (bpm)</span>
                </div>

                <div class="field">
                    <label for="temperature">Température</label>
                    <input type="number"
                           id="temperature"
                           name="temperature"
                           min="0"
                           step="0.1"
                           placeholder="Ex. : 37.2">
                    <span class="optional">Degrés Celsius (°C)</span>
                </div>

                <div class="field">
                    <label for="frequenceRespiratoire">
                        Fréquence respiratoire
                    </label>
                    <input type="number"
                           id="frequenceRespiratoire"
                           name="frequenceRespiratoire"
                           min="1"
                           step="1"
                           placeholder="Ex. : 16">
                    <span class="optional">Respirations par minute</span>
                </div>

                <div class="field">
                    <label for="poids">Poids</label>
                    <input type="number"
                           id="poids"
                           name="poids"
                           min="0.1"
                           step="0.1"
                           placeholder="Ex. : 65.5">
                    <span class="optional">Kilogrammes (kg)</span>
                </div>

                <div class="field">
                    <label for="taille">Taille</label>
                    <input type="number"
                           id="taille"
                           name="taille"
                           min="0.1"
                           step="0.01"
                           placeholder="Ex. : 1.70">
                    <span class="optional">Mètres (m)</span>
                </div>

            </div>

            <div class="actions">

                <a href="${pageContext.request.contextPath}/infirmier/recherche-patient.jsp"
                   class="btn btn-secondary">
                    ✕ Annuler
                </a>

                <button type="submit" class="btn btn-primary">
                    Enregistrer les signes vitaux →
                </button>

            </div>

        </form>

    <% } %>

    <div class="footer">
        Télé-Expertise Médicale · Espace professionnel
    </div>

</div>

</body>
</html>

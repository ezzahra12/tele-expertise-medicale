
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String patientId = request.getParameter("id");

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
    <title>Signes vitaux</title>

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
            padding: 30px;
        }

        .container {
            width: 100%;
            max-width: 850px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 25px;
            padding: 35px;
            box-shadow: 0 20px 50px rgba(15, 23, 42, 0.12);
        }

        .header {
            margin-bottom: 30px;
        }

        .header h1 {
            color: #0f172a;
            font-size: 28px;
            margin-bottom: 8px;
        }

        .header p {
            color: #64748b;
            font-size: 15px;
        }

        .info {
            background: #eff6ff;
            border-left: 4px solid #2563eb;
            padding: 15px 18px;
            border-radius: 12px;
            margin-bottom: 25px;
            color: #1e3a8a;
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

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .field {
            display: flex;
            flex-direction: column;
        }

        .field label {
            margin-bottom: 8px;
            font-weight: 600;
            color: #334155;
        }

        .field input {
            padding: 13px 15px;
            border: 1px solid #cbd5e1;
            border-radius: 12px;
            font-size: 15px;
            outline: none;
            transition: 0.2s;
            width: 100%;
        }

        .field input:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.10);
        }

        .actions {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
            gap: 15px;
        }

        .btn {
            border: none;
            padding: 13px 22px;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
        }

        .btn-primary {
            background: #2563eb;
            color: white;
            flex: 1;
        }

        .btn-primary:hover {
            background: #1d4ed8;
        }

        .btn-primary:disabled {
            background: #94a3b8;
            cursor: not-allowed;
        }

        .btn-secondary {
            background: #f1f5f9;
            color: #475569;
        }

        .btn-secondary:hover {
            background: #e2e8f0;
        }

        .optional {
            color: #94a3b8;
            font-size: 12px;
            margin-top: 5px;
        }

        @media (max-width: 650px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .container {
                padding: 25px;
            }

            .actions {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <div class="header">
        <h1>🩺 Signes vitaux</h1>
        <p>Ajouter les constantes vitales du patient</p>
    </div>

    <% if (!patientIdValide) { %>

        <div class="error">
            L'identifiant du patient est absent ou invalide.
            Veuillez accéder à cette page depuis le dossier d'un patient.
        </div>

        <div class="actions">
            <a href="${pageContext.request.contextPath}/infirmier/dashboard.jsp"
               class="btn btn-secondary">
                Retour au dashboard
            </a>
        </div>

    <% } else { %>

        <div class="info">
            Les signes vitaux sont facultatifs. Vous pouvez les ajouter
            maintenant ou passer cette étape.
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
                           placeholder="Ex : 120/80">
                    <span class="optional">Facultatif</span>
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
                           placeholder="Ex : 75">
                    <span class="optional">battements/minute</span>
                </div>

                <div class="field">
                    <label for="temperature">Température</label>
                    <input type="number"
                           step="0.1"
                           id="temperature"
                           name="temperature"
                           placeholder="Ex : 37.2">
                    <span class="optional">°C</span>
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
                           placeholder="Ex : 16">
                    <span class="optional">respirations/minute</span>
                </div>

                <div class="field">
                    <label for="poids">Poids</label>
                    <input type="number"
                           step="0.1"
                           id="poids"
                           name="poids"
                           min="0"
                           placeholder="Ex : 65">
                    <span class="optional">kg</span>
                </div>

                <div class="field">
                    <label for="taille">Taille</label>
                    <input type="number"
                           step="0.01"
                           id="taille"
                           name="taille"
                           min="0"
                           placeholder="Ex : 1.70">
                    <span class="optional">m</span>
                </div>

            </div>

            <div class="actions">

                <a href="${pageContext.request.contextPath}/infirmier/dashboard.jsp"
                   class="btn btn-secondary">
                    Passer
                </a>

                <button type="submit" class="btn btn-primary">
                    Enregistrer les signes vitaux
                </button>

            </div>

        </form>

    <% } %>

</div>

</body>
</html>
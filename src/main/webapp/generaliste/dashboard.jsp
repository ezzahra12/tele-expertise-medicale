
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Dashboard Médecin Généraliste</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: "Segoe UI", Arial, sans-serif;
            color: #1e293b;
            background:
                radial-gradient(circle at top left, #dbeafe, transparent 42%),
                radial-gradient(circle at bottom right, #d1fae5, transparent 40%),
                #f8fafc;
        }

        header {
            background: rgba(255, 255, 255, 0.9);
            padding: 22px 35px;
            border-bottom: 1px solid #e5eaf0;
            box-shadow: 0 4px 15px rgba(15, 23, 42, 0.03);
        }

        header h1 {
            margin: 0;
            font-size: 23px;
            color: #0f172a;
        }

        main {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .welcome {
            margin-bottom: 30px;
        }

        .welcome h2 {
            margin-bottom: 10px;
            font-size: 27px;
            color: #0f172a;
        }

        .welcome p {
            color: #64748b;
            line-height: 1.7;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 22px;
        }

        .card {
            display: block;
            background: rgba(255, 255, 255, 0.9);
            padding: 27px;
            border-radius: 18px;
            border: 1px solid rgba(255, 255, 255, 0.9);
            text-decoration: none;
            color: #243247;
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.05);
            transition: transform 0.2s, box-shadow 0.2s,
                        border-color 0.2s;
        }

        .card:hover {
            border-color: #93c5fd;
            transform: translateY(-4px);
            box-shadow: 0 15px 35px rgba(37, 99, 235, 0.10);
        }

        .icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 55px;
            height: 55px;
            margin-bottom: 20px;
            border-radius: 16px;
            background: linear-gradient(135deg, #2563eb, #06b6d4);
            font-size: 27px;
        }

        .card h2 {
            font-size: 18px;
            margin: 0 0 10px;
            color: #0f172a;
        }

        .card p {
            color: #64748b;
            line-height: 1.7;
            font-size: 14px;
            margin: 0 0 20px;
        }

        .card-action {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            color: #2563eb;
            font-size: 14px;
            font-weight: 700;
        }

        .card-primary {
            border-color: #bfdbfe;
            background: linear-gradient(
                145deg,
                rgba(239, 246, 255, 0.98),
                rgba(255, 255, 255, 0.95)
            );
        }

        .card-primary .icon {
            background: linear-gradient(135deg, #059669, #10b981);
        }

        .card-primary .card-action {
            color: #047857;
        }

        @media (max-width: 600px) {
            header {
                padding: 20px;
            }

            main {
                margin: 28px auto;
                padding: 0 15px;
            }

            .welcome h2 {
                font-size: 23px;
            }
        }
    </style>
</head>

<body>

<header>
    <h1>🩺 Espace Médecin Généraliste</h1>
</header>

<main>

    <section class="welcome">
        <h2>Bienvenue dans votre espace médical</h2>
        <p>
            Gérez les consultations, consultez les dossiers patients
            et suivez les demandes de télé-expertise.
        </p>
    </section>

    <section class="cards">

        <!-- Créer une consultation -->
        <a class="card card-primary"
           href="${pageContext.request.contextPath}/generaliste/consultation/creer">

            <div class="icon">➕</div>

            <h2>Créer une consultation</h2>

            <p>
                Sélectionner un patient, saisir le motif et les observations
                médicales. Coût fixe : 150 DH.
            </p>

            <span class="card-action">
                Nouvelle consultation →
            </span>
        </a>

        <!-- Patients -->
        <a class="card"
           href="${pageContext.request.contextPath}/generaliste/patients">

            <div class="icon">👥</div>

            <h2>Patients</h2>

            <p>
                Rechercher un patient et consulter son dossier médical
                ainsi que ses signes vitaux.
            </p>

            <span class="card-action">
                Consulter les patients →
            </span>
        </a>


<a href="${pageContext.request.contextPath}/generaliste/consultations"
   class="card">
    <div class="icon">📋</div>
    <h3>Liste des consultations</h3>
    <p>Consulter les patients, les motifs, les dates, les prix et les statuts.</p>
</a>


        <!-- Avis médicaux -->
        <a class="card"
           href="${pageContext.request.contextPath}/medecin/avis">

            <div class="icon">🩺</div>

            <h2>Avis médicaux</h2>

            <p>
                Consulter les avis médicaux et les recommandations
                des médecins spécialistes.
            </p>

            <span class="card-action">
                Consulter les avis →
            </span>
        </a>

    </section>

</main>

</body>
</html>

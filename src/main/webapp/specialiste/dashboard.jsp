
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Dashboard - Infirmier</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #f5f7fa;
            color: #333;
        }

        /* SIDEBAR */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 240px;
            height: 100vh;
            background-color: #ffffff;
            border-right: 1px solid #e5e7eb;
            padding: 25px 15px;
        }

        .logo {
            font-size: 21px;
            font-weight: bold;
            color: #2563eb;
            margin-bottom: 40px;
            padding-left: 10px;
        }

        .menu a {
            display: block;
            text-decoration: none;
            color: #555;
            padding: 13px 15px;
            margin-bottom: 8px;
            border-radius: 8px;
            transition: 0.2s;
        }

        .menu a:hover,
        .menu a.active {
            background-color: #eff6ff;
            color: #2563eb;
        }

        /* MAIN */
        .main {
            margin-left: 240px;
            padding: 30px;
        }

        /* HEADER */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .header h1 {
            font-size: 27px;
            margin-bottom: 7px;
        }

        .header p {
            color: #777;
        }

        .user {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background-color: #2563eb;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        /* CARDS */
        .cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background-color: white;
            padding: 25px;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
        }

        .card-title {
            color: #777;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .card-number {
            font-size: 30px;
            font-weight: bold;
            color: #222;
        }

        /* ACTIONS */
        .section-title {
            font-size: 20px;
            margin-bottom: 15px;
        }

        .actions {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .action {
            background-color: white;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 25px;
            text-decoration: none;
            color: #333;
            transition: 0.2s;
        }

        .action:hover {
            border-color: #2563eb;
            transform: translateY(-2px);
        }

        .action-icon {
            font-size: 30px;
            margin-bottom: 15px;
        }

        .action h3 {
            margin-bottom: 8px;
        }

        .action p {
            color: #777;
            font-size: 14px;
        }

        /* RESPONSIVE */
        @media (max-width: 900px) {
            .cards,
            .actions {
                grid-template-columns: 1fr;
            }

            .sidebar {
                width: 200px;
            }

            .main {
                margin-left: 200px;
            }
        }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">

    <div class="logo">
        Télé-Expertise
    </div>

    <div class="menu">

        <a href="#" class="active">
            🏠 Dashboard
        </a>

        <a href="#">
            👤 Ajouter un patient
        </a>

        <a href="#">
            👥 Patients du jour
        </a>

        <a href="#">
            🕐 File d'attente
        </a>

        <a href="#">
            📋 Consultations
        </a>

        <a href="#">
            ⚙️ Mon profil
        </a>

        <a href="${pageContext.request.contextPath}/logout">
            🚪 Déconnexion
        </a>

    </div>

</div>


<!-- MAIN CONTENT -->
<div class="main">

    <!-- HEADER -->
    <div class="header">

        <div>
            <h1>Bonjour 👋</h1>
            <p>Bienvenue dans votre espace infirmier.</p>
        </div>

        <div class="user">

            <div>
                <strong>Infirmier</strong>
                <br>
                <small>Personnel médical</small>
            </div>

            <div class="avatar">
                I
            </div>

        </div>

    </div>


    <!-- STATISTICS -->
    <div class="cards">

        <div class="card">

            <div class="card-title">
                Patients aujourd'hui
            </div>

            <div class="card-number">
                12
            </div>

        </div>


        <div class="card">

            <div class="card-title">
                Patients en attente
            </div>

            <div class="card-number">
                5
            </div>

        </div>


        <div class="card">

            <div class="card-title">
                Patients pris en charge
            </div>

            <div class="card-number">
                7
            </div>

        </div>

    </div>


    <!-- QUICK ACTIONS -->
    <h2 class="section-title">
        Actions rapides
    </h2>

    <div class="actions">

        <a href="#" class="action">

            <div class="action-icon">
                ➕
            </div>

            <h3>
                Ajouter un patient
            </h3>

            <p>
                Enregistrer un nouveau patient
                et saisir ses signes vitaux.
            </p>

        </a>


        <a href="#" class="action">

            <div class="action-icon">
                👥
            </div>

            <h3>
                Patients du jour
            </h3>

            <p>
                Consulter la liste des patients
                enregistrés aujourd'hui.
            </p>

        </a>


        <a href="#" class="action">

            <div class="action-icon">
                🕐
            </div>

            <h3>
                File d'attente
            </h3>

            <p>
                Consulter les patients
                actuellement en attente.
            </p>

        </a>

    </div>

</div>

</body>
</html>


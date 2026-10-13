
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Télé-Expertise | Infirmier</title>

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
            overflow: hidden;
        }

        .circle {
            position: fixed;
            border-radius: 50%;
            filter: blur(2px);
            z-index: -1;
        }

        .circle-one {
            width: 150px;
            height: 150px;
            background: #bfdbfe;
            top: -60px;
            left: -60px;
            opacity: 0.6;
        }

        .circle-two {
            width: 180px;
            height: 180px;
            background: #a7f3d0;
            bottom: -80px;
            right: -60px;
            opacity: 0.6;
        }

        .container {
            width: 88%;
            max-width: 1050px;
            margin: auto;
            padding: 28px 0;
        }

        /* TOP */

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
            margin-top: 2px;
        }

        .logout {
            text-decoration: none;
            color: #64748b;
            font-size: 13px;
            padding: 8px 14px;
            border-radius: 9px;
            background: rgba(255,255,255,0.7);
            border: 1px solid #e2e8f0;
        }

        /* WELCOME */

        .welcome {
            margin-bottom: 24px;
        }

        .welcome .small {
            color: #2563eb;
            font-size: 11px;
            font-weight: bold;
            letter-spacing: 1px;
            margin-bottom: 6px;
        }

        .welcome h1 {
            font-size: 30px;
            margin-bottom: 6px;
        }

        .welcome h1 span {
            color: #2563eb;
        }

        .welcome p {
            color: #64748b;
            font-size: 13px;
        }

        /* CARDS */

        .cards {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
        }

        .card {
            position: relative;
            overflow: hidden;

            background: rgba(255,255,255,0.82);
            backdrop-filter: blur(10px);

            border: 1px solid rgba(255,255,255,0.9);
            border-radius: 18px;

            padding: 22px;

            min-height: 190px;

            text-decoration: none;
            color: #172033;

            box-shadow: 0 8px 25px rgba(15, 23, 42, 0.06);

            transition: all 0.25s ease;
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 30px rgba(15, 23, 42, 0.11);
        }

        .card-number {
            position: absolute;
            right: 20px;
            top: 15px;
            font-size: 11px;
            color: #94a3b8;
            font-weight: bold;
        }

        .icon {
            width: 48px;
            height: 48px;
            border-radius: 13px;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 21px;
            margin-bottom: 15px;
        }

        .blue {
            background: #dbeafe;
        }

        .green {
            background: #d1fae5;
        }

        .purple {
            background: #ede9fe;
        }

        .orange {
            background: #ffedd5;
        }

        .card h2 {
            font-size: 17px;
            margin-bottom: 7px;
        }

        .card p {
            color: #64748b;
            font-size: 12px;
            line-height: 1.5;
            max-width: 350px;
        }

        .arrow {
            position: absolute;
            right: 20px;
            bottom: 18px;

            width: 30px;
            height: 30px;

            border-radius: 50%;
            background: #f1f5f9;

            display: flex;
            align-items: center;
            justify-content: center;

            color: #2563eb;

            transition: 0.25s;
        }

        .card:hover .arrow {
            background: #2563eb;
            color: white;
            transform: translateX(3px);
        }

        /* FOOTER */

        .footer {
            text-align: center;
            margin-top: 22px;
            color: #94a3b8;
            font-size: 10px;
        }

        /* PETITS ÉCRANS */

        @media (max-width: 750px) {

            body {
                overflow-y: auto;
            }

            .container {
                width: 92%;
                padding: 25px 0;
            }

            .cards {
                grid-template-columns: 1fr;
            }

            .welcome h1 {
                font-size: 26px;
            }
        }
    </style>

</head>


<body>


<div class="circle circle-one"></div>
<div class="circle circle-two"></div>


<div class="container">


    <!-- TOP -->

    <div class="top">

        <div class="brand">

            <div class="brand-icon">
                ✚
            </div>

            <div>

                <h2>
                    Télé-Expertise
                </h2>

                <span>
                    Plateforme médicale
                </span>

            </div>

        </div>


        <a
            href="${pageContext.request.contextPath}/logout"
            class="logout">

            Déconnexion →

        </a>

    </div>


    <!-- WELCOME -->

    <div class="welcome">

        <div class="small">
            ESPACE INFIRMIER
        </div>

        <h1>
            Bonjour, bienvenue <span>👋</span>
        </h1>

        <p>
            Gérez les patients et leur parcours
            de prise en charge en toute simplicité.
        </p>

    </div>


    <!-- ACTIONS -->

    <div class="cards">


        <!-- CARD 01 -->

        <a
            href="recherche-patient.jsp"
            class="card">

            <span class="card-number">
                01
            </span>

            <div class="icon blue">
                🔎
            </div>

            <h2>
                Rechercher un patient
            </h2>

            <p>
                Retrouvez rapidement un patient
                grâce à son numéro de sécurité sociale.
            </p>

            <div class="arrow">
                →
            </div>

        </a>


        <!-- CARD 02 -->

        <a
            href="ajouter-patient.jsp"
            class="card">

            <span class="card-number">
                02
            </span>

            <div class="icon green">
                👤
            </div>

            <h2>
                Enregistrer un patient
            </h2>

            <p>
                Créez le dossier d'un nouveau patient
                et renseignez ses signes vitaux.
            </p>

            <div class="arrow">
                →
            </div>

        </a>


        <!-- CARD 03 -->

        <a
             href="${pageContext.request.contextPath}/infirmier/patients-du-jour"
            class="card">

            <span class="card-number">
                03
            </span>

            <div class="icon purple">
                👥
            </div>

            <h2>
                Patients du jour
            </h2>

            <p>
                Consultez les patients enregistrés
                au cours de la journée.
            </p>

            <div class="arrow">
                →
            </div>

        </a>



        <!-- CARD 04 -->

        <a
            href="${pageContext.request.contextPath}/infirmier/file-attente"
            class="card">

            <span class="card-number">
                04
            </span>

            <div class="icon orange">
                🕐
            </div>

            <h2>
                File d'attente
            </h2>

            <p>
                Consultez les patients en attente
                de prise en charge.
            </p>

            <div class="arrow">
                →
            </div>

        </a>



    </div>


    <div class="footer">

        Télé-Expertise Médicale · Espace professionnel

    </div>


</div>


</body>

</html>


<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Enregistrer un patient</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            height: 100vh;
            overflow: hidden;

            background:
                radial-gradient(circle at 10% 20%, #dbeafe 0, transparent 30%),
                radial-gradient(circle at 90% 80%, #d1fae5 0, transparent 30%),
                #f8fafc;

            color: #172033;
        }

        /* =========================
           BACKGROUND
        ========================= */

        .circle {
            position: fixed;
            border-radius: 50%;
            filter: blur(2px);
            z-index: -1;
        }

        .circle-one {
            width: 180px;
            height: 180px;
            background: #bfdbfe;
            top: -70px;
            left: -70px;
            opacity: .6;
        }

        .circle-two {
            width: 220px;
            height: 220px;
            background: #a7f3d0;
            bottom: -100px;
            right: -80px;
            opacity: .6;
        }

        /* =========================
           CONTAINER
        ========================= */

        .container {
            width: 92%;
            max-width: 1000px;
            height: 100vh;
            margin: auto;
            padding: 25px 0;
        }

        /* =========================
           TOP
        ========================= */

        .top {
            display: flex;
            align-items: center;
            justify-content: space-between;

            margin-bottom: 18px;
        }

        .back {
            text-decoration: none;
            color: #64748b;
            font-size: 13px;

            padding: 9px 15px;

            border-radius: 9px;

            background: rgba(255,255,255,.80);
            border: 1px solid #e2e8f0;

            transition: .2s;
        }

        .back:hover {
            color: #2563eb;
            background: white;
            transform: translateX(-2px);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 11px;
        }

        .brand-icon {
            width: 42px;
            height: 42px;

            border-radius: 12px;

            display: flex;
            align-items: center;
            justify-content: center;

            color: white;
            font-size: 20px;

            background: linear-gradient(
                    135deg,
                    #2563eb,
                    #06b6d4
            );

            box-shadow: 0 7px 18px rgba(37,99,235,.22);
        }

        .brand h2 {
            font-size: 17px;
        }

        .brand span {
            display: block;

            color: #64748b;
            font-size: 11px;

            margin-top: 3px;
        }

        /* =========================
           TITLE
        ========================= */

        .title {
            margin-bottom: 18px;
        }

        .title small {
            color: #2563eb;

            font-size: 11px;
            font-weight: bold;

            letter-spacing: 1px;
        }

        .title h1 {
            font-size: 28px;

            margin-top: 5px;
            margin-bottom: 6px;
        }

        .title p {
            color: #64748b;
            font-size: 13px;
        }

        /* =========================
           FORM CARD
        ========================= */

        .form-card {
            background: rgba(255,255,255,.90);

            backdrop-filter: blur(12px);

            border: 1px solid rgba(255,255,255,.95);

            border-radius: 20px;

            padding: 26px;

            box-shadow:
                0 12px 35px rgba(15,23,42,.08);
        }

        /* =========================
           SECTION TITLE
        ========================= */

        .section-title {
            display: flex;
            align-items: center;

            gap: 11px;

            margin-bottom: 18px;
        }

        .section-icon {
            width: 38px;
            height: 38px;

            border-radius: 10px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #dbeafe;

            font-size: 18px;
        }

        .section-title h2 {
            font-size: 16px;
        }

        .section-title p {
            color: #94a3b8;

            font-size: 11px;

            margin-top: 3px;
        }

        /* =========================
           FORM
        ========================= */

        .form-grid {
            display: grid;

            grid-template-columns:
                    repeat(2, 1fr);

            gap: 15px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full {
            grid-column: span 2;
        }

        label {
            font-size: 12px;

            font-weight: bold;

            margin-bottom: 6px;

            color: #334155;
        }

        label span {
            color: #ef4444;
        }

        input {
            width: 100%;

            padding: 11px 13px;

            border: 1px solid #e2e8f0;

            border-radius: 9px;

            background: #f8fafc;

            outline: none;

            font-size: 13px;

            color: #172033;

            transition: .2s;
        }

        input:hover {
            border-color: #cbd5e1;
        }

        input:focus {
            border-color: #60a5fa;

            background: white;

            box-shadow:
                0 0 0 3px
                rgba(37,99,235,.08);
        }

        input::placeholder {
            color: #94a3b8;
        }

        /* =========================
           SECURITY NUMBER
        ========================= */

        .security-box {
            position: relative;
        }

        .security-box input {
            padding-left: 40px;
        }

        .security-icon {
            position: absolute;

            left: 13px;
            top: 50%;

            transform: translateY(-50%);

            font-size: 15px;

            pointer-events: none;
        }

        /* =========================
           REQUIRED
        ========================= */

        .required-info {
            margin-top: 11px;

            color: #94a3b8;

            font-size: 10px;
        }

        /* =========================
           ACTIONS
        ========================= */

        .actions {
            display: flex;

            justify-content: flex-end;

            gap: 10px;

            margin-top: 20px;

            padding-top: 15px;

            border-top: 1px solid #eef2f7;
        }

        .cancel {
            text-decoration: none;

            padding: 10px 18px;

            border-radius: 9px;

            color: #64748b;

            font-size: 13px;

            background: #f1f5f9;

            transition: .2s;
        }

        .cancel:hover {
            background: #e2e8f0;
        }

        .submit {
            border: none;

            padding: 10px 20px;

            border-radius: 9px;

            color: white;

            font-size: 13px;

            font-weight: bold;

            cursor: pointer;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #06b6d4
                );

            box-shadow:
                0 7px 17px
                rgba(37,99,235,.22);

            transition: .2s;
        }

        .submit:hover {
            transform: translateY(-2px);

            box-shadow:
                0 10px 22px
                rgba(37,99,235,.28);
        }

        /* =========================
           MOBILE
        ========================= */

        @media (max-width: 700px) {

            body {
                overflow: auto;
            }

            .container {
                width: 92%;
                height: auto;

                padding: 15px 0;
            }

            .top {
                margin-bottom: 15px;
            }

            .title h1 {
                font-size: 23px;
            }

            .form-card {
                padding: 18px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-group.full {
                grid-column: span 1;
            }

            .actions {
                flex-direction: column;
            }

            .cancel,
            .submit {
                width: 100%;
                text-align: center;
            }
        }

    </style>

</head>


<body>

<div class="circle circle-one"></div>
<div class="circle circle-two"></div>


<div class="container">

    <!-- =========================
         TOP
    ========================= -->

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
                    Espace infirmier
                </span>

            </div>

        </div>


        <a
                href="${pageContext.request.contextPath}/infirmier/dashboard.jsp"
                class="back">

            ← Retour

        </a>

    </div>


    <!-- =========================
         TITLE
    ========================= -->

    <div class="title">

        <small>
            ESPACE INFIRMIER
        </small>

        <h1>
            Enregistrer un patient
        </h1>

        <p>
            Créez le dossier du patient avant sa prise en charge.
        </p>

    </div>


    <!-- =========================
         FORM CARD
    ========================= -->

    <div class="form-card">


        <div class="section-title">

            <div class="section-icon">
                👤
            </div>

            <div>

                <h2>
                    Informations du patient
                </h2>

                <p>
                    Veuillez renseigner les informations demandées.
                </p>

            </div>

        </div>


        <!-- FORM -->

        <form
                action="${pageContext.request.contextPath}/patient/add"
                method="post">


            <div class="form-grid">


                <!-- NOM -->

                <div class="form-group">

                    <label>
                        Nom <span>*</span>
                    </label>

                    <input
                            type="text"
                            name="nom"
                            placeholder="Ex : Alaoui"
                            required>

                </div>


                <!-- PRENOM -->

                <div class="form-group">

                    <label>
                        Prénom <span>*</span>
                    </label>

                    <input
                            type="text"
                            name="prenom"
                            placeholder="Ex : Sara"
                            required>

                </div>


                <!-- DATE NAISSANCE -->

                <div class="form-group">

                    <label>
                        Date de naissance
                    </label>

                    <input
                            type="date"
                            name="dateNaissance">

                </div>


                <!-- TELEPHONE -->

                <div class="form-group">

                    <label>
                        Téléphone
                    </label>

                    <input
                            type="tel"
                            name="telephone"
                            placeholder="Ex : 0612345678">

                </div>


                <!-- SECURITE SOCIALE -->

                <div class="form-group full">

                    <label>
                        Numéro de sécurité sociale
                        <span>*</span>
                    </label>

                    <div class="security-box">

                        <span class="security-icon">
                            🔐
                        </span>

                        <input
                                type="text"
                                name="numeroSecuriteSociale"
                                placeholder="Entrez le numéro de sécurité sociale"
                                required>

                    </div>

                </div>


                <!-- ADRESSE -->

                <div class="form-group full">

                    <label>
                        Adresse
                    </label>

                    <input
                            type="text"
                            name="adresse"
                            placeholder="Ex : Safi, Maroc">

                </div>


            </div>


            <!-- REQUIRED -->

            <div class="required-info">
                * Champs obligatoires
            </div>


            <!-- ACTIONS -->

            <div class="actions">

                <a
                        href="${pageContext.request.contextPath}/infirmier/dashboard.jsp"
                        class="cancel">

                    Annuler

                </a>


                <button
                        type="submit"
                        class="submit">

                    ✓ Enregistrer le patient

                </button>

            </div>


        </form>

    </div>

</div>

</body>

</html>
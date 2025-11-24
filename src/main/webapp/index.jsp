<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Controle de Estoque WEB - Início</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* Estilo extra apenas para a página inicial ficar mais bonita */
        .welcome-banner {
            text-align: center;
            padding: 40px 20px;
            background: linear-gradient(135deg, #0054a6 0%, #003d7a 100%);
            color: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            margin-bottom: 40px;
        }
        .welcome-banner h1 { color: white; font-size: 2.2rem; margin-bottom: 10px; }
        .welcome-banner p { font-size: 1.1rem; opacity: 0.9; }

        /* Ajuste dos cartões do menu */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            list-style: none;
            padding: 0;
        }
        .menu-card {
            background: white;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            transition: transform 0.2s, box-shadow 0.2s;
            border-top: 5px solid #eee;
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        .menu-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        .menu-card h3 {
            color: #333;
            font-size: 1.3rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .menu-card ul {
            list-style: none;
            padding: 0;
            margin-top: auto; /* Empurra os links para baixo se o card crescer */
        }
        .menu-card li {
            margin-bottom: 10px;
            border-bottom: 1px solid #f0f0f0;
            padding-bottom: 5px;
        }
        .menu-card li:last-child { border-bottom: none; }
        .menu-card a {
            color: #555;
            font-weight: 500;
            display: block;
            padding: 5px;
            border-radius: 4px;
            transition: background 0.2s, color 0.2s;
        }
        .menu-card a:hover {
            background-color: #f4f7f6;
            color: #0054a6; /* Azul da identidade */
            padding-left: 10px;
        }

        /* Cores específicas para os topos dos cards */
        .card-cadastros { border-top-color: #0054a6; } /* Azul */
        .card-operacoes { border-top-color: #28a745; } /* Verde */
        .card-relatorios { border-top-color: #ffc107; } /* Amarelo/
    </style>
</head>
<body>

<nav>
    <div class="nav-logo">
        <a href="${pageContext.request.contextPath}/index.jsp" title="Recarregar Início">
            <img src="${pageContext.request.contextPath}/img/logo_unisul.png" alt="Logo UNISUL">
        </a>
    </div>
    <button class="menu-toggle" onclick="toggleMenu()">&#8942;</button>
    <div class="nav-links" id="menuSuspenso">
        <a href="${pageContext.request.contextPath}/produto?acao=listar">📦 Produtos</a>
        <a href="${pageContext.request.contextPath}/categoria?acao=listar">🏷️ Categorias</a>
        <a href="${pageContext.request.contextPath}/movimentacao?acao=listar">🚚 Movimentações</a>
        <a href="${pageContext.request.contextPath}/relatorio?acao=menu">📊 Relatórios</a>
    </div>
</nav>

<div class="container-principal">

    <div class="welcome-banner">
        <h1>Sistema de Controle de Estoque</h1>
        <p>Gerencie seus produtos, categorias e movimentações com agilidade e precisão.</p>
    </div>

    <ul class="menu-grid">

        <li class="menu-card card-cadastros">
            <h3>📦 Cadastros</h3>
            <p style="color: #777; font-size: 0.9rem; margin-bottom: 15px;">
                Mantenha a base de dados organizada.
            </p>
            <ul>
                <li><a href="${pageContext.request.contextPath}/categoria?acao=listar">🏷️ Gerenciar Categorias</a></li>
                <li><a href="${pageContext.request.contextPath}/produto?acao=listar">📦 Gerenciar Produtos</a></li>
            </ul>
        </li>

        <li class="menu-card card-operacoes">
            <h3>🚚 Operações</h3>
            <p style="color: #777; font-size: 0.9rem; margin-bottom: 15px;">
                Registre o fluxo do dia a dia.
            </p>
            <ul>
                <li><a href="${pageContext.request.contextPath}/movimentacao?acao=listar">📋 Registrar Movimentação</a></li>
                <li><a href="${pageContext.request.contextPath}/produto?acao=reajuste">💲 Reajuste de Preços</a></li>
            </ul>
        </li>

        <li class="menu-card card-relatorios">
            <h3>📊 Inteligência</h3>
            <p style="color: #777; font-size: 0.9rem; margin-bottom: 15px;">
                Visualize dados para tomada de decisão.
            </p>
            <ul>
                <li><a href="${pageContext.request.contextPath}/relatorio?acao=menu">📈 Central de Relatórios</a></li>
            </ul>
        </li>

    </ul>

    <hr style="margin-top: 50px; border: 0; border-top: 1px solid #eee;">

    <p style="text-align: center; color: #aaa; font-size: 0.85rem; margin-top: 20px;">
        Unidade Curricular: Usabilidade e Desenvolvimento WEB • A3
    </p>

</div>

<footer>
    Controlador de Estoque da A3 - Juan Natan
</footer>

<script>
    function toggleMenu() {
        document.getElementById("menuSuspenso").classList.toggle("show");
    }
    window.onclick = function(e) {
        if (!e.target.matches('.menu-toggle')) {
            var menu = document.getElementById("menuSuspenso");
            if (menu.classList.contains('show')) menu.classList.remove('show');
        }
    }
</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Central de Relatórios</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* --- Estilos Específicos para o Dashboard de Relatórios --- */

        /* Grid para organizar os relatórios */
        .report-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            list-style: none;
            padding: 0;
            margin-top: 30px;
        }

        /* Cartão do Relatório */
        .report-card {
            background: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            transition: transform 0.2s, box-shadow 0.2s;
            border-top: 5px solid #ccc; /* Cor padrão */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
            text-align: center; /* Centraliza texto e botão */
        }

        .report-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .report-card h3 {
            color: #333;
            font-size: 1.4rem;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .report-card p {
            color: #666;
            font-size: 0.95rem;
            margin-bottom: 25px;
            line-height: 1.5;
        }

        /* Botão dentro do card */
        .report-card .btn-ver {
            display: inline-block;
            width: 100%;
            padding: 12px 0;
            background-color: #f8f9fa;
            color: #333;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-weight: 600;
            transition: all 0.2s;
            text-decoration: none;
        }

        .report-card .btn-ver:hover {
            background-color: #e2e6ea;
            border-color: #adb5bd;
            color: #000;
        }

        /* --- Cores Temáticas para cada Relatório --- */

        /* Lista de Preços (Azul) */
        .card-precos { border-top-color: #0054a6; }
        .card-precos h3::before { content: '🏷️ '; display: block; font-size: 2.5rem; margin-bottom: 10px; }
        .card-precos .btn-ver:hover { background-color: #0054a6; color: white; border-color: #0054a6; }

        /* Balanço (Verde Dinheiro) */
        .card-balanco { border-top-color: #28a745; }
        .card-balanco h3::before { content: '💰 '; display: block; font-size: 2.5rem; margin-bottom: 10px; }
        .card-balanco .btn-ver:hover { background-color: #28a745; color: white; border-color: #28a745; }

        /* Estoque Mínimo (Vermelho Alerta) */
        .card-minimo { border-top-color: #dc3545; }
        .card-minimo h3::before { content: '🚨 '; display: block; font-size: 2.5rem; margin-bottom: 10px; }
        .card-minimo .btn-ver { color: #dc3545; border-color: #f5c6cb; background-color: #fff5f5; }
        .card-minimo .btn-ver:hover { background-color: #dc3545; color: white; border-color: #dc3545; }

        /* Por Categoria (Roxo/Azul Escuro) */
        .card-categoria { border-top-color: #6f42c1; }
        .card-categoria h3::before { content: '📦 '; display: block; font-size: 2.5rem; margin-bottom: 10px; }
        .card-categoria .btn-ver:hover { background-color: #6f42c1; color: white; border-color: #6f42c1; }

        /* Mais Movimentados (Laranja/Gráfico) */
        .card-mov { border-top-color: #fd7e14; }
        .card-mov h3::before { content: '📈 '; display: block; font-size: 2.5rem; margin-bottom: 10px; }
        .card-mov .btn-ver:hover { background-color: #fd7e14; color: white; border-color: #fd7e14; }

    </style>
</head>
<body>

<nav>
    <div class="nav-logo">
        <a href="${pageContext.request.contextPath}/index.jsp" title="Voltar ao Início">
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

    <div class="page-header">
        <span class="page-label">Central de Inteligência</span>
    </div>

    <h1>📊 Relatórios Gerenciais</h1>

    <p style="color: #666; font-size: 1.1rem; margin-bottom: 40px;">
        Selecione um indicador abaixo para visualizar os dados detalhados do seu estoque.
    </p>

    <div class="report-grid">

        <div class="report-card card-precos">
            <div>
                <h3>Lista de Preços</h3>
                <p>Visualize o catálogo completo com preços unitários e unidades de medida de todos os itens.</p>
            </div>
            <a href="${pageContext.request.contextPath}/relatorio?acao=lista_precos" class="btn-ver">Acessar Catálogo</a>
        </div>

        <div class="report-card card-balanco">
            <div>
                <h3>Balanço Financeiro</h3>
                <p>Analise o valor total investido em estoque e o valor individual acumulado por produto.</p>
            </div>
            <a href="${pageContext.request.contextPath}/relatorio?acao=balanco" class="btn-ver">Ver Balanço</a>
        </div>

        <div class="report-card card-minimo">
            <div>
                <h3>Reposição Urgente</h3>
                <p>Identifique produtos que estão abaixo do nível mínimo e precisam de compra imediata.</p>
            </div>
            <a href="${pageContext.request.contextPath}/relatorio?acao=estoque_minimo" class="btn-ver">Ver Alertas ⚠️</a>
        </div>

        <div class="report-card card-categoria">
            <div>
                <h3>Por Categoria</h3>
                <p>Veja a distribuição do seu mix de produtos agrupados por categorias e tamanhos.</p>
            </div>
            <a href="${pageContext.request.contextPath}/relatorio?acao=produtos_por_categoria" class="btn-ver">Ver Grupos</a>
        </div>

        <div class="report-card card-mov">
            <div>
                <h3>Fluxo de Movimentação</h3>
                <p>Descubra quais são os produtos campeões de entrada (compras) e saída (vendas).</p>
            </div>
            <a href="${pageContext.request.contextPath}/relatorio?acao=mais_movimentado" class="btn-ver">Ver Destaques</a>
        </div>

    </div>

    <div style="margin-top: 50px; text-align: center;">
        <a href="${pageContext.request.contextPath}/index.jsp" style="font-weight: bold; color: #666;">🏠 Voltar ao Início</a>
    </div>

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
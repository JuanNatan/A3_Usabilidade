<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Relatório: Produto Mais Movimentado</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* Estilo específico para os cards de destaque deste relatório */
        .destaque-card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            padding: 25px;
            margin-bottom: 25px;
            border-left: 5px solid #ccc;
        }
        .destaque-entrada { border-left-color: #28a745; }
        .destaque-saida { border-left-color: #dc3545; }

        .card-titulo { font-size: 1.1rem; font-weight: bold; margin-bottom: 10px; display: block; }
        .produto-nome { font-size: 1.5rem; color: #333; font-weight: 700; }
        .produto-cat { color: #666; font-style: italic; margin-bottom: 10px; }
    </style>
</head>
<body>

<nav>
    <div class="nav-logo">
        <a href="${pageContext.request.contextPath}/index.jsp">
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
        <span class="page-label">Relatório: Fluxo</span>
    </div>

    <h1>📈 Produto Mais Movimentado</h1>

    <p style="margin-bottom: 25px; color: #666;">
        Identificação dos produtos que tiveram o maior volume de movimentação (Entrada e Saída) no período.
    </p>

    <div style="margin-bottom: 20px;">
        <a href="${pageContext.request.contextPath}/relatorio?acao=menu" class="btn-acao" style="background-color: #6c757d;">
            ⬅ Voltar ao Menu de Relatórios
        </a>
    </div>

    <div class="destaque-card destaque-entrada">
        <span class="card-titulo" style="color: #28a745;">📥 Maior Volume de Compras (Entrada)</span>

        <c:if test="${maisEntrada != null}">
            <div class="produto-nome"><c:out value="${maisEntrada.nome}" /></div>
            <div class="produto-cat">Categoria: <c:out value="${maisEntrada.nomeCategoria}" /></div>
            <p style="color: #155724; background-color: #d4edda; padding: 10px; border-radius: 4px; display: inline-block;">
                ✅ Este foi o produto mais reabastecido no estoque.
            </p>
        </c:if>
        <c:if test="${maisEntrada == null}">
            <p style="color: #666;">Nenhuma entrada registrada no sistema ainda.</p>
        </c:if>
    </div>

    <div class="destaque-card destaque-saida">
        <span class="card-titulo" style="color: #dc3545;">📤 Maior Volume de Vendas (Saída)</span>

        <c:if test="${maisSaida != null}">
            <div class="produto-nome"><c:out value="${maisSaida.nome}" /></div>
            <div class="produto-cat">Categoria: <c:out value="${maisSaida.nomeCategoria}" /></div>
            <p style="color: #721c24; background-color: #f8d7da; padding: 10px; border-radius: 4px; display: inline-block;">
                🔥 Este é o produto com maior saída do estoque.
            </p>
        </c:if>
        <c:if test="${maisSaida == null}">
            <p style="color: #666;">Nenhuma saída registrada no sistema ainda.</p>
        </c:if>
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
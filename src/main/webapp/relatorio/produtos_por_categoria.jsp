<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Relatório: Produtos por Categoria</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
        <span class="page-label">Relatório: Categorias</span>
    </div>

    <h1>📦 Contagem de Produtos por Categoria</h1>

    <p style="margin-bottom: 20px; color: #666;">
        Quantidade de produtos distintos cadastrados em cada categoria do sistema.
    </p>

    <div style="margin-bottom: 20px;">
        <a href="${pageContext.request.contextPath}/relatorio?acao=menu" class="btn-acao" style="background-color: #6c757d;">
            ⬅ Voltar ao Menu de Relatórios
        </a>
    </div>

    <table border="1">
        <thead>
        <tr>
            <th>Nome da Categoria</th>
            <th>Quantidade de Produtos Distintos</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="entry" items="${contagemCategorias}">
            <tr>
                <td style="font-weight: 500; color: var(--text-dark);">
                    <c:out value="${entry.key}" />
                </td>
                <td style="text-align: right; font-weight: bold; color: #0054a6;">
                    <c:out value="${entry.value}" /> item(ns)
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

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
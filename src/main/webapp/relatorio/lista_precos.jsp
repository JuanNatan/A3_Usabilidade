<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Relatório: Lista de Preços</title>
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
        <span class="page-label">Relatório de Preços</span>
    </div>

    <h1>🏷️ Lista de Preços</h1>

    <p style="margin-bottom: 20px; color: #666;">
        Relação completa dos produtos em estoque com seus respectivos preços e categorias.
    </p>

    <div style="margin-bottom: 20px;">
        <a href="${pageContext.request.contextPath}/relatorio?acao=menu" class="btn-acao" style="background-color: #6c757d;">
            ⬅ Voltar ao Menu de Relatórios
        </a>
    </div>

    <c:if test="${listaProdutos.size() > 0}">
        <table border="1">
            <thead>
            <tr>
                <th>Produto</th>
                <th>Preço Unitário</th>
                <th>Unidade Medida</th>
                <th>Categoria</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="prod" items="${listaProdutos}">
                <tr>
                    <td style="font-weight: 500; color: var(--text-dark);">
                        <c:out value="${prod.nome}" />
                    </td>
                    <td style="text-align: right; font-weight: bold; color: #0054a6;">
                        <fmt:formatNumber value="${prod.precoUnitario}" type="currency" currencySymbol="R$" />
                    </td>
                    <td style="text-align: center; color: #666;">
                        <c:out value="${prod.unidade}" />
                    </td>
                    <td>
                                <span style="background-color: #e9ecef; padding: 2px 8px; border-radius: 10px; font-size: 0.85em;">
                                    <c:out value="${prod.nomeCategoria}" />
                                </span>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${listaProdutos.size() == 0}">
        <p style="margin-top: 20px; color: #666;">Nenhum produto cadastrado para exibir na lista.</p>
    </c:if>

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
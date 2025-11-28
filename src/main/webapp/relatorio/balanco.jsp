<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Relatório: Balanço Físico/Financeiro</title>
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
        <span class="page-label">Relatório: Balanço</span>
    </div>

    <h1>💰 Balanço Físico/Financeiro</h1>

    <p style="margin-bottom: 20px; color: #666;">
        Visão geral do valor total investido em estoque e quantidade disponível por item.
    </p>

    <div style="margin-bottom: 20px;">
        <a href="${pageContext.request.contextPath}/relatorio?acao=menu" class="btn-acao" style="background-color: #6c757d;">
            ⬅ Voltar ao Menu de Relatórios
        </a>
    </div>

    <table border="1">
        <thead>
        <tr>
            <th>Produto</th>
            <th>Quantidade Disponível</th>
            <th>Valor Unitário</th>
            <th>Valor Total (Estoque)</th>
            <th>Categoria</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${produtosBalanco}">
            <tr>
                <td><c:out value="${item.nome}" /></td>
                <td style="text-align: right;">
                    <c:out value="${item.quantidadeEstoque}" /> <c:out value="${item.unidade}" />
                </td>
                <td style="text-align: right;">
                    <fmt:formatNumber value="${item.valorUnitario}" type="currency" currencySymbol="R$" />
                </td>
                <td style="text-align: right; font-weight: bold; color: #0054a6;">
                    <fmt:formatNumber value="${item.valorTotalItem}" type="currency" currencySymbol="R$" />
                </td>
                <td><c:out value="${item.nomeCategoria}" /></td>
            </tr>
        </c:forEach>
        </tbody>
        <tfoot style="background-color: #e9ecef; font-weight: bold;">
        <tr>
            <td colspan="3" style="text-align: right; padding: 15px;">VALOR TOTAL DO ESTOQUE:</td>
            <td style="text-align: right; color: #28a745; font-size: 1.1rem;">
                <fmt:formatNumber value="${valorTotalEstoque}" type="currency" currencySymbol="R$" />
            </td>
            <td></td>
        </tr>
        </tfoot>
    </table>

</div>
<div style="margin-top: 50px; text-align: center;">
    <a href="${pageContext.request.contextPath}/index.jsp" style="font-weight: bold; color: #666;">🏠 Voltar ao Início</a>
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
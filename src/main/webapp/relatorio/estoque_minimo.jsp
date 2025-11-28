<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Relatório: Estoque Abaixo do Mínimo</title>
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
        <span class="page-label">Relatório: Reposição</span>
    </div>

    <h1 style="color: var(--error-red);">⚠️ Produtos Abaixo do Estoque Mínimo</h1>

    <p style="margin-bottom: 20px; color: #666;">
        Atenção: Os produtos listados abaixo atingiram níveis críticos e precisam ser reabastecidos imediatamente.
    </p>

    <div style="margin-bottom: 20px;">
        <a href="${pageContext.request.contextPath}/relatorio?acao=menu" class="btn-acao" style="background-color: #6c757d;">
            ⬅ Voltar ao Menu de Relatórios
        </a>
    </div>

    <c:if test="${listaProdutos.size() > 0}">
        <table border="1">
            <thead style="background-color: #dc3545;"> <tr>
                <th style="background-color: #b02a37;">Nome do Produto</th>
                <th style="background-color: #b02a37;">Estoque Atual</th>
                <th style="background-color: #b02a37;">Mínimo Exigido</th>
                <th style="background-color: #b02a37;">Faltam para Mínimo</th>
                <th style="background-color: #b02a37;">Categoria</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="prod" items="${listaProdutos}">
                <c:set var="faltam" value="${prod.quantidadeMinima - prod.quantidadeEstoque}" />

                <tr style="background-color: #fff5f5;">
                    <td style="font-weight: bold; color: #842029;"><c:out value="${prod.nome}" /></td>

                    <td style="text-align: right; color: #dc3545; font-weight: bold;">
                        <c:out value="${prod.quantidadeEstoque}" /> <c:out value="${prod.unidade}" />
                    </td>

                    <td style="text-align: right;">
                        <c:out value="${prod.quantidadeMinima}" />
                    </td>

                    <td style="text-align: right; font-weight: bold; background-color: #f8d7da;">
                        🚨 <c:out value="${faltam}" /> <c:out value="${prod.unidade}" />
                    </td>

                    <td><c:out value="${prod.nomeCategoria}" /></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${listaProdutos.size() == 0}">
        <div class="feedback-sucesso" style="margin-top: 20px;">
            🎉 Tudo certo! Nenhum produto está abaixo do estoque mínimo no momento.
        </div>
    </c:if>

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
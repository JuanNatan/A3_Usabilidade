<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Produtos</title>
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
        <span class="page-label">Listagem de Produtos</span>
    </div>

    <h1>Produtos Cadastrados</h1>

    <c:if test="${not empty mensagemSucesso}">
        <div class="feedback-sucesso">✅ ${mensagemSucesso}</div>
    </c:if>
    <c:if test="${not empty mensagemErro}">
        <div class="feedback-erro">❌ ${mensagemErro}</div>
    </c:if>

    <div style="margin-bottom: 25px; display: flex; gap: 10px; flex-wrap: wrap;">
        <a href="${pageContext.request.contextPath}/produto?acao=novo" class="btn-acao">
            ➕ Novo Produto
        </a>
        <a href="${pageContext.request.contextPath}/produto?acao=reajuste" class="btn-acao" style="background-color: #17a2b8;">
            💲 Reajustar Preços
        </a>
        <a href="${pageContext.request.contextPath}/movimentacao?acao=listar" class="btn-acao" style="background-color: #6c757d;">
            🚚 Ir para Movimentações
        </a>
    </div>

    <c:if test="${listaProdutos.size() > 0}">
        <table border="1">
            <thead>
            <tr>
                <th>Nome</th>
                <th>Preço</th>
                <th>Unidade</th>
                <th>Categoria</th>
                <th>Estoque Atual</th>
                <th>Min / Máx</th>
                <th style="text-align: center;">Ações</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="prod" items="${listaProdutos}">
                <tr>
                    <td><c:out value="${prod.nome}" /></td>
                    <td><fmt:formatNumber value="${prod.precoUnitario}" type="currency" currencySymbol="R$" /></td>
                    <td><c:out value="${prod.unidade}" /></td>
                    <td><c:out value="${prod.nomeCategoria}" /></td>

                    <td style="text-align: center; font-weight: bold;">
                        <c:choose>
                            <c:when test="${prod.quantidadeEstoque < prod.quantidadeMinima}">
                                <span style="color: #dc3545;">⚠️ ${prod.quantidadeEstoque}</span>
                            </c:when>
                            <c:when test="${prod.quantidadeEstoque > prod.quantidadeMaxima}">
                                <span style="color: #ffc107;">⚠️ ${prod.quantidadeEstoque}</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color: #28a745;">${prod.quantidadeEstoque}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td style="font-size: 0.85rem; color: #666;">
                            ${prod.quantidadeMinima} / ${prod.quantidadeMaxima}
                    </td>

                    <td style="text-align: center;">
                        <a href="${pageContext.request.contextPath}/produto?acao=editar&id=${prod.id}" title="Editar">
                            ✏️
                        </a>
                        &nbsp;
                        <a href="${pageContext.request.contextPath}/produto?acao=excluir&id=${prod.id}"
                           onclick="return confirm('Tem certeza que deseja excluir o produto ${prod.nome}?');"
                           title="Excluir" style="text-decoration: none;">
                            🗑️
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${listaProdutos.size() == 0}">
        <p style="margin-top: 20px; color: #666;">Nenhum produto encontrado no estoque.</p>
    </c:if>

</div>
<div style="margin-top: 50px; text-align: center;">
    <a href="${pageContext.request.contextPath}/index.jsp" style="font-weight: bold; color: #666;">🏠 Voltar ao Início</a>
</div>
footer>
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
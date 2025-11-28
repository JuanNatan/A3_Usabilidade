<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Histórico de Movimentações</title>
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
        <span class="page-label">Histórico de Movimentações</span>
    </div>

    <h1>Movimentações de Estoque</h1>

    <c:if test="${not empty mensagemSucesso}">
        <div class="feedback-sucesso">✅ ${mensagemSucesso}</div>
    </c:if>
    <c:if test="${not empty mensagemErro}">
        <div class="feedback-erro">❌ ${mensagemErro}</div>
    </c:if>

    <div style="margin-bottom: 20px;">
        <a href="${pageContext.request.contextPath}/movimentacao?acao=nova" class="btn-acao">
            ➕ Registrar Nova Movimentação
        </a>
        <a href="${pageContext.request.contextPath}/relatorio?acao=menu" class="btn-acao" style="background-color: #6c757d; margin-left: 10px;">
            📊 Ver Relatórios
        </a>
    </div>

    <c:if test="${listaMovimentacoes.size() > 0}">
        <table border="1">
            <thead>
            <tr>
                <th>ID</th>
                <th>Produto</th>
                <th>Data</th>
                <th>Quantidade</th>
                <th>Tipo</th>
                <th>Estoque Após</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="mov" items="${listaMovimentacoes}">
                <c:set var="corLinha" value="${mov.tipo == 'Entrada' ? 'background-color: #e6ffe6;' : 'background-color: #ffe6e6;'}"/>

                <tr style="${corLinha}">
                    <td><c:out value="${mov.id}" /></td>
                    <td><c:out value="${mov.produto.nome}" /></td>

                    <td><c:out value="${mov.dataFormatada}" /></td>

                    <td style="text-align: right;"><strong><c:out value="${mov.quantidade}" /></strong></td>
                    <td>
                        <c:choose>
                            <c:when test="${mov.tipo == 'Entrada'}">🟢 Entrada</c:when>
                            <c:otherwise>🔴 Saída</c:otherwise>
                        </c:choose>
                    </td>
                    <td><c:out value="${mov.produto.quantidadeEstoque}" /></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${listaMovimentacoes.size() == 0}">
        <p style="margin-top: 20px; color: #666;">Nenhuma movimentação registrada. Comece fazendo uma entrada de estoque!</p>
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
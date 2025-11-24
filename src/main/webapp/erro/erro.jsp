<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Erro no Sistema</title>
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
        <span class="page-label">Aviso do Sistema</span>
    </div>

    <h1 style="color: var(--error-red);">🚨 Ops! Algo deu errado.</h1>

    <p>O sistema encontrou um problema ao processar sua solicitação.</p>

    <div class="feedback-erro" style="margin-top: 20px; flex-direction: column; align-items: flex-start;">
        <c:if test="${not empty mensagemErro}">
            <h3 style="margin-bottom: 10px; color: #842029;">Detalhes do Erro:</h3>
            <p>${mensagemErro}</p>
        </c:if>
        <c:if test="${empty mensagemErro}">
            <p>Não foi possível recuperar os detalhes do erro. Verifique a conexão com o banco de dados (MySQL).</p>
        </c:if>
    </div>

    <div style="margin-top: 30px; text-align: center;">
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn-acao">
            🏠 Voltar ao Menu Principal
        </a>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>
        <c:out value="${categoria != null ? 'Editar Categoria' : 'Nova Categoria'}" />
    </title>
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
        <span class="page-label">Cadastro de Categoria</span>
    </div>

    <h1>
        <c:out value="${categoria != null ? 'Editar Categoria' : 'Nova Categoria'}" />
    </h1>

    <c:if test="${not empty mensagemSucesso}">
        <div class="feedback-sucesso">✅ ${mensagemSucesso}</div>
    </c:if>
    <c:if test="${not empty mensagemErro}">
        <div class="feedback-erro">❌ ${mensagemErro}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/categoria" method="POST">
        <input type="hidden" name="acao" value="salvar">
        <c:if test="${categoria != null}">
            <input type="hidden" name="id" value="${categoria.id}">
        </c:if>

        <label for="nome">Nome:</label>
        <input type="text" id="nome" name="nome"
               value="${categoria.nome}" required>

        <label for="tamanho">Tamanho:</label>
        <select id="tamanho" name="tamanho">
            <option value="Pequeno" ${categoria.tamanho == 'Pequeno' ? 'selected' : ''}>Pequeno</option>
            <option value="Médio" ${categoria.tamanho == 'Médio' ? 'selected' : ''}>Médio</option>
            <option value="Grande" ${categoria.tamanho == 'Grande' ? 'selected' : ''}>Grande</option>
        </select>

        <label for="embalagem">Embalagem:</label>
        <select id="embalagem" name="embalagem">
            <option value="Lata" ${categoria.embalagem == 'Lata' ? 'selected' : ''}>Lata</option>
            <option value="Vidro" ${categoria.embalagem == 'Vidro' ? 'selected' : ''}>Vidro</option>
            <option value="Plástico" ${categoria.embalagem == 'Plástico' ? 'selected' : ''}>Plástico</option>
        </select>

        <div style="margin-top: 20px;">
            <input type="submit" value="Salvar">
            <a href="${pageContext.request.contextPath}/categoria?acao=listar">Cancelar</a>
        </div>
    </form>

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
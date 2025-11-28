<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Categorias</title>
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
        <span class="page-label">Gestão de Categorias</span>
    </div>

    <h1>Categorias Cadastradas</h1>

    <c:if test="${not empty mensagemSucesso}">
        <div class="feedback-sucesso">✅ ${mensagemSucesso}</div>
    </c:if>
    <c:if test="${not empty mensagemErro}">
        <div class="feedback-erro">❌ ${mensagemErro}</div>
    </c:if>

    <p>
        <a href="${pageContext.request.contextPath}/categoria?acao=novo" class="btn-acao">
            + Nova Categoria
        </a>
    </p>

    <c:if test="${listaCategorias.size() > 0}">
        <table border="1">
            <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Tamanho</th>
                <th>Embalagem</th>
                <th style="text-align: center;">Ações</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="cat" items="${listaCategorias}">
                <tr>
                    <td><c:out value="${cat.id}" /></td>
                    <td><c:out value="${cat.nome}" /></td>
                    <td><c:out value="${cat.tamanho}" /></td>
                    <td><c:out value="${cat.embalagem}" /></td>
                    <td style="text-align: center;">
                        <a href="${pageContext.request.contextPath}/categoria?acao=editar&id=${cat.id}" title="Editar">
                            ✏️
                        </a>
                        &nbsp;&nbsp;
                        <a href="${pageContext.request.contextPath}/categoria?acao=excluir&id=${cat.id}"
                           onclick="return confirm('Tem certeza que deseja excluir a categoria ${cat.nome}?');"
                           title="Excluir" style="text-decoration: none;">
                            🗑️
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${listaCategorias.size() == 0}">
        <p style="margin-top: 20px; color: #666;">Nenhuma categoria encontrada. Comece cadastrando uma!</p>
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
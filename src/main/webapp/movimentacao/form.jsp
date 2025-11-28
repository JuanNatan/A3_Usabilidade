<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Movimentação</title>
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
        <span class="page-label">Registro de Movimentação</span>
    </div>

    <h1>Registrar Movimentação de Estoque</h1>

    <c:if test="${not empty mensagemSucesso}">
        <div class="feedback-sucesso">✅ ${mensagemSucesso}</div>
    </c:if>
    <c:if test="${not empty mensagemErro}">
        <div class="feedback-erro">❌ ${mensagemErro}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/movimentacao" method="POST">
        <input type="hidden" name="acao" value="registrar">

        <label for="idProduto">Produto:</label>
        <select id="idProduto" name="idProduto" required>
            <option value="">Selecione um Produto</option>
            <c:forEach var="prod" items="${listaProdutos}">
                <option value="${prod.id}">
                    <c:out value="${prod.nome}" /> (Estoque Atual: ${prod.quantidadeEstoque})
                </option>
            </c:forEach>
        </select>

        <label for="dataMovimentacao">Data:</label>
        <input type="date" id="dataMovimentacao" name="dataMovimentacao"
               value="<%= java.time.LocalDate.now() %>" required>

        <label for="quantidade">Quantidade:</label>
        <input type="number" id="quantidade" name="quantidade" min="1" required>

        <label for="tipo">Tipo de Movimentação:</label>
        <select id="tipo" name="tipo" required>
            <option value="Entrada">Entrada (Adicionar ao Estoque)</option>
            <option value="Saída">Saída (Subtrair do Estoque)</option>
        </select>

        <div style="margin-top: 20px;">
            <input type="submit" value="Registrar">
            <a href="${pageContext.request.contextPath}/movimentacao?acao=listar">Cancelar</a>
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
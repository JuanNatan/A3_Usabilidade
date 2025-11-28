<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>
        <c:out value="${produto != null ? 'Editar Produto' : 'Novo Produto'}" />
    </title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .alert-erro-validacao {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 20px;
            display: none;
        }
        .alert-erro-validacao strong {
            display: block;
            margin-bottom: 5px;
        }
    </style>
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
        <span class="page-label">Gestão de Produtos</span>
    </div>

    <h1>
        <c:out value="${produto != null ? 'Editar Produto' : 'Novo Produto'}" />
    </h1>

    <c:if test="${not empty mensagemSucesso}">
        <div class="feedback-sucesso">✅ ${mensagemSucesso}</div>
    </c:if>
    <c:if test="${not empty mensagemErro}">
        <div class="feedback-erro">❌ ${mensagemErro}</div>
    </c:if>

    <!-- Div para mensagem de erro de validação JavaScript -->
    <div id="mensagemErroEstoque" class="alert-erro-validacao"></div>

    <form action="${pageContext.request.contextPath}/produto" method="POST" onsubmit="return validarEstoque();">
        <input type="hidden" name="acao" value="salvar">
        <c:if test="${produto != null}">
            <input type="hidden" name="id" value="${produto.id}">
        </c:if>

        <label for="nome">Nome do Produto:</label>
        <input type="text" id="nome" name="nome"
               value="${produto.nome}" required>

        <label for="precoUnitario">Preço Unitário (R$):</label>
        <input type="number" step="0.01" min="0.01" id="precoUnitario" name="precoUnitario"
               value="${produto.precoUnitario}" required placeholder="Ex: 10.50">

        <label for="unidade">Unidade de Medida:</label>
        <input type="text" id="unidade" name="unidade"
               value="${produto.unidade}" required placeholder="Ex: Un, Kg, L, Cx">

        <div style="display: flex; gap: 20px;">
            <div style="flex: 1;">
                <label for="quantidadeMinima">Estoque Mínimo:</label>
                <input type="number" id="quantidadeMinima" name="quantidadeMinima"
                       min="0" value="${produto.quantidadeMinima}" required>
            </div>
            <div style="flex: 1;">
                <label for="quantidadeMaxima">Estoque Máximo:</label>
                <input type="number" id="quantidadeMaxima" name="quantidadeMaxima"
                       min="0" value="${produto.quantidadeMaxima}" required>
            </div>
        </div>

        <label for="idCategoria">Categoria:</label>
        <select id="idCategoria" name="idCategoria" required>
            <option value="">Selecione uma Categoria</option>
            <c:forEach var="cat" items="${listaCategorias}">
                <option value="${cat.id}"
                    ${produto.idCategoria == cat.id ? 'selected' : ''}>
                    <c:out value="${cat.nome}" />
                </option>
            </c:forEach>
        </select>

        <div style="margin-top: 20px;">
            <input type="submit" value="Salvar Produto">
            <a href="${pageContext.request.contextPath}/produto?acao=listar">Cancelar</a>
        </div>
    </form>

</div>


<footer>
    Controlador de Estoque da A3 - Juan Natan
</footer>
<div style="margin-top: 50px; text-align: center;">
    <a href="${pageContext.request.contextPath}/index.jsp" style="font-weight: bold; color: #666;">🏠 Voltar ao Início</a>
</div>

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

    // Função de validação de estoque
    function validarEstoque() {
        const estoqueMinimo = parseFloat(document.getElementById("quantidadeMinima").value);
        const estoqueMaximo = parseFloat(document.getElementById("quantidadeMaxima").value);
        const mensagemErro = document.getElementById("mensagemErroEstoque");

        // Limpa mensagem de erro anterior
        mensagemErro.innerHTML = "";
        mensagemErro.style.display = "none";

        // Verifica se os valores são válidos
        if (isNaN(estoqueMinimo) || isNaN(estoqueMaximo)) {
            return true; // Permite submissão (validação HTML5 cuidará disso)
        }

        // Valida se estoque mínimo é maior que o máximo
        if (estoqueMinimo > estoqueMaximo) {
            mensagemErro.innerHTML =
                "<strong>⚠️ Erro de Validação:</strong> " +
                "O estoque mínimo (" + estoqueMinimo + ") não pode ser maior que o estoque máximo (" + estoqueMaximo + "). " +
                "<br><br>" +
                "<strong>📚 Explicação:</strong> O estoque mínimo representa a quantidade limite abaixo da qual você precisa reabastecer o produto. " +
                "O estoque máximo é a quantidade máxima que você deseja manter em estoque. " +
                "Logicamente, o valor mínimo deve sempre ser menor que o máximo.";

            mensagemErro.style.display = "block";

            // Scroll suave até a mensagem de erro
            mensagemErro.scrollIntoView({ behavior: 'smooth', block: 'center' });

            return false; // Impede o envio do formulário
        }

        return true; // Permite o envio do formulário
    }

    // Validação em tempo real (ao sair dos campos)
    document.addEventListener("DOMContentLoaded", function() {
        const estoqueMinInput = document.getElementById("quantidadeMinima");
        const estoqueMaxInput = document.getElementById("quantidadeMaxima");

        if (estoqueMinInput && estoqueMaxInput) {
            estoqueMinInput.addEventListener("blur", validarEstoque);
            estoqueMaxInput.addEventListener("blur", validarEstoque);
        }
    });
</script>

</body>
</html>
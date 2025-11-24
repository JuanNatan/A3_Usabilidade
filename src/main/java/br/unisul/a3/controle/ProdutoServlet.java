package br.unisul.a3.controle;

import br.unisul.a3.dao.CategoriaDAO;
import br.unisul.a3.dao.ProdutoDAO;
import br.unisul.a3.modelo.Categoria;
import br.unisul.a3.modelo.Produto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/produto")
public class ProdutoServlet extends HttpServlet {
    private final ProdutoDAO produtoDao = new ProdutoDAO();
    private final CategoriaDAO categoriaDao = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acao = request.getParameter("acao");
        if (acao == null) acao = "listar";

        switch (acao) {
            case "listar":
                listarProdutos(request, response);
                break;
            case "novo":
                prepararFormulario(request, response);
                break;
            case "editar":
                mostrarFormularioEdicao(request, response);
                break;
            case "excluir":
                excluirProduto(request, response);
                break;
            case "reajuste": // Funcionalidade de reajuste de preço
                mostrarFormularioReajuste(request, response);
                break;
            default:
                listarProdutos(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");

        if ("salvar".equals(acao)) {
            salvarProduto(request, response);
        } else if ("reajustar".equals(acao)) {
            realizarReajuste(request, response);
        } else {
            listarProdutos(request, response);
        }
    }

    private void listarProdutos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Produto> produtos = produtoDao.listar();
            request.setAttribute("listaProdutos", produtos);
            // Encaminha para o JSP de listagem de produto
            request.getRequestDispatcher("/produto/lista.jsp").forward(request, response);
        } catch (RuntimeException e) {
            request.setAttribute("mensagemErro", "Erro ao listar produtos: " + e.getMessage());
            request.getRequestDispatcher("/erro.jsp").forward(request, response);
        }
    }

    private void prepararFormulario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lista todas as categorias para preencher o <select>
            List<Categoria> categorias = categoriaDao.listar();
            request.setAttribute("listaCategorias", categorias);
            request.getRequestDispatcher("/produto/form.jsp").forward(request, response);
        } catch (RuntimeException e) {
            request.setAttribute("mensagemErro", "Erro ao preparar formulário: " + e.getMessage());
            listarProdutos(request, response);
        }
    }

    private void mostrarFormularioEdicao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Produto produto = produtoDao.buscarPorId(id);
            if (produto != null) {
                request.setAttribute("produto", produto);
                prepararFormulario(request, response);
            } else {
                request.setAttribute("mensagemErro", "Produto não encontrado.");
                listarProdutos(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("mensagemErro", "ID inválido.");
            listarProdutos(request, response);
        }
    }

    private void salvarProduto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        String nome = request.getParameter("nome");
        String precoUnitarioParam = request.getParameter("precoUnitario");
        String unidade = request.getParameter("unidade");
        String quantidadeMinimaParam = request.getParameter("quantidadeMinima");
        String quantidadeMaximaParam = request.getParameter("quantidadeMaxima");
        String idCategoriaParam = request.getParameter("idCategoria");

        Produto produto = new Produto();

        try {
            BigDecimal preco = new BigDecimal(precoUnitarioParam);
            int qtdeMin = Integer.parseInt(quantidadeMinimaParam);
            int qtdeMax = Integer.parseInt(quantidadeMaximaParam);
            int idCat = Integer.parseInt(idCategoriaParam);

            Categoria categoria = categoriaDao.buscarPorId(idCat);

            produto.setNome(nome);
            produto.setPrecoUnitario(preco);
            produto.setUnidade(unidade);
            produto.setQuantidadeMinima(qtdeMin);
            produto.setQuantidadeMaxima(qtdeMax);
            produto.setCategoria(categoria);

            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);
                produto.setId(id);
                produtoDao.alterar(produto);
                request.setAttribute("mensagemSucesso", "Produto alterado com sucesso!");
            } else {
                produtoDao.incluir(produto);
                request.setAttribute("mensagemSucesso", "Produto incluído com sucesso!");
            }

            listarProdutos(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("mensagemErro", "Erro na conversão de número (preço, quantidade ou ID): " + e.getMessage());
            request.setAttribute("produto", produto);
            prepararFormulario(request, response);
        } catch (RuntimeException e) {
            request.setAttribute("mensagemErro", "Erro ao salvar produto: " + e.getMessage());
            request.setAttribute("produto", produto);
            prepararFormulario(request, response);
        }
    }

    private void excluirProduto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            produtoDao.excluir(id);
            request.setAttribute("mensagemSucesso", "Produto excluído com sucesso!");
        } catch (NumberFormatException e) {
            request.setAttribute("mensagemErro", "ID de exclusão inválido.");
        } catch (RuntimeException e) {
            request.setAttribute("mensagemErro", e.getMessage());
        }
        listarProdutos(request, response);
    }

    private void mostrarFormularioReajuste(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/produto/form_reajuste.jsp").forward(request, response);
    }

    private void realizarReajuste(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String percentualParam = request.getParameter("percentual");

        try {
            double percentual = Double.parseDouble(percentualParam);
            produtoDao.reajustarPreco(percentual);
            request.setAttribute("mensagemSucesso", "Reajuste de " + percentual + "% aplicado a todos os produtos!");
        } catch (NumberFormatException e) {
            request.setAttribute("mensagemErro", "O percentual deve ser um número válido.");
            mostrarFormularioReajuste(request, response);
            return;
        } catch (RuntimeException e) {
            request.setAttribute("mensagemErro", "Erro ao realizar reajuste: " + e.getMessage());
        }

        listarProdutos(request, response);
    }
}
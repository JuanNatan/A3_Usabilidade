package br.unisul.a3.controle;

import br.unisul.a3.dao.ProdutoDAO;
import br.unisul.a3.dao.MovimentacaoDAO;
import br.unisul.a3.dao.RelatorioDAO;
import br.unisul.a3.modelo.Produto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/relatorio")
public class RelatorioServlet extends HttpServlet {
    private final RelatorioDAO relatorioDao = new RelatorioDAO();
    private final ProdutoDAO produtoDao = new ProdutoDAO();
    private final MovimentacaoDAO movDao = new MovimentacaoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acao = request.getParameter("acao");
        if (acao == null) acao = "menu";

        try {
            switch (acao) {
                case "lista_precos":
                    listarPrecos(request, response);
                    break;
                case "balanco":
                    gerarBalanco(request, response);
                    break;
                case "estoque_minimo":
                    listarEstoqueMinimo(request, response);
                    break;
                case "produtos_por_categoria":
                    contarProdutosPorCategoria(request, response);
                    break;
                case "mais_movimentado":
                    listarMaisMovimentado(request, response);
                    break;
                case "menu":
                default:
                    // Mostra o menu de opções de relatórios
                    request.getRequestDispatcher("/relatorio/menu.jsp").forward(request, response);
                    break;
            }
        } catch (RuntimeException e) {
            request.setAttribute("mensagemErro", "Erro ao gerar relatório: " + e.getMessage());
            request.getRequestDispatcher("/erro.jsp").forward(request, response);
        }
    }

    // RELATÓRIO 1: Lista de Preços
    private void listarPrecos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // O ProdutoDAO.listar() já retorna todos os produtos em ordem alfabética
        List<Produto> produtos = produtoDao.listar();
        request.setAttribute("listaProdutos", produtos);
        request.getRequestDispatcher("/relatorio/lista_precos.jsp").forward(request, response);
    }

    // RELATÓRIO 2: Balanço Físico/Financeiro
    private void gerarBalanco(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Map<String, Object> balanco = relatorioDao.gerarBalancoFisicoFinanceiro();
        request.setAttribute("produtosBalanco", balanco.get("produtos"));
        request.setAttribute("valorTotalEstoque", balanco.get("valorTotalEstoque"));
        request.getRequestDispatcher("/relatorio/balanco.jsp").forward(request, response);
    }

    // RELATÓRIO 3: Estoque Mínimo
    private void listarEstoqueMinimo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Produto> produtos = relatorioDao.listarProdutosAbaixoEstoqueMinimo();
        request.setAttribute("listaProdutos", produtos);
        request.getRequestDispatcher("/relatorio/estoque_minimo.jsp").forward(request, response);
    }

    // RELATÓRIO 4: Produtos por Categoria
    private void contarProdutosPorCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Map<String, Integer> contagem = relatorioDao.contarProdutosPorCategoria();
        request.setAttribute("contagemCategorias", contagem);
        request.getRequestDispatcher("/relatorio/produtos_por_categoria.jsp").forward(request, response);
    }

    // RELATÓRIO 5: Produto mais movimentado (Entrada e Saída)
    private void listarMaisMovimentado(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Produto maisEntrada = movDao.buscarMaisMovimentado("Entrada");
        Produto maisSaida = movDao.buscarMaisMovimentado("Saída");

        request.setAttribute("maisEntrada", maisEntrada);
        request.setAttribute("maisSaida", maisSaida);
        request.getRequestDispatcher("/relatorio/mais_movimentado.jsp").forward(request, response);
    }
}
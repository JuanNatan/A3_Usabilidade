package br.unisul.a3.controle;

import br.unisul.a3.dao.MovimentacaoDAO;
import br.unisul.a3.dao.ProdutoDAO;
import br.unisul.a3.modelo.Movimentacao;
import br.unisul.a3.modelo.Produto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/movimentacao")
public class MovimentacaoServlet extends HttpServlet {
    private final MovimentacaoDAO movDao = new MovimentacaoDAO();
    private final ProdutoDAO produtoDao = new ProdutoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acao = request.getParameter("acao");
        if (acao == null) acao = "listar";

        if ("listar".equals(acao)) {
            listarMovimentacoes(request, response);
        } else if ("nova".equals(acao)) {
            mostrarFormulario(request, response);
        } else {
            listarMovimentacoes(request, response);
        }
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acao = request.getParameter("acao");

        if ("registrar".equals(acao)) {
            registrarMovimentacao(request, response);
        } else {
            listarMovimentacoes(request, response);
        }
    }

    private void listarMovimentacoes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Movimentacao> movimentacoes = movDao.listar();
            request.setAttribute("listaMovimentacoes", movimentacoes);
            request.getRequestDispatcher("/movimentacao/lista.jsp").forward(request, response);
        } catch (RuntimeException e) {
            request.setAttribute("mensagemErro", "Erro ao listar movimentações: " + e.getMessage());
            request.getRequestDispatcher("/erro.jsp").forward(request, response);
        }
    }

    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Produto> produtos = produtoDao.listar();
            request.setAttribute("listaProdutos", produtos);
            request.getRequestDispatcher("/movimentacao/form.jsp").forward(request, response);
        } catch (RuntimeException e) {
            request.setAttribute("mensagemErro", "Erro ao preparar formulário de movimentação: " + e.getMessage());
            listarMovimentacoes(request, response);
        }
    }

    private void registrarMovimentacao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idProdutoParam = request.getParameter("idProduto");
        String quantidadeParam = request.getParameter("quantidade");
        String tipo = request.getParameter("tipo");
        String dataParam = request.getParameter("dataMovimentacao");

        try {
            int idProduto = Integer.parseInt(idProdutoParam);
            int quantidade = Integer.parseInt(quantidadeParam);
            LocalDate data = LocalDate.parse(dataParam);

            Produto produto = produtoDao.buscarPorId(idProduto);
            if (produto == null) {
                request.setAttribute("mensagemErro", "Produto não encontrado.");
                mostrarFormulario(request, response);
                return;
            }

            Movimentacao mov = new Movimentacao(produto, data, quantidade, tipo);

            // Bloco de validação conforme a A3: verifica se o estoque tá baixo ou alto e gera o alerta.
            String aviso = "";
            if ("Saída".equalsIgnoreCase(tipo)) {
                // Validação: Checamos se o estoque atual cobre a quantidade pedida (não pode sair o que não tem no inventário!)
                if (produto.getQuantidadeEstoque() < quantidade) {
                    throw new RuntimeException("Não há estoque suficiente! Estoque atual: " + produto.getQuantidadeEstoque() + ".");
                }
            }

            // 2. Registrar no DAO (Transação)
            movDao.registrarMovimentacao(mov);

            // 3. Verificar Estoque Mínimo/Máximo APÓS a operação (Feedback)
            // É necessário buscar o produto novamente para ter o estoque ATUALIZADO
            Produto produtoAtualizado = produtoDao.buscarPorId(idProduto);

            if ("Entrada".equalsIgnoreCase(tipo)) {
                // Se estiver dando uma entrada avise se a quantidade está acima da quantidade máxima
                if (produtoAtualizado.getQuantidadeEstoque() > produtoAtualizado.getQuantidadeMaxima()) {
                    aviso = "⚠️ Aviso: Estoque acima do limite! O estoque atual (" + produtoAtualizado.getQuantidadeEstoque() + ") está acima da quantidade máxima (" + produtoAtualizado.getQuantidadeMaxima() + ").";
                }
            } else if ("Saída".equalsIgnoreCase(tipo)) {
                // No momento da saída é importante avisar que a quantidade está abaixo da quantidade mínima
                if (produtoAtualizado.getQuantidadeEstoque() < produtoAtualizado.getQuantidadeMinima()) {
                    aviso = "🚨 Aviso: Estoque baixo! O estoque atual (" + produtoAtualizado.getQuantidadeEstoque() + ") está abaixo da quantidade mínima (" + produtoAtualizado.getQuantidadeMinima() + ") para providenciar a compra.";
                }
            }

            request.setAttribute("mensagemSucesso", "Movimentação (" + tipo + ") registrada com sucesso! " + aviso);
            listarMovimentacoes(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("mensagemErro", "Erro na conversão de número (ID ou Quantidade): " + e.getMessage());
            mostrarFormulario(request, response);
        } catch (RuntimeException e) {
            // Captura erros de estoque insuficiente ou erros do DAO/SQL
            request.setAttribute("mensagemErro", "Falha ao registrar: " + e.getMessage());
            mostrarFormulario(request, response);
        }
    }
}
package br.unisul.a3.dao;

import br.unisul.a3.modelo.Produto;
import br.unisul.a3.modelo.Categoria;
import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RelatorioDAO {

    private final CategoriaDAO categoriaDAO = new CategoriaDAO();

    // RELATÓRIO 2: Balanço Físico/Financeiro
    // Uma relação de todos os produtos do estoque, a quantidade disponível,
    // o valor total de cada um (valor unitário * quantidade) e o valor total do estoque (somatório).
    public Map<String, Object> gerarBalancoFisicoFinanceiro() {
        String sql = "SELECT p.nome, p.quantidade_estoque, p.preco_unitario, p.unidade, " +
                "(p.quantidade_estoque * p.preco_unitario) AS valor_total_item, " +
                "c.nome AS nome_categoria " +
                "FROM produto p JOIN categoria c ON p.id_categoria = c.id_categoria " +
                "ORDER BY p.nome";

        List<Map<String, Object>> produtosBalanco = new ArrayList<>();
        BigDecimal valorTotalEstoque = BigDecimal.ZERO;

        try (Connection conn = Conexao.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("nome", rs.getString("nome"));
                item.put("quantidadeEstoque", rs.getInt("quantidade_estoque"));
                item.put("valorUnitario", rs.getBigDecimal("preco_unitario"));
                item.put("valorTotalItem", rs.getBigDecimal("valor_total_item"));
                item.put("unidade", rs.getString("unidade"));
                item.put("nomeCategoria", rs.getString("nome_categoria"));

                produtosBalanco.add(item);
                valorTotalEstoque = valorTotalEstoque.add(rs.getBigDecimal("valor_total_item"));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao gerar Balanço Físico/Financeiro: " + e.getMessage(), e);
        }

        Map<String, Object> resultado = new HashMap<>();
        resultado.put("produtos", produtosBalanco);
        resultado.put("valorTotalEstoque", valorTotalEstoque);
        return resultado;
    }

    // RELATÓRIO 3: Produtos abaixo da Quantidade Mínima
    // Contendo o nome do produto, a quantidade mínima e a quantidade em estoque
    public List<Produto> listarProdutosAbaixoEstoqueMinimo() {
        String sql = "SELECT * FROM produto WHERE quantidade_estoque < quantidade_minima ORDER BY nome";
        List<Produto> lista = new ArrayList<>();

        try (Connection conn = Conexao.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                int idCategoria = rs.getInt("id_categoria");
                Categoria categoria = categoriaDAO.buscarPorId(idCategoria);

                Produto produto = new Produto(
                        rs.getInt("id_produto"),
                        rs.getString("nome"),
                        rs.getBigDecimal("preco_unitario"),
                        rs.getString("unidade"),
                        rs.getInt("quantidade_estoque"),
                        rs.getInt("quantidade_minima"),
                        rs.getInt("quantidade_maxima"),
                        categoria
                );
                lista.add(produto);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar produtos abaixo do estoque mínimo: " + e.getMessage(), e);
        }
        return lista;
    }

    // RELATÓRIO 4: Quantidade de produtos por categoria
    // Contendo o nome da categoria e quantidade de produtos distintos.
    public Map<String, Integer> contarProdutosPorCategoria() {
        String sql = "SELECT c.nome, COUNT(p.id_produto) AS total_produtos " +
                "FROM categoria c LEFT JOIN produto p ON c.id_categoria = p.id_categoria " +
                "GROUP BY c.nome " +
                "ORDER BY c.nome";

        Map<String, Integer> contagem = new HashMap<>();

        try (Connection conn = Conexao.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                contagem.put(rs.getString("nome"), rs.getInt("total_produtos"));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao contar produtos por categoria: " + e.getMessage(), e);
        }
        return contagem;
    }
}
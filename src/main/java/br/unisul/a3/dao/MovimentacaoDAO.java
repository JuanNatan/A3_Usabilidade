package br.unisul.a3.dao;

import br.unisul.a3.modelo.Movimentacao;
import br.unisul.a3.modelo.Produto;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class MovimentacaoDAO {

    private final ProdutoDAO produtoDAO = new ProdutoDAO();

    // CREATE: Registra Movimentação e Atualiza Estoque (Transação)
    public void registrarMovimentacao(Movimentacao mov) {
        String sqlMov = "INSERT INTO movimentacao (id_produto, data_movimentacao, quantidade, tipo) VALUES (?, ?, ?, ?)";
        String sqlUpdateEstoque;

        if ("Entrada".equalsIgnoreCase(mov.getTipo())) {
            sqlUpdateEstoque = "UPDATE produto SET quantidade_estoque = quantidade_estoque + ? WHERE id_produto = ?";
        } else if ("Saída".equalsIgnoreCase(mov.getTipo())) {
            sqlUpdateEstoque = "UPDATE produto SET quantidade_estoque = quantidade_estoque - ? WHERE id_produto = ?";
        } else {
            throw new IllegalArgumentException("Tipo de movimentação inválido: " + mov.getTipo());
        }

        Connection conn = null;
        try {
            conn = Conexao.getConnection();
            conn.setAutoCommit(false); // Inicia transação

            // 1. Registrar a Movimentação
            try (PreparedStatement stmtMov = conn.prepareStatement(sqlMov)) {
                stmtMov.setInt(1, mov.getIdProduto());
                stmtMov.setDate(2, Date.valueOf(mov.getDataMovimentacao()));
                stmtMov.setInt(3, mov.getQuantidade());
                stmtMov.setString(4, mov.getTipo());
                stmtMov.execute();
            }

            // 2. Atualizar o Estoque
            try (PreparedStatement stmtEstoque = conn.prepareStatement(sqlUpdateEstoque)) {
                stmtEstoque.setInt(1, mov.getQuantidade());
                stmtEstoque.setInt(2, mov.getIdProduto());
                stmtEstoque.execute();
            }

            conn.commit(); // Confirma a transação

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Desfaz se houver erro
                } catch (SQLException ex) { /* Ignora */ }
            }
            throw new RuntimeException("Erro ao registrar movimentação e atualizar estoque: " + e.getMessage(), e);
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException ex) { /* Ignora */ }
            }
        }
    }

    // READ (Listar todas as Movimentações)
    public List<Movimentacao> listar() {
        String sql = "SELECT id_movimentacao, id_produto, data_movimentacao, quantidade, tipo FROM movimentacao ORDER BY data_movimentacao DESC";
        List<Movimentacao> lista = new ArrayList<>();

        try (Connection conn = Conexao.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                int idProduto = rs.getInt("id_produto");
                // Busca o Produto completo (necessário para a visualização)
                Movimentacao mov = new Movimentacao(
                        rs.getInt("id_movimentacao"),
                        produtoDAO.buscarPorId(idProduto),
                        rs.getDate("data_movimentacao").toLocalDate(),
                        rs.getInt("quantidade"),
                        rs.getString("tipo")
                );
                lista.add(mov);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar movimentações: " + e.getMessage(), e);
        }
        return lista;
    }

    // RELATÓRIO 5: Produto que mais teve Entrada/Saída
    public Produto buscarMaisMovimentado(String tipo) {
        if (!"Entrada".equalsIgnoreCase(tipo) && !"Saída".equalsIgnoreCase(tipo)) {
            return null;
        }

        String sql = "SELECT id_produto, SUM(quantidade) AS total " +
                "FROM movimentacao " +
                "WHERE tipo = ? " +
                "GROUP BY id_produto " +
                "ORDER BY total DESC " +
                "LIMIT 1";

        try (Connection conn = Conexao.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, tipo);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int idProduto = rs.getInt("id_produto");
                    return produtoDAO.buscarPorId(idProduto);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar produto com maior " + tipo + ": " + e.getMessage(), e);
        }
        return null;
    }
}
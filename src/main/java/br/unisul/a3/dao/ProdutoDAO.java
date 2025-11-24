package br.unisul.a3.dao;

import br.unisul.a3.modelo.Categoria;
import br.unisul.a3.modelo.Produto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class ProdutoDAO {

    // Necessário para buscar o objeto Categoria completo
    private final CategoriaDAO categoriaDAO = new CategoriaDAO();

    // CREATE
    public void incluir(Produto produto) {
        String sql = "INSERT INTO produto (nome, preco_unitario, unidade, quantidade_minima, quantidade_maxima, id_categoria) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = Conexao.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, produto.getNome());
            stmt.setBigDecimal(2, produto.getPrecoUnitario());
            stmt.setString(3, produto.getUnidade());
            stmt.setInt(4, produto.getQuantidadeMinima());
            stmt.setInt(5, produto.getQuantidadeMaxima());
            stmt.setInt(6, produto.getIdCategoria());
            stmt.execute();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao incluir produto: " + e.getMessage(), e);
        }
    }

    // READ (Listar Todos)
    public List<Produto> listar() {
        // Traz o nome da categoria junto para exibir na lista sem fazer múltiplas consultas
        String sql = "SELECT p.*, c.nome AS nome_categoria FROM produto p JOIN categoria c ON p.id_categoria = c.id_categoria ORDER BY p.nome";
        List<Produto> lista = new ArrayList<>();

        try (Connection conn = Conexao.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                // Cria uma categoria simplificada para a lista
                Categoria categoriaSimples = new Categoria();
                categoriaSimples.setId(rs.getInt("id_categoria"));
                categoriaSimples.setNome(rs.getString("nome_categoria"));

                Produto produto = new Produto(
                        rs.getInt("id_produto"),
                        rs.getString("nome"),
                        rs.getBigDecimal("preco_unitario"),
                        rs.getString("unidade"),
                        rs.getInt("quantidade_estoque"),
                        rs.getInt("quantidade_minima"),
                        rs.getInt("quantidade_maxima"),
                        categoriaSimples
                );
                lista.add(produto);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar produtos: " + e.getMessage(), e);
        }
        return lista;
    }

    // READ (Buscar por ID)
    public Produto buscarPorId(int id) {
        String sql = "SELECT * FROM produto WHERE id_produto = ?";
        Produto produto = null;

        try (Connection conn = Conexao.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int idCategoria = rs.getInt("id_categoria");
                    Categoria categoria = categoriaDAO.buscarPorId(idCategoria);

                    produto = new Produto(
                            rs.getInt("id_produto"),
                            rs.getString("nome"),
                            rs.getBigDecimal("preco_unitario"),
                            rs.getString("unidade"),
                            rs.getInt("quantidade_estoque"),
                            rs.getInt("quantidade_minima"),
                            rs.getInt("quantidade_maxima"),
                            categoria
                    );
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar produto por ID: " + e.getMessage(), e);
        }
        return produto;
    }

    // UPDATE
    public void alterar(Produto produto) {
        String sql = "UPDATE produto SET nome = ?, preco_unitario = ?, unidade = ?, quantidade_minima = ?, quantidade_maxima = ?, id_categoria = ? WHERE id_produto = ?";
        try (Connection conn = Conexao.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, produto.getNome());
            stmt.setBigDecimal(2, produto.getPrecoUnitario());
            stmt.setString(3, produto.getUnidade());
            stmt.setInt(4, produto.getQuantidadeMinima());
            stmt.setInt(5, produto.getQuantidadeMaxima());
            stmt.setInt(6, produto.getIdCategoria());
            stmt.setInt(7, produto.getId());
            stmt.execute();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao alterar produto: " + e.getMessage(), e);
        }
    }


    public void reajustarPreco(double percentual) {
        BigDecimal fator = BigDecimal.valueOf(1.0 + (percentual / 100.0));
        String sql = "UPDATE produto SET preco_unitario = preco_unitario * ?";

        try (Connection conn = Conexao.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBigDecimal(1, fator);
            stmt.execute();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao reajustar preços dos produtos: " + e.getMessage(), e);
        }
    }


    // DELETE
    public void excluir(int id) {
        String sql = "DELETE FROM produto WHERE id_produto = ?";
        try (Connection conn = Conexao.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.execute();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao excluir produto. Verifique se há movimentações associadas: " + e.getMessage(), e);
        }
    }
}
package br.unisul.a3.dao;

import br.unisul.a3.modelo.Categoria;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {


    public void incluir(Categoria categoria) {
        String sql = "INSERT INTO categoria (nome, tamanho, embalagem) VALUES (?, ?, ?)";
        try (Connection conn = Conexao.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, categoria.getNome());
            stmt.setString(2, categoria.getTamanho());
            stmt.setString(3, categoria.getEmbalagem());
            stmt.execute();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao incluir categoria: " + e.getMessage(), e);
        }
    }


    public List<Categoria> listar() {
        String sql = "SELECT id_categoria, nome, tamanho, embalagem FROM categoria ORDER BY nome";
        List<Categoria> lista = new ArrayList<>();

        try (Connection conn = Conexao.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Categoria categoria = new Categoria(
                        rs.getInt("id_categoria"),
                        rs.getString("nome"),
                        rs.getString("tamanho"),
                        rs.getString("embalagem")
                );
                lista.add(categoria);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar categorias: " + e.getMessage(), e);
        }
        return lista;
    }


    public Categoria buscarPorId(int id) {
        String sql = "SELECT id_categoria, nome, tamanho, embalagem FROM categoria WHERE id_categoria = ?";
        Categoria categoria = null;

        try (Connection conn = Conexao.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    categoria = new Categoria(
                            rs.getInt("id_categoria"),
                            rs.getString("nome"),
                            rs.getString("tamanho"),
                            rs.getString("embalagem")
                    );
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar categoria por ID: " + e.getMessage(), e);
        }
        return categoria;
    }


    public void alterar(Categoria categoria) {
        String sql = "UPDATE categoria SET nome = ?, tamanho = ?, embalagem = ? WHERE id_categoria = ?";
        try (Connection conn = Conexao.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, categoria.getNome());
            stmt.setString(2, categoria.getTamanho());
            stmt.setString(3, categoria.getEmbalagem());
            stmt.setInt(4, categoria.getId());
            stmt.execute();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao alterar categoria: " + e.getMessage(), e);
        }
    }


    public void excluir(int id) {
        String sql = "DELETE FROM categoria WHERE id_categoria = ?";
        try (Connection conn = Conexao.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.execute();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao excluir categoria. Verifique se há produtos associados: " + e.getMessage(), e);
        }
    }
}
package br.unisul.a3.modelo;

import java.math.BigDecimal;

public class Produto {
    private int id;
    private String nome;
    private BigDecimal precoUnitario;
    private String unidade;
    private int quantidadeEstoque;
    private int quantidadeMinima;
    private int quantidadeMaxima;
    private Categoria categoria;

    public Produto() {
        this.categoria = new Categoria();
    }

    // Construtor completo
    public Produto(int id, String nome, BigDecimal precoUnitario, String unidade,
                   int quantidadeEstoque, int quantidadeMinima, int quantidadeMaxima, Categoria categoria) {
        this.id = id;
        this.nome = nome;
        this.precoUnitario = precoUnitario;
        this.unidade = unidade;
        this.quantidadeEstoque = quantidadeEstoque;
        this.quantidadeMinima = quantidadeMinima;
        this.quantidadeMaxima = quantidadeMaxima;
        this.categoria = categoria;
    }

    // Construtor para inclusão
    public Produto(String nome, BigDecimal precoUnitario, String unidade,
                   int quantidadeMinima, int quantidadeMaxima, Categoria categoria) {
        this.nome = nome;
        this.precoUnitario = precoUnitario;
        this.unidade = unidade;
        this.quantidadeEstoque = 0;
        this.quantidadeMinima = quantidadeMinima;
        this.quantidadeMaxima = quantidadeMaxima;
        this.categoria = categoria;
    }

    // Getters e Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public BigDecimal getPrecoUnitario() { return precoUnitario; }
    public void setPrecoUnitario(BigDecimal precoUnitario) { this.precoUnitario = precoUnitario; }
    public String getUnidade() { return unidade; }
    public void setUnidade(String unidade) { this.unidade = unidade; }
    public int getQuantidadeEstoque() { return quantidadeEstoque; }
    public void setQuantidadeEstoque(int quantidadeEstoque) { this.quantidadeEstoque = quantidadeEstoque; }
    public int getQuantidadeMinima() { return quantidadeMinima; }
    public void setQuantidadeMinima(int quantidadeMinima) { this.quantidadeMinima = quantidadeMinima; }
    public int getQuantidadeMaxima() { return quantidadeMaxima; }
    public void setQuantidadeMaxima(int quantidadeMaxima) { this.quantidadeMaxima = quantidadeMaxima; }
    public Categoria getCategoria() { return categoria; }
    public void setCategoria(Categoria categoria) { this.categoria = categoria; }
    public int getIdCategoria() {
        return (this.categoria != null) ? this.categoria.getId() : 0;
    }
    public String getNomeCategoria() {
        return (this.categoria != null) ? this.categoria.getNome() : "N/A";
    }
}
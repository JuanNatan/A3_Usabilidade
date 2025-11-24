package br.unisul.a3.modelo;

import java.time.LocalDate;

public class Movimentacao {
    private int id;
    private Produto produto; // Produto movimentado
    private LocalDate dataMovimentacao;
    private int quantidade;
    private String tipo; // "Entrada" ou "Saída"

    // Construtores
    public Movimentacao() {
        this.dataMovimentacao = LocalDate.now();
    }
    public String getDataFormatada() {
        if (this.dataMovimentacao != null) {
            return this.dataMovimentacao.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        }
        return "";
    }

    // Construtor completo
    public Movimentacao(int id, Produto produto, LocalDate dataMovimentacao, int quantidade, String tipo) {
        this.id = id;
        this.produto = produto;
        this.dataMovimentacao = dataMovimentacao;
        this.quantidade = quantidade;
        this.tipo = tipo;
    }

    // Construtor para inclusão
    public Movimentacao(Produto produto, LocalDate dataMovimentacao, int quantidade, String tipo) {
        this.produto = produto;
        this.dataMovimentacao = dataMovimentacao;
        this.quantidade = quantidade;
        this.tipo = tipo;
    }

    // Getters e Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Produto getProduto() { return produto; }
    public void setProduto(Produto produto) { this.produto = produto; }
    public int getIdProduto() {
        return (this.produto != null) ? this.produto.getId() : 0;
    }
    public LocalDate getDataMovimentacao() { return dataMovimentacao; }
    public void setDataMovimentacao(LocalDate dataMovimentacao) { this.dataMovimentacao = dataMovimentacao; }
    public int getQuantidade() { return quantidade; }
    public void setQuantidade(int quantidade) { this.quantidade = quantidade; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
}
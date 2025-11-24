package br.unisul.a3.modelo;

public class Categoria {
    private int id;
    private String nome;
    private String tamanho; // Ex: Pequeno, Médio, Grande
    private String embalagem; // Ex: Lata, Vidro, Plástico

    // Construtor vazio
    public Categoria() {}

    // Construtor para leitura (com ID)
    public Categoria(int id, String nome, String tamanho, String embalagem) {
        this.id = id;
        this.nome = nome;
        this.tamanho = tamanho;
        this.embalagem = embalagem;
    }

    // Construtor para inclusão (sem ID)
    public Categoria(String nome, String tamanho, String embalagem) {
        this.nome = nome;
        this.tamanho = tamanho;
        this.embalagem = embalagem;
    }

    // Getters e Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getTamanho() { return tamanho; }
    public void setTamanho(String tamanho) { this.tamanho = tamanho; }
    public String getEmbalagem() { return embalagem; }
    public void setEmbalagem(String embalagem) { this.embalagem = embalagem; }
}
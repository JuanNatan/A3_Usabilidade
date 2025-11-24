# 📦 Controlador de Estoque WEB - A3 UNISUL

Este projeto é a entrega da **Avaliação 3 (A3)** da Unidade Curricular **Usabilidade e Desenvolvimento WEB** (UDW) da Universidade do Sul de Santa Catarina (**UNISUL**), com base no tema de **Desenvolvimento Web** para o problema de **Controle de Estoque**.

---

## 👨‍🎓 Aluno

Este trabalho foi desenvolvido individualmente.

| Nome Completo | RA |
| :--- | :--- |
| **Juan Natan dos Passos** | **10724268997** |

---

## 🛠️ Tecnologias Utilizadas

O projeto é uma aplicação web desenvolvida no modelo **MVC (Model-View-Controller)**, utilizando as seguintes tecnologias:

* **Linguagem:** Java
* **Servidor Web:** Apache Tomcat
* **Padrão de Componente:** Java Servlets (Controladores)
* **Páginas Web (Views):** JSP (JavaServer Pages) com JSTL (JavaServer Pages Standard Tag Library)
* **Acesso a Dados (Model):** JDBC para comunicação com o banco de dados.
* **Banco de Dados:** MySQL
* **Gerenciador de Dependências:** Maven

---

## 🚀 Funcionalidades Principais

O sistema permite a gestão completa do estoque, abrangendo os seguintes módulos e funcionalidades:

### 1. Cadastros Básicos (CRUDs)

* **Gerenciar Categorias:** Cadastro, listagem, edição e exclusão de categorias (Ex: Alimentos, Eletrônicos).
* **Gerenciar Produtos:** Cadastro, listagem, edição e exclusão de produtos. Um produto é associado a uma categoria e possui informações como preço, estoque mínimo e unidade de medida.

### 2. Operações de Estoque

* **Registro de Movimentação:** Funcionalidade para registrar a **Entrada** (compra/recebimento) ou **Saída** (venda/uso) de produtos, atualizando automaticamente a quantidade em estoque.
* **Reajuste de Preços:** Permite reajustar o preço unitário de **todos** os produtos com base em um percentual fornecido.

### 3. Relatórios Gerenciais

O sistema oferece relatórios essenciais para a tomada de decisão do comerciante:

1.  **Lista de Preços:** Relação de todos os produtos, preço unitário, unidade de medida e categoria.
2.  **Balanço Físico/Financeiro:** Exibe a quantidade em estoque, o valor unitário e o valor total em estoque para cada produto, além do valor total geral do estoque.
3.  **Produtos Abaixo do Estoque Mínimo:** Lista os produtos que precisam ser reabastecidos.
4.  **Contagem de Produtos por Categoria:** Quantidade de produtos distintos por categoria.
5.  **Produto Mais Movimentado:** Identifica o produto com maior fluxo de entrada e o produto com maior fluxo de saída.

---

## 💻 Estrutura do Projeto

A estrutura de pacotes e diretórios segue o padrão Maven para projetos Web (WAR):

* `Controlador/`: Pasta raiz do projeto.
    * `src/main/java/br/unisul/a3/`: Contém os pacotes Java.
        * `controle/`: **Servlets** (Controladores) - Responsáveis por receber requisições e chamar DAOs/JSPs.
        * `dao/`: **Data Access Objects (DAOs)** - Responsáveis pela lógica de acesso e manipulação de dados no MySQL.
        * `modelo/`: **Classes de Modelo (Beans/Entidades)** - Classes que representam as tabelas do banco de dados (Ex: `Produto`, `Categoria`, `Movimentacao`).
    * `src/main/webapp/`: Contém os recursos da aplicação web.
        * `categoria/`: Páginas JSP para Categoria.
        * `produto/`: Páginas JSP para Produto.
        * `movimentacao/`: Páginas JSP para Movimentação.
        * `relatorio/`: Páginas JSP para Relatórios.
        * `css/`: Arquivos CSS.
        * `img/`: Arquivos de imagem (logo).
        * `index.jsp`: Página inicial (Menu Principal).
        * `erro/erro.jsp`: Página de erro genérica.
    * `Controlador/pom.xml`: Arquivo de configuração do Maven.

---

## ⚙️ Configuração e Execução

### Pré-requisitos

1.  Java Development Kit (**JDK**) instalado (versão 8 ou superior).
2.  Apache Maven.
3.  Servidor Web **Apache Tomcat** (versão 9 ou superior).
4.  Banco de dados **MySQL** configurado.

### Passos

1.  **Configurar o Banco de Dados:**
    * Crie um banco de dados MySQL (ex: `controle_estoque_a3`).
    * Execute o script SQL para criação das tabelas e dados iniciais (o script não está incluso aqui, mas as tabelas são inferidas dos DAOs: `Categoria`, `Produto`, `Movimentacao`).
2.  **Configurar a Conexão:**
    * Edite a classe `Controlador/src/main/java/br/unisul/a3/dao/Conexao.java` para ajustar as credenciais e o nome do banco de dados (URL, usuário e senha) do seu MySQL.
3.  **Compilar e Empacotar (Maven):**
    * Navegue até o diretório `Controlador/`.
    * Execute o comando Maven para limpar e gerar o arquivo WAR:
        ```bash
        mvn clean install
        ```
    * O arquivo gerado (`Controlador.war` ou similar) estará na pasta `Controlador/target/`.
4.  **Deploy no Tomcat:**
    * Copie o arquivo WAR gerado para a pasta `webapps` do seu servidor Apache Tomcat.
    * Inicie o Tomcat.
5.  **Acessar a Aplicação:**
    * Abra o navegador e acesse a URL: `http://localhost:8080/Controlador/index.jsp` (o nome `Controlador` pode variar dependendo do nome do arquivo WAR).

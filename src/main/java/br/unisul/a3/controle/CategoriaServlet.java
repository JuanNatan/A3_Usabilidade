package br.unisul.a3.controle;

import br.unisul.a3.dao.CategoriaDAO;
import br.unisul.a3.modelo.Categoria;
// Importações Jakarta (se estiver usando Jakarta EE/Servlet 5+)
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/categoria")
public class CategoriaServlet extends HttpServlet {
    private final CategoriaDAO dao = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");
        if (acao == null) { acao = "listar"; }

        switch (acao) {
            case "listar":
                listarCategorias(request, response);
                break;
            case "novo":
                mostrarFormulario(request, response);
                break;
            case "editar":
                mostrarFormularioEdicao(request, response);
                break;
            case "excluir":
                excluirCategoria(request, response);
                break;
            default:
                listarCategorias(request, response);
                break;
        }
    }




    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");
        if ("salvar".equals(acao)) {
            salvarCategoria(request, response);
        } else {
            listarCategorias(request, response);
        }
    }

    private void listarCategorias(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Categoria> categorias = dao.listar();
            request.setAttribute("listaCategorias", categorias);
            request.getRequestDispatcher("/categoria/lista.jsp").forward(request, response);
        } catch (RuntimeException e) {
            request.setAttribute("mensagemErro", "Erro ao listar categorias: " + e.getMessage());
            request.getRequestDispatcher("/erro/erro.jsp").forward(request, response);
        }
    }

    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/categoria/form.jsp").forward(request, response);
    }




    private void mostrarFormularioEdicao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Categoria categoria = dao.buscarPorId(id);
            if (categoria != null) {
                request.setAttribute("categoria", categoria);
                request.getRequestDispatcher("/categoria/form.jsp").forward(request, response);
            } else {
                request.setAttribute("mensagemErro", "Categoria não encontrada.");
                listarCategorias(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("mensagemErro", "ID inválido.");
            listarCategorias(request, response);
        }
    }

    private void salvarCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        String nome = request.getParameter("nome");
        String tamanho = request.getParameter("tamanho");
        String embalagem = request.getParameter("embalagem");

        Categoria categoria = new Categoria(nome, tamanho, embalagem);

        try {
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);
                categoria.setId(id);
                dao.alterar(categoria);
                request.setAttribute("mensagemSucesso", "Categoria alterada com sucesso!");
            } else {
                dao.incluir(categoria);
                request.setAttribute("mensagemSucesso", "Categoria incluída com sucesso!");
            }

            listarCategorias(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("mensagemErro", "ID inválido no formulário.");
            mostrarFormulario(request, response);
        } catch (RuntimeException e) {
            request.setAttribute("mensagemErro", "Erro ao salvar categoria: " + e.getMessage());
            request.setAttribute("categoria", categoria);
            request.getRequestDispatcher("/categoria/form.jsp").forward(request, response);
        }
    }

    private void excluirCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.excluir(id);
            request.setAttribute("mensagemSucesso", "Categoria excluída com sucesso!");
        } catch (NumberFormatException e) {
            request.setAttribute("mensagemErro", "ID de exclusão inválido.");
        } catch (RuntimeException e) {
            request.setAttribute("mensagemErro", e.getMessage());
        }

        listarCategorias(request, response);
    }
}
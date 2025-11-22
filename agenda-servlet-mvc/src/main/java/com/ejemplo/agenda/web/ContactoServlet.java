package com.ejemplo.agenda.web;

import com.ejemplo.agenda.dao.ContactoDAO;
import com.ejemplo.agenda.model.Contacto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/contactos")
public class ContactoServlet extends HttpServlet {

    private final ContactoDAO dao = new ContactoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        try {
            switch (accion) {
                case "nuevo":
                    mostrarFormularioNuevo(request, response);
                    break;
                case "editar":
                    mostrarFormularioEditar(request, response);
                    break;
                case "eliminar":
                    eliminarContacto(request, response);
                    break;
                case "listar":
                default:
                    listarContactos(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        try {
            if ("insertar".equals(accion)) {
                insertarContacto(request, response);
            } else if ("actualizar".equals(accion)) {
                actualizarContacto(request, response);
            } else {
                response.sendRedirect("contactos?accion=listar");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    private void listarContactos(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        List<Contacto> lista = dao.listar();
        request.setAttribute("listaContactos", lista);
        request.getRequestDispatcher("/views/lista.jsp").forward(request, response);
    }

    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("modo", "nuevo");
        request.getRequestDispatcher("/views/form.jsp").forward(request, response);
    }

    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Contacto c = dao.buscarPorId(id);
        if (c == null) {
            response.sendRedirect("contactos?accion=listar");
            return;
        }
        request.setAttribute("modo", "editar");
        request.setAttribute("contacto", c);
        request.getRequestDispatcher("/views/form.jsp").forward(request, response);
    }

    private void insertarContacto(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        String nombre = request.getParameter("nombre");
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");

        Contacto c = new Contacto(nombre, telefono, email);
        dao.insertar(c);

        response.sendRedirect("contactos?accion=listar");
    }

    private void actualizarContacto(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");

        Contacto c = new Contacto(id, nombre, telefono, email);
        dao.actualizar(c);

        response.sendRedirect("contactos?accion=listar");
    }

    private void eliminarContacto(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        dao.eliminar(id);
        response.sendRedirect("contactos?accion=listar");
    }
}


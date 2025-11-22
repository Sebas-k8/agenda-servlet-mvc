<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.ejemplo.agenda.model.Contacto" %>

<%
    String modo = (String) request.getAttribute("modo");
    if (modo == null) {
        modo = "nuevo";
    }
    Contacto contacto = (Contacto) request.getAttribute("contacto");
    boolean esEditar = "editar".equalsIgnoreCase(modo);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= esEditar ? "Editar contacto" : "Nuevo contacto" %></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 40px auto;
            background-color: #ffffff;
            border-radius: 6px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
            padding: 25px 30px 30px 30px;
        }
        h1 {
            margin-top: 0;
            text-align: center;
        }
        form {
            margin-top: 15px;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
            margin-bottom: 4px;
        }
        input[type="text"],
        input[type="email"] {
            width: 100%;
            box-sizing: border-box;
            padding: 7px 10px;
            border-radius: 4px;
            border: 1px solid #cccccc;
        }
        .acciones {
            margin-top: 20px;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        .btn {
            background-color: #1976d2;
            color: #ffffff;
            padding: 8px 14px;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            cursor: pointer;
            font-size: 14px;
        }
        .btn:hover {
            background-color: #115293;
        }
        .btn-secondary {
            background-color: #757575;
        }
        .btn-secondary:hover {
            background-color: #494949;
        }
    </style>
</head>
<body>

<div class="container">
    <h1><%= esEditar ? "Editar contacto" : "Nuevo contacto" %></h1>

    <form action="<%= request.getContextPath() %>/contactos" method="post">
        <input type="hidden" name="accion" value="<%= esEditar ? "actualizar" : "insertar" %>"/>

        <% if (esEditar && contacto != null) { %>
            <input type="hidden" name="id" value="<%= contacto.getId() %>"/>
        <% } %>

        <label for="nombre">Nombre</label>
        <input type="text" id="nombre" name="nombre"
               value="<%= (contacto != null) ? contacto.getNombre() : "" %>" required/>

        <label for="telefono">Telefono</label>
        <input type="text" id="telefono" name="telefono"
               value="<%= (contacto != null) ? contacto.getTelefono() : "" %>"/>

        <label for="email">Email</label>
        <input type="email" id="email" name="email"
               value="<%= (contacto != null) ? contacto.getEmail() : "" %>"/>

        <div class="acciones">
            <a class="btn btn-secondary"
               href="<%= request.getContextPath() %>/contactos?accion=listar">
                Cancelar
            </a>
            <button type="submit" class="btn">
                Guardar
            </button>
        </div>
    </form>
</div>

</body>
</html>

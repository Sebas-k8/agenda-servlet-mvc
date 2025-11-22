<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ejemplo.agenda.model.Contacto" %>

<%
    List<Contacto> lista = (List<Contacto>) request.getAttribute("listaContactos");
    int total = (lista != null) ? lista.size() : 0;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Agenda de contactos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 900px;
            margin: 30px auto;
            background-color: #ffffff;
            border-radius: 6px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
            padding: 20px 25px 30px 25px;
        }
        h1 {
            margin-top: 0;
            text-align: center;
        }
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            flex-wrap: wrap;
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
        .btn-danger {
            background-color: #d32f2f;
        }
        .btn-danger:hover {
            background-color: #9a0007;
        }
        .btn-secondary {
            background-color: #757575;
        }
        .btn-secondary:hover {
            background-color: #494949;
        }
        #filtro {
            padding: 6px 10px;
            border-radius: 4px;
            border: 1px solid #cccccc;
            min-width: 200px;
        }
        .info {
            font-size: 13px;
            color: #555555;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 8px 10px;
            border-bottom: 1px solid #e0e0e0;
            text-align: left;
        }
        th {
            background-color: #eeeeee;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .acciones {
            white-space: nowrap;
        }
        .sin-datos {
            text-align: center;
            padding: 20px;
            color: #777777;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Agenda de contactos</h1>

    <div class="top-bar">
        <div>
            <a class="btn" href="<%= request.getContextPath() %>/contactos?accion=nuevo">Nuevo contacto</a>
        </div>
        <div>
            <input type="text" id="filtro" placeholder="Buscar por nombre..." onkeyup="filtrarTabla()">
        </div>
        <div class="info">
            Total de contactos: <strong><%= total %></strong>
        </div>
    </div>

    <table id="tablaContactos">
        <thead>
        <tr>
            <th>Id</th>
            <th>Nombre</th>
            <th>Telefono</th>
            <th>Email</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (lista != null && !lista.isEmpty()) {
                for (Contacto c : lista) {
        %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getNombre() %></td>
            <td><%= c.getTelefono() %></td>
            <td><%= c.getEmail() %></td>
            <td class="acciones">
                <a class="btn btn-secondary"
                   href="<%= request.getContextPath() %>/contactos?accion=editar&id=<%= c.getId() %>">
                    Editar
                </a>
                <a class="btn btn-danger"
                   href="<%= request.getContextPath() %>/contactos?accion=eliminar&id=<%= c.getId() %>"
                   onclick="return confirmarEliminar();">
                    Eliminar
                </a>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="5" class="sin-datos">
                No hay contactos registrados.
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<script>
    function confirmarEliminar() {
        return confirm("Seguro que deseas eliminar este contacto?");
    }

    function filtrarTabla() {
        var input = document.getElementById("filtro");
        var filter = input.value.toLowerCase();
        var table = document.getElementById("tablaContactos");
        var trs = table.getElementsByTagName("tr");

        for (var i = 1; i < trs.length; i++) { // empieza en 1 para saltar encabezado
            var tdNombre = trs[i].getElementsByTagName("td")[1]; // columna nombre
            if (tdNombre) {
                var txt = tdNombre.textContent || tdNombre.innerText;
                if (txt.toLowerCase().indexOf(filter) > -1) {
                    trs[i].style.display = "";
                } else {
                    trs[i].style.display = "none";
                }
            }
        }
    }
</script>

</body>
</html>

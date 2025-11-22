package com.ejemplo.agenda.dao;


import com.ejemplo.agenda.model.Contacto;
import com.ejemplo.agenda.util.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
public class ContactoDAO {
    
    public List<Contacto> listar() throws SQLException {
        List<Contacto> lista = new ArrayList<>();

        String sql = "SELECT id, nombre, telefono, email FROM contactos";

        try (Connection cn = DB.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Contacto c = new Contacto();
                c.setId(rs.getInt("id"));
                c.setNombre(rs.getString("nombre"));
                c.setTelefono(rs.getString("telefono"));
                c.setEmail(rs.getString("email"));
                lista.add(c);
            }
        }

        return lista;
    }

    public Contacto buscarPorId(int id) throws SQLException {
        String sql = "SELECT id, nombre, telefono, email FROM contactos WHERE id = ?";
        Contacto c = null;

        try (Connection cn = DB.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    c = new Contacto();
                    c.setId(rs.getInt("id"));
                    c.setNombre(rs.getString("nombre"));
                    c.setTelefono(rs.getString("telefono"));
                    c.setEmail(rs.getString("email"));
                }
            }
        }

        return c;
    }

    public void insertar(Contacto c) throws SQLException {
        String sql = "INSERT INTO contactos (nombre, telefono, email) VALUES (?, ?, ?)";

        try (Connection cn = DB.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, c.getNombre());
            ps.setString(2, c.getTelefono());
            ps.setString(3, c.getEmail());
            ps.executeUpdate();
        }
    }

    public void actualizar(Contacto c) throws SQLException {
        String sql = "UPDATE contactos SET nombre = ?, telefono = ?, email = ? WHERE id = ?";

        try (Connection cn = DB.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, c.getNombre());
            ps.setString(2, c.getTelefono());
            ps.setString(3, c.getEmail());
            ps.setInt(4, c.getId());
            ps.executeUpdate();
        }
    }

    public void eliminar(int id) throws SQLException {
        String sql = "DELETE FROM contactos WHERE id = ?";

        try (Connection cn = DB.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}

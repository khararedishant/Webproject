package com.advancedjava.dao;

import com.advancedjava.model.Book;
import com.advancedjava.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    public List<Book> findAll() throws SQLException {
        return search("");
    }

    public List<Book> search(String keyword) throws SQLException {
        List<Book> books = new ArrayList<Book>();
        String sql = "SELECT id,title,author,category,status FROM books " +
                     "WHERE title LIKE ? OR author LIKE ? OR category LIKE ? " +
                     "ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String key = "%" + (keyword == null ? "" : keyword.trim()) + "%";
            ps.setString(1, key);
            ps.setString(2, key);
            ps.setString(3, key);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    books.add(new Book(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("category"),
                        rs.getString("status")
                    ));
                }
            }
        }
        return books;
    }

    public Book findById(int id) throws SQLException {
        String sql = "SELECT id,title,author,category,status FROM books WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Book(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("category"),
                        rs.getString("status")
                    );
                }
            }
        }
        return null;
    }

    public void insert(Book book) throws SQLException {
        String sql = "INSERT INTO books(title,author,category,status) VALUES(?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getCategory());
            ps.setString(4, book.getStatus());
            ps.executeUpdate();
        }
    }

    public void update(Book book) throws SQLException {
        String sql = "UPDATE books SET title=?,author=?,category=?,status=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getCategory());
            ps.setString(4, book.getStatus());
            ps.setInt(5, book.getId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM books WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}

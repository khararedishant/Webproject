package com.advancedjava.controller;

import com.advancedjava.dao.BookDAO;
import com.advancedjava.model.Book;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/books")
public class BookServlet extends HttpServlet {

    private final BookDAO dao = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("book", dao.findById(id));
                request.getRequestDispatcher("/edit.jsp").forward(request, response);
                return;
            }

            String keyword = request.getParameter("keyword");
            request.setAttribute("keyword", keyword == null ? "" : keyword);
            request.setAttribute("books", dao.search(keyword));
            request.getRequestDispatcher("/index.jsp").forward(request, response);

        } catch (SQLException | NumberFormatException e) {
            throw new ServletException("Unable to load books.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            String action = request.getParameter("action");

            if ("add".equals(action)) {
                Book book = readBook(request, 0);
                dao.insert(book);

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Book book = readBook(request, id);
                dao.update(book);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.delete(id);
            }

            response.sendRedirect(request.getContextPath() + "/books");

        } catch (SQLException | NumberFormatException e) {
            throw new ServletException("Unable to process book request.", e);
        }
    }

    private Book readBook(HttpServletRequest request, int id) {
        return new Book(
            id,
            request.getParameter("title"),
            request.getParameter("author"),
            request.getParameter("category"),
            request.getParameter("status")
        );
    }
}

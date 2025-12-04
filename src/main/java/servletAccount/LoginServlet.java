package servletAccount;

import java.io.IOException;
import dao.UserDAO;
import daoimpl.UserDAOImpl;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({"/login", "/logoff"})
public class LoginServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
        String pass = req.getParameter("password");

        UserDAO dao = new UserDAOImpl();
        User user = dao.findById(id);

        if (user != null && user.getPassword().equals(pass)) {
            req.getSession().setAttribute("user", user);
            resp.sendRedirect("index.jsp");
        } else {
            req.setAttribute("message", "Invalid login!");
            req.getRequestDispatcher("/Account/Login.jsp").forward(req, resp);
        }
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.getSession().invalidate();
		req.getRequestDispatcher("/index.jsp").forward(req, resp);
	}
}

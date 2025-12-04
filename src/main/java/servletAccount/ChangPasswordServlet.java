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
import jakarta.servlet.http.HttpSession;

@WebServlet("/changepassword")
public class ChangPasswordServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if(session == null || session.getAttribute("user") == null) {
        	req.setAttribute("message", "Bạn chưa đăng nhập!");
            req.getRequestDispatcher("/Home/Login.jsp").forward(req, resp);
            return;
        }
		
		String pass = req.getParameter("currentPassword");
		String newpass = req.getParameter("newPassword");
		String confirm = req.getParameter("confirmPassword");
		User users = (User) session.getAttribute("user");
		UserDAO dao = new UserDAOImpl();
        User user = dao.findById(users.getId());       
        
        if(user.getPassword().equals(pass)) {
        	if(newpass.equals(confirm)) {
        		user.setPassword(newpass);
        		dao.update(user);
        		req.setAttribute("message", "Đăng nhập thành công");
        	}else {
        		req.setAttribute("message", "Xác nhận mật khẩu không đúng");
        	}
        }else {
        	req.setAttribute("message", "Mật khẩu không đúng");
        }
        
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
		
	}
}

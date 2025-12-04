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

@WebServlet("/otp")
public class OTPServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		
		String email =(String) session.getAttribute("email");
		String otp = req.getParameter("otp");
		String num = req.getParameter("number");
		
		if(num.equals(otp)) {
			UserDAO dao = new UserDAOImpl();
			User user = dao.findByEmail(email);
			user.setPassword(num);
			dao.update(user);
			req.getSession().invalidate();
			req.getRequestDispatcher("/Account/Login.jsp").forward(req, resp);
		}else {
			req.setAttribute("message", "Mã OTP không hợp lệ vui lòng kiểm tra lại");
			req.setAttribute("number", num);
			req.getRequestDispatcher("/Account/OTP.jsp").forward(req, resp);
		}
	}
}

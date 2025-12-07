package servletAccount;

import java.io.IOException;
import java.util.List;

import dao.UserDAO;
import daoimpl.UserDAOImpl;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.MailSender;

@WebServlet("/forgotpassword")
public class ForgotPasswordServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		String email = req.getParameter("email");

		UserDAO dao = new UserDAOImpl();
		User user = dao.findByIdEmail(id, email);
		if (user == null) {
			req.setAttribute("message", "Email hoặc Username này không tồn tại hoặc không trùng khớp!");
			req.getRequestDispatcher("/Account/ForgotPassword.jsp").forward(req, resp);
		}
		
		String subject = "Chào mừng đến với POLY-OE";
		long num = (long) (Math.random() * 9000000) + 1000000;
		String content = "Username: " + user.getId() +
						"\nEmail: " + user.getEmail() +
						"\nMã OTP của bạn là: " + num + 
						"\nLưu ý khi nhập mã OTP thành công sẽ trở thành Mật khẩu của bạn" + 
						"\nVui lòng thay đổi lại mật khẩu nếu cần thiết!";

		try {
			MailSender.sendMail(email, subject, content);
		} catch (Exception e) {
			e.printStackTrace();
		}
		req.getSession().setAttribute("number", num);
		req.setAttribute("id", user.getId());
		req.setAttribute("email", user.getEmail());
		req.getRequestDispatcher("/Account/OTP.jsp").forward(req, resp);
	}
}

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
import utils.MailSender;

@WebServlet("/forgotpassword")
public class ForgotPasswordServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
		String subject = "Chào mừng đến với POLY-OE";
		long num = (long) (Math.random() * 9000000) + 1000000;
		String content = "OTP của bạn là: " + num + "\nLưu ý khi nhập mã OTP thành công sẽ trở thành Mật khẩu của bạn" + "\nVui lòng thay đổi lại mật khẩu nếu cần thiết!";
		
		UserDAO dao = new UserDAOImpl();
		User user = dao.findByEmail(email);
		if(user == null) {
			req.setAttribute("message", "Email này không tồn tại!");
			req.getRequestDispatcher("/Account/ForgotPassword.jsp").forward(req, resp);
		}
		
		try {
		    MailSender.sendMail(email, subject, content);
		} catch (Exception e) {
		    e.printStackTrace();
		}
		req.getSession().setAttribute("email", email);
		req.setAttribute("number", num);
		req.getRequestDispatcher("/Account/OTP.jsp").forward(req, resp);
	}
}

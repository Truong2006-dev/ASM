package servletAccount;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import org.apache.commons.beanutils.BeanUtils;

import dao.UserDAO;
import daoimpl.UserDAOImpl;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User form = new User();
		try {
			BeanUtils.populate(form, req.getParameterMap());
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}

		String password = req.getParameter("password");
		String confirm = req.getParameter("confirmPassword");
		if (password.equals(confirm)) {
			UserDAO dao = new UserDAOImpl();
			User user = dao.findById(form.getId());
			if (user != null) {
				form = new User();	
				req.setAttribute("error", "Tên đăng nhập trùng vui lòng chọn tên khác");
				req.getRequestDispatcher("/Account/Register.jsp").forward(req, resp);
			}else {
				dao.create(form);			
				form = new User();	
				req.getRequestDispatcher("/Account/Login.jsp").forward(req, resp);
			}			
		} else {
			req.setAttribute("error", "Xác nhận mật khẩu không trùng khớp");
			req.getRequestDispatcher("/Account/Register.jsp");
		}

		
	}
}

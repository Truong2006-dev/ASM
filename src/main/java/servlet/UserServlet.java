package servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import org.apache.commons.beanutils.BeanUtils;
import daoimpl.UserDAOImpl;
import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({"/user/index", "/user/create", "/user/edit", "/user/update", "/user/delete", "/user/reset"})
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO dao = new UserDAOImpl();
        User form = new User();
        
        try {
            BeanUtils.populate(form, req.getParameterMap());
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }

        String path = req.getServletPath();
        String message = ""; 
        
        
        if (path.contains("create")) {
            dao.create(form);
            
            form = new User(); 
            message = "Thêm mới thành công!";
            
        } else if (path.contains("update")) {
            dao.update(form);
            
            resp.sendRedirect(req.getContextPath() + "/user/index?page=users");
            return; 
            
        } else if (path.contains("delete")) {
           
            String id = req.getParameter("id"); 
            dao.delete(id);
            form = new User();
            message = "Xóa thành công!";
            
        } else if (path.contains("reset")) {
            form = new User();
        }

      
        
        int pageSize = 10;
        long total = dao.count();
        int totalPages = (int) Math.ceil((double) total / pageSize); 

        String pageStr = req.getParameter("pageNumber");
        int pageNumber = 0;

        try {
            if (pageStr != null) {
                pageNumber = Integer.parseInt(pageStr);
            }
          
            if (pageNumber < 0) pageNumber = 0;
            if (pageNumber >= totalPages && totalPages > 0) pageNumber = totalPages - 1;
            
        } catch (NumberFormatException e) {
            pageNumber = 0;
        }

        List<User> list = dao.findAll(pageNumber, pageSize);

        req.setAttribute("message", message);
        req.setAttribute("pageNumber", pageNumber);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("user", form); 
        req.setAttribute("users", list);
        
        req.getRequestDispatcher("/gui/admin.jsp").forward(req, resp);
    }
}
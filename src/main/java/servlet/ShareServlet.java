package servlet;

import java.io.IOException;
import java.util.Date;

import dao.SharesDAO;
import dao.VideosDAO;
import daoimpl.SharesDAOImpl;
import daoimpl.VideosDAOImpl;
import entity.Shares;
import entity.User;
import entity.Videos;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.MailSender;

@WebServlet({"/share", "/shareVideo"})
public class ShareServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		if(uri.endsWith("/share")) {
			String idvid = req.getParameter("id");
			req.setAttribute("idvid", idvid);
			req.getRequestDispatcher("/Home/Share.jsp").forward(req, resp);
		} else if(uri.endsWith("/shareVideo")) {
			String idvid = req.getParameter("vidid");
			String email = req.getParameter("email");
			User users = (User) req.getSession().getAttribute("user");
			
			VideosDAO viddao = new VideosDAOImpl();
			Videos vid = viddao.findById(idvid);
			String link = "https://www.youtube.com/watch?v=" + vid.getId();
			
			String subject = "Chào mừng đến với POLY-OE";
			String content = "Người dùng: " + users.getId() + 
							"\nEmail: " + users.getEmail() +
							"\nNgười dùng này có gửi đến 1 video" + 
							"\nTận hưởng ngay: 👉" + link;
			
			try {
			    MailSender.sendMail(email, subject, content);
			} catch (Exception e) {
			    e.printStackTrace();
			}
			
			SharesDAO shadao = new SharesDAOImpl();
			Shares share = new Shares();
			share.setUser(users);
			share.setVideo(vid);
			share.setEmails(email);
			share.setShareDate(new Date());
			shadao.create(share);
			
			req.getRequestDispatcher("/crud/index").forward(req, resp);
		}
		
	}
}

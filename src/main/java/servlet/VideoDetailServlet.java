package servlet;

import java.io.IOException;

import dao.FavoritesDAO;
import dao.VideosDAO;
import daoimpl.FavoritesDAOImpl;
import daoimpl.VideosDAOImpl;
import entity.Favorites;
import entity.User;
import entity.Videos;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/crud/detail")
public class VideoDetailServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Videos video= new Videos();
		VideosDAO viddao = new VideosDAOImpl();
		String id = req.getParameter("id");
		video = viddao.findById(id);
		
		User users = (User) req.getSession().getAttribute("user");
		FavoritesDAO favdao = new FavoritesDAOImpl();
		Favorites fav = new Favorites();
		try {
			fav = favdao.findByUserAndVideo(users.getId(), id);
		}catch(Exception e) {
			fav = null;
		}
		
		req.setAttribute("video", video);
		req.setAttribute("favorite", fav);
		req.getRequestDispatcher("/Home/Video.jsp").forward(req, resp);
	}
}

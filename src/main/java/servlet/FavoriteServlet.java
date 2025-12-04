package servlet;

import java.io.IOException;
import java.util.Date;
import java.util.List;

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
import jakarta.servlet.http.HttpSession;

@WebServlet({ "/favorites", "/like", "/dislike", "/favoritesdislike"})
public class FavoriteServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		if (uri.endsWith("/favorites")) {
			HttpSession session = req.getSession(false);
			if (session == null || session.getAttribute("user") == null) {
				req.getRequestDispatcher("/Account/Login.jsp").forward(req, resp);
				return;
			}
			
			User users = (User) session.getAttribute("user");
			int pageSize = 6;
			String pageStr = req.getParameter("pageNumber");
			String pageNumberLast1 = req.getParameter("pageNumberLast");
			int pageNumberLast2 = -1;
			int pageNumber = 0;

			if (pageStr != null) {
				try {
					int page = Integer.parseInt(pageStr);
					if (page >= 0) {
						pageNumber = page;
					}
				} catch (NumberFormatException e) {
					pageNumber = 0; 
				}
			}
			
			if (pageNumberLast1 != null) {
				try {
					pageNumberLast2 = Integer.parseInt(pageNumberLast1);
				} catch (NumberFormatException e) {
					
				}
			}
					
			FavoritesDAO favdao1 = new FavoritesDAOImpl();
			long total = favdao1.countFavoriteByUserId(users.getId());
			if (pageNumber >= total) {
				pageNumber -= 6;
			}
				
			if(pageNumberLast2 == 0) {
				pageNumber = 0;
				for(int i=0;i<total-6;i+=6) {
					pageNumber += 6;
				}
				
			}
			
			if(pageNumber < 0) {
				pageNumber = 0;
			}

			
			FavoritesDAO favdao2 = new FavoritesDAOImpl();
			List<Favorites> favList = favdao2.findPageSize(users.getId(), pageNumber, pageSize);
			req.setAttribute("pageNumber", pageNumber);
			req.setAttribute("favorites", favList);
			req.getRequestDispatcher("/Home/Favorites.jsp").forward(req, resp);

		} else if (uri.endsWith("/like")) {
			String id = req.getParameter("id");
			User users = (User) req.getSession().getAttribute("user");
			VideosDAO viddao = new VideosDAOImpl();
			Videos video = viddao.findById(id);

			FavoritesDAO favdao = new FavoritesDAOImpl();
			Favorites fav = new Favorites();
			fav.setUser(users);
			fav.setVideo(video);
			fav.setLikeDate(new Date());
			favdao.create(fav);

			String path = req.getParameter("path");
			if (path.equals("home")) {
				req.getRequestDispatcher("/crud/index").forward(req, resp);
			} else if (path.equals("video")) {
				req.getRequestDispatcher("/crud/detail").forward(req, resp);
			}

		} else if (uri.endsWith("/dislike")) {
			String id = req.getParameter("id");
			User users = (User) req.getSession().getAttribute("user");
			FavoritesDAO favdao = new FavoritesDAOImpl();
			Favorites fav = favdao.findByUserAndVideo(users.getId(), id);
			favdao.delete(fav.getId());
			
			String path = req.getParameter("path");
			if (path.equals("home")) {
				req.getRequestDispatcher("/crud/index").forward(req, resp);
			} else if (path.equals("video")) {
				req.getRequestDispatcher("/crud/detail").forward(req, resp);
			}
			
		} else if (uri.endsWith("/favoritesdislike")) {
			Long id = Long.parseLong(req.getParameter("id"));
			FavoritesDAO favdao = new FavoritesDAOImpl();
			favdao.delete(id);
			req.getRequestDispatcher("/favorites").forward(req, resp);

		}

	}
}

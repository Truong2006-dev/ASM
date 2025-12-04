package servlet;

import java.io.IOException;
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

@WebServlet("/crud/index")
public class TrangChuServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
				
		VideosDAO vidDao = new VideosDAOImpl();
		long total = vidDao.count();
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
	
		List<Videos> vidList = vidDao.findPageSize(pageNumber, pageSize);
		User users = (User) req.getSession().getAttribute("user");
		if(users != null) {
			FavoritesDAO favdao = new FavoritesDAOImpl();
			List<Favorites> fav = favdao.findByUserId(users.getId());
			req.setAttribute("favorite", fav);
		}
		
		
		
		req.setAttribute("pageNumber", pageNumber);
		req.setAttribute("videos", vidList);
		req.getRequestDispatcher("/Home/TrangChu.jsp").forward(req, resp);
	}
}

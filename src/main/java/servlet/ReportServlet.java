package servlet;

import java.io.IOException;
import java.util.List;
import daoimpl.StatsDAOImpl;
import daoimpl.VideosDAOImpl;
import entity.Videos;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/report")
public class ReportServlet extends HttpServlet {
    
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        StatsDAOImpl statsDao = new StatsDAOImpl();
        VideosDAOImpl vidDao = new VideosDAOImpl();
        
        // 1. Xác định đang ở Tab nào (Mặc định là 'favorites')
        String tab = req.getParameter("tab");
        if (tab == null) tab = "favorites";
        
        // 2. Load danh sách Video để đổ vào Dropdown (Select box) cho Tab 2 và 3
        List<Videos> listVid = vidDao.findAll();
        req.setAttribute("vidList", listVid);
        
        // 3. Xử lý dữ liệu cho từng Tab
        switch (tab) {
            case "favorites":
                // Lấy dữ liệu thống kê tổng hợp
                List<Object[]> listFav = statsDao.getReportFavorites();
                req.setAttribute("reportData", listFav);
                break;
                
            case "favorite-users":
                // Lấy videoID đang chọn
                String vidUser = req.getParameter("vid");
                // Nếu chưa chọn thì lấy video đầu tiên trong list
                if (vidUser == null && !listVid.isEmpty()) {
                    vidUser = listVid.get(0).getId();
                }
                
                req.setAttribute("vidSelected", vidUser);
                req.setAttribute("reportData", statsDao.getReportFavoriteUsers(vidUser));
                break;
                
            case "shared-friends":
                String vidShare = req.getParameter("vid");
                if (vidShare == null && !listVid.isEmpty()) {
                    vidShare = listVid.get(0).getId();
                }
                
                req.setAttribute("vidSelected", vidShare);
                req.setAttribute("reportData", statsDao.getReportSharedFriends(vidShare));
                break;
        }
        
        // 4. Gửi thông tin tab hiện tại về JSP để active đúng tab
        req.setAttribute("tab", tab);
        
        // 5. Forward về trang giao diện
        req.getRequestDispatcher("/gui/admin.jsp?page=reports").forward(req, resp);
    }
}
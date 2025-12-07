package servlet;

import java.io.IOException;
import java.util.List;

import dao.VideosDAO;
import daoimpl.VideosDAOImpl;
import entity.Videos;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Bạn có thể thêm url /video/search vào đây nếu muốn, hoặc dùng chung /video/index đều được
@WebServlet({"/video/index", "/video/create", "/video/update", "/video/delete", "/video/search"})
public class VideoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Cấu hình tiếng Việt ngay đầu hàm service
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        VideosDAO dao = new VideosDAOImpl();
        String path = req.getServletPath();
        String message = "";
        
        // --- XỬ LÝ CREATE (THÊM MỚI) ---
        if (path.contains("create")) {
            if (req.getMethod().equalsIgnoreCase("POST")) {
                try {
                    Videos form = new Videos();
                    
                    String id = req.getParameter("id");
                    String title = req.getParameter("titile"); 
                    String desc = req.getParameter("description");
                    boolean active = req.getParameter("active") != null;

                    form.setId(id);
                    form.setTitile(title);
                    form.setDescription(desc);
                    form.setActive(active);
                    form.setViews(0); 

                    if (id != null && !id.isEmpty()) {
                        String posterUrl = "https://img.youtube.com/vi/" + id + "/hqdefault.jpg";
                        String fullLink = "https://www.youtube.com/watch?v=" + id;
                        form.setPoster(posterUrl);
                        form.setLink(fullLink);
                    }

                    dao.create(form);
                    message = "Thêm video thành công!";
                } catch (Exception e) {
                    message = "Lỗi thêm mới: " + e.getMessage();
                    e.printStackTrace();
                }
            }
            
        // --- XỬ LÝ UPDATE (CẬP NHẬT) ---
        } else if (path.contains("update")) {
            if (req.getMethod().equalsIgnoreCase("POST")) {
                try {
                    String id = req.getParameter("id");
                    Videos videoInDB = dao.findById(id);

                    if (videoInDB != null) {
                        String newTitle = req.getParameter("titile");
                        String newDesc = req.getParameter("description");
                        boolean newActive = req.getParameter("active") != null;

                        videoInDB.setTitile(newTitle);
                        videoInDB.setDescription(newDesc);
                        videoInDB.setActive(newActive);
                        
                        dao.update(videoInDB);
                        message = "Cập nhật thành công!";
                    } else {
                        message = "Lỗi: Không tìm thấy video có ID = " + id;
                    }

                } catch (Exception e) {
                    message = "Lỗi cập nhật: " + e.getMessage();
                    e.printStackTrace();
                }
            }
            
        // --- XỬ LÝ DELETE (XÓA) ---
        } else if (path.contains("delete")) {
            String id = req.getParameter("id");
            if (id != null) {
                try {
                    dao.delete(id);
                    message = "Đã xóa video!";
                } catch (Exception e) {
                    message = "Lỗi xóa: " + e.getMessage();
                }
            }
        }

        // --- HIỂN THỊ DANH SÁCH & TÌM KIẾM (ĐOẠN NÀY ĐÃ ĐƯỢC SỬA) ---
        
        String keyword = req.getParameter("keyword"); // Lấy từ khóa từ ô tìm kiếm
        List<Videos> list;

        if (keyword != null && !keyword.isBlank()) {
            // Nếu có từ khóa -> Gọi hàm tìm kiếm (hàm bạn vừa thêm ở DAO)
            list = dao.findByKeyword(keyword);
            
            if (list.isEmpty()) {
                message = "Không tìm thấy video nào chứa: " + keyword;
            } else {
                message = "Kết quả tìm kiếm cho: " + keyword;
            }
            // Lưu lại keyword để hiển thị lại trên ô input (UX)
            req.setAttribute("searchKeyword", keyword); 
        } else {
            // Nếu không tìm kiếm -> Hiện tất cả như cũ
            list = dao.findAll();
        }

        req.setAttribute("videos", list);
        req.setAttribute("message", message);
        
        // Forward về trang admin
        req.getRequestDispatcher("/gui/admin.jsp?page=videos").forward(req, resp);
    }
}
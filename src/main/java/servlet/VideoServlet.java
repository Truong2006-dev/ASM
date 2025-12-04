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

@WebServlet({"/video/index", "/video/create", "/video/update", "/video/delete"})
public class VideoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        VideosDAO dao = new VideosDAOImpl();
        String path = req.getServletPath();
        String message = "";
        
        // --- XỬ LÝ CREATE (THÊM MỚI) ---
        if (path.contains("create")) {
            if (req.getMethod().equalsIgnoreCase("POST")) {
                try {
                    Videos form = new Videos();
                    
                    // Lấy dữ liệu thủ công để kiểm soát tốt hơn
                    String id = req.getParameter("id");
                    String title = req.getParameter("titile"); // Chú ý: Entity của bạn là titile
                    String desc = req.getParameter("description");
                    boolean active = req.getParameter("active") != null; // Checkbox: có gửi là true, không gửi là false

                    form.setId(id);
                    form.setTitile(title);
                    form.setDescription(desc);
                    form.setActive(active);
                    form.setViews(0); // Mới tạo thì view = 0

                    // Tự động tạo Poster & Link từ ID
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
            
        // --- XỬ LÝ UPDATE (CẬP NHẬT - ĐÃ SỬA LỖI MẤT VIEW) ---
        } else if (path.contains("update")) {
            if (req.getMethod().equalsIgnoreCase("POST")) {
                try {
                    String id = req.getParameter("id");
                    
                    // BƯỚC 1: Tìm video cũ trong Database
                    Videos videoInDB = dao.findById(id);

                    if (videoInDB != null) {
                        // BƯỚC 2: Chỉ cập nhật các thông tin thay đổi
                        String newTitle = req.getParameter("titile");
                        String newDesc = req.getParameter("description");
                        boolean newActive = req.getParameter("active") != null;

                        videoInDB.setTitile(newTitle);
                        videoInDB.setDescription(newDesc);
                        videoInDB.setActive(newActive);
                        
                        // Nếu muốn cho phép đổi cả Link Youtube khi sửa thì thêm đoạn này:
                        // String posterUrl = "https://img.youtube.com/vi/" + id + "/hqdefault.jpg";
                        // String fullLink = "https://www.youtube.com/watch?v=" + id;
                        // videoInDB.setPoster(posterUrl);
                        // videoInDB.setLink(fullLink);

                        // BƯỚC 3: Lưu lại (Lúc này Views vẫn giữ nguyên giá trị cũ)
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

        // --- HIỂN THỊ DANH SÁCH ---
        List<Videos> list = dao.findAll();
        req.setAttribute("videos", list);
        req.setAttribute("message", message);
        
        // Forward về trang admin
        req.getRequestDispatcher("/gui/admin.jsp?page=videos").forward(req, resp);
    }
}
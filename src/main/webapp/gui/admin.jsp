<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản trị hệ thống - PolyOE</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #f8f9fa; font-family: Arial, sans-serif; }
        .sidebar { min-height: 100vh; background: #2c3e50; color: #ecf0f1; }
        .sidebar .nav-link { color: #bdc3c7; padding: 15px 20px; border-bottom: 1px solid #34495e; transition: 0.3s; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background-color: #34495e; color: #fff; border-left: 4px solid #3498db; }
        .sidebar i { width: 25px; text-align: center; margin-right: 10px; }
        .top-navbar { background: #fff; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .main-content { padding: 30px; }
        .card-custom { border: none; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .card-header-custom { background-color: #fff; border-bottom: 1px solid #eee; padding: 15px 20px; font-weight: bold; color: #2c3e50; }
        
        /* Style cho khung preview video */
        .video-preview { width: 100%; height: 200px; background: #eee; display: flex; align-items: center; justify-content: center; overflow: hidden; border-radius: 5px; border: 1px dashed #ccc; }
        .video-preview img { width: 100%; height: auto; object-fit: cover; }
        
        .poster-container { position: relative; cursor: pointer; display: inline-block; }
        .play-overlay {
            position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
            color: white; background: rgba(0,0,0,0.6); border-radius: 50%; width: 40px; height: 40px;
            display: flex; align-items: center; justify-content: center; opacity: 0.8; transition: 0.3s;
        }
        .poster-container:hover .play-overlay { background: rgba(255,0,0,0.8); transform: translate(-50%, -50%) scale(1.1); }
    </style>
</head>
<body>
    <c:url var="url" value="/user"/>
    <c:url var="videoUrl" value="/video"/> 
    <c:url var="reportUrl" value="/admin/report"/> 

    <div class="container-fluid">
        <div class="row">
            
            <div class="col-md-3 col-lg-2 px-0 sidebar d-none d-md-block">
                <div class="py-4 text-center bg-dark">
                    <h5 class="m-0 fw-bold text-uppercase text-white">PolyOE Admin</h5>
                </div>
                <div class="nav flex-column">
                    <a href="${url}/index" class="nav-link ${param.page == null ? 'active' : ''}">
                        <i class="fa-solid fa-house"></i> Trang chủ
                    </a>
                    <a href="${url}/index?page=users" class="nav-link ${param.page == 'users' ? 'active' : ''}">
                        <i class="fa-solid fa-users"></i> Quản lý Người dùng
                    </a>
                    
                    <a href="${videoUrl}/index?page=videos" class="nav-link ${param.page == 'videos' ? 'active' : ''}">
                        <i class="fa-solid fa-film"></i> Quản lý Video
                    </a>

                    <a href="${reportUrl}?page=reports&tab=favorites" class="nav-link ${param.page == 'reports' ? 'active' : ''}">
                        <i class="fa-solid fa-chart-pie"></i> Báo cáo thống kê
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/crud/index" class="nav-link mt-5 text-warning">
                        <i class="fa-solid fa-arrow-left"></i> Xem trang web
                    </a>
                </div>
            </div>

            <div class="col-md-9 col-lg-10 px-0 bg-light">
                <nav class="navbar navbar-expand top-navbar py-3 px-4 justify-content-between">
                    <h5 class="m-0 text-secondary">Hệ thống quản trị</h5>
                    <div class="dropdown">
                        <a class="text-dark text-decoration-none dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fa-solid fa-user-circle fa-lg me-1"></i> Admin
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logoff">Đăng xuất</a></li>
                        </ul>
                    </div>
                </nav>

                <div class="main-content">
                    <c:choose>
                        
                        <%-- CASE 1: USER --%>
                        <c:when test="${param.page == 'users'}">
                            <div class="card card-custom">
                                <div class="card-header-custom d-flex justify-content-between align-items-center">
                                    <span>Danh sách Người dùng</span>
                                </div>
                                <div class="card-body">
                                    <c:if test="${not empty users}">
                                        <table class="table table-bordered table-hover">
                                            <thead class="table-light">
                                                <tr><th>ID</th><th>Họ tên</th><th>Email</th><th>Vai trò</th><th>Hành động</th></tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${users}">
                                                    <tr>
                                                        <td>${item.id}</td><td>${item.fullname}</td><td>${item.email}</td>
                                                        <td><span class="badge ${item.admin ? 'bg-danger' : 'bg-success'}">${item.admin ? 'Admin' : 'User'}</span></td>
                                                        <td>
                                                            <button class="btn btn-sm btn-warning"><i class="fa-solid fa-pen"></i></button>
                                                            <a href="${url}/delete?id=${item.id}" class="btn btn-sm btn-danger"><i class="fa-solid fa-trash"></i></a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
                                </div>
                            </div>
                        </c:when>

                        <%-- CASE 2: VIDEO --%>
                        <c:when test="${param.page == 'videos'}">
                            <div class="card card-custom">
                                <div class="card-header-custom d-flex justify-content-between align-items-center">
                                    <span>Kho Video</span>
                                    <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#createVideoModal">
                                        <i class="fa-solid fa-upload"></i> Upload Video
                                    </button>
                                </div>
                                <div class="card-body">
                                    <c:if test="${empty videos}">
                                        <div class="text-center py-5 text-muted border border-dashed rounded">
                                            <i class="fa-solid fa-video-slash fa-3x mb-3"></i>
                                            <p>Chưa có video nào.</p>
                                        </div>
                                    </c:if>

                                    <c:if test="${not empty videos}">
                                        <table class="table table-bordered align-middle">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Poster</th>
                                                    <th>Tiêu đề Video</th>
                                                    <th>Lượt xem</th>
                                                    <th>Trạng thái</th>
                                                    <th>Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="vid" items="${videos}">
                                                    <tr>
                                                        <td style="width: 140px;" class="text-center">
                                                            <div class="poster-container" onclick="playVideo('${vid.id}', '${vid.titile}')">
                                                                <img src="https://img.youtube.com/vi/${vid.id}/mqdefault.jpg" 
                                                                     class="img-fluid rounded" 
                                                                     alt="poster" onerror="this.src='https://placehold.co/120x90?text=Lỗi+Ảnh';">
                                                                <div class="play-overlay"><i class="fa-solid fa-play"></i></div>
                                                            </div>
                                                        </td>
                                                        <td>${vid.titile}</td> 
                                                        <td>${vid.views}</td>
                                                        <td>
                                                            <span class="badge ${vid.active ? 'bg-success' : 'bg-secondary'}">
                                                                ${vid.active ? 'Hoạt động' : 'Ẩn'}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <button type="button" class="btn btn-sm btn-info text-white me-1" onclick="playVideo('${vid.id}', '${vid.titile}')"><i class="fa-solid fa-play-circle"></i></button>
                                                            <button type="button" class="btn btn-sm btn-warning" onclick="editVideo('${vid.id}', '${vid.titile}', '${vid.description}', ${vid.active})"><i class="fa-solid fa-pen"></i></button>
                                                            <a href="${videoUrl}/delete?id=${vid.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa video này không?');"><i class="fa-solid fa-trash"></i></a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
                                </div>
                            </div>
                        </c:when>

                        <%-- CASE 3: REPORTS - NHÚNG FILE REPORT.JSP TỪ THƯ MỤC GUI --%>
                        <c:when test="${param.page == 'reports'}">
                            <jsp:include page="/gui/Report.jsp"></jsp:include>
                        </c:when>

                        <c:otherwise>
                            <div class="alert alert-light border-start border-primary border-4 shadow-sm" role="alert">
                                <h4 class="alert-heading">Xin chào, Quản trị viên!</h4>
                                <p>Hãy chọn một chức năng từ menu bên trái để bắt đầu làm việc.</p>
                            </div>
                        </c:otherwise>

                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="createVideoModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title">Thêm mới Video</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/video/create" method="post">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-7">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Youtube Link</label>
                                    <input type="text" class="form-control" id="youtube-link" placeholder="Dán link Youtube vào đây..." required oninput="previewYoutube()">
                                    <input type="hidden" name="id" id="video-id">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Tiêu đề</label>
                                    <input type="text" class="form-control" name="titile" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Mô tả</label>
                                    <textarea class="form-control" name="description" rows="3"></textarea>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" name="active" value="true" checked>
                                    <label>Kích hoạt</label>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <label class="form-label fw-bold">Preview</label>
                                <div class="video-preview border p-1 rounded">
                                    <img id="video-poster" src="https://placehold.co/600x400?text=No+Image" alt="Poster">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-success">Lưu Video</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="updateVideoModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-warning text-dark">
                    <h5 class="modal-title fw-bold">Cập nhật Video</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/video/update" method="post">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-7">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Youtube Link / ID</label>
                                    <input type="text" class="form-control" id="edit-youtube-link" 
                                           oninput="previewYoutubeEdit()" placeholder="https://www.youtube.com/watch?v=...">
                                    
                                    <input type="hidden" name="id" id="edit-video-id">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Tiêu đề</label>
                                    <input type="text" class="form-control" name="titile" id="edit-title" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Mô tả</label>
                                    <textarea class="form-control" name="description" id="edit-description" rows="3"></textarea>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" name="active" id="edit-active" value="true">
                                    <label class="form-check-label" for="edit-active">Kích hoạt</label>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <label class="form-label fw-bold">Preview</label>
                                <div class="video-preview border p-1 rounded">
                                    <img id="edit-video-poster" src="https://placehold.co/600x400?text=No+Image" alt="Poster">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-warning fw-bold">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="playVideoModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content bg-black">
                <div class="modal-header border-0 p-2">
                    <h6 class="modal-title text-white ms-2" id="playVideoTitle">Video Player</h6>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close" onclick="stopVideo()"></button>
                </div>
                <div class="modal-body p-0">
                    <div class="ratio ratio-16x9">
                        <iframe id="videoIframe" src="" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        const playModal = new bootstrap.Modal(document.getElementById('playVideoModal'));
        const iframe = document.getElementById('videoIframe');
        const modalTitle = document.getElementById('playVideoTitle');

        function playVideo(videoId, title) {
            iframe.src = "https://www.youtube.com/embed/" + videoId + "?autoplay=1";
            modalTitle.innerText = title;
            playModal.show();
        }

        function stopVideo() {
            iframe.src = "";
        }

        document.getElementById('playVideoModal').addEventListener('hidden.bs.modal', function () {
            stopVideo();
        });

        function previewYoutube() {
            var url = document.getElementById("youtube-link").value;
            var img = document.getElementById("video-poster");
            var idInput = document.getElementById("video-id");
            var regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|&v=)([^#&?]*).*/;
            var match = url.match(regExp);
            if (match && match[2].length == 11) {
                var videoId = match[2];
                img.src = "https://img.youtube.com/vi/" + videoId + "/hqdefault.jpg";
                idInput.value = videoId;
            } else {
                img.src = "https://placehold.co/600x400?text=Invalid+Link";
                idInput.value = "";
            }
        }

        const updateModalElement = document.getElementById('updateVideoModal');
        const updateModal = new bootstrap.Modal(updateModalElement);

        function editVideo(id, title, description, active) {
            document.getElementById('edit-video-id').value = id;
            document.getElementById('edit-title').value = title;
            document.getElementById('edit-description').value = description;
            document.getElementById('edit-youtube-link').value = "https://www.youtube.com/watch?v=" + id;
            document.getElementById('edit-video-poster').src = "https://img.youtube.com/vi/" + id + "/hqdefault.jpg";
            document.getElementById('edit-active').checked = active;
            updateModal.show();
        }

        function previewYoutubeEdit() {
            var url = document.getElementById("edit-youtube-link").value;
            var img = document.getElementById("edit-video-poster");
            var idInput = document.getElementById("edit-video-id");
            var regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|&v=)([^#&?]*).*/;
            var match = url.match(regExp);
            if (match && match[2].length == 11) {
                var videoId = match[2];
                img.src = "https://img.youtube.com/vi/" + videoId + "/hqdefault.jpg";
                idInput.value = videoId;
            } else {
                img.src = "https://placehold.co/600x400?text=Invalid+Link";
            }
        }
    </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: #f8f9fa; /* Màu nền xám nhẹ */
            min-height: 100vh;
            display: flex;
            align-items: center; /* Căn giữa theo chiều dọc */
            justify-content: center; /* Căn giữa theo chiều ngang */
        }
        .card-profile {
            border: none;
            border-radius: 15px;
            overflow: hidden;
        }
        .card-header-profile {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); /* Màu Gradient tím xanh */
            padding: 30px 20px;
            color: white;
            text-align: center;
        }
        .form-control:focus {
            box-shadow: none;
            border-color: #764ba2;
        }
        .btn-save {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 12px;
            font-weight: bold;
            letter-spacing: 1px;
            transition: 0.3s;
        }
        .btn-save:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                
                <div class="card card-profile shadow-lg">
                    
                    <div class="card-header-profile">
                        <div class="mb-2">
                            <i class="fa-solid fa-circle-user fa-4x"></i>
                        </div>
                        <h4 class="mb-0">Cập nhật hồ sơ</h4>
                        <small>Chỉnh sửa thông tin cá nhân của bạn</small>
                    </div>

                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/editprofile" method="post">
                            
                            <div class="mb-3">
                                <label class="form-label text-muted small fw-bold">USERNAME</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0">
                                        <i class="fa-solid fa-id-badge text-secondary"></i>
                                    </span>
                                    <input type="text" class="form-control border-start-0 bg-light" 
                                           name="id" 
                                           value="${sessionScope.user.id}" 
                                           readonly>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label text-muted small fw-bold">FULL NAME</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white border-end-0">
                                        <i class="fa-solid fa-user text-secondary"></i>
                                    </span>
                                    <input type="text" class="form-control border-start-0" 
                                           name="fullname" 
                                           value="${sessionScope.user.fullname}" 
                                           required>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label class="form-label text-muted small fw-bold">EMAIL ADDRESS</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white border-end-0">
                                        <i class="fa-solid fa-envelope text-secondary"></i>
                                    </span>
                                    <input type="email" class="form-control border-start-0" 
                                           name="email" 
                                           value="${sessionScope.user.email}" 
                                           required>
                                </div>
                            </div>
                            
                            <div>
                            	<input type="hidden" name="password" value="${sessionScope.user.password}">
                            	<input type="hidden" name="admin" value="${sessionScope.user.admin}">
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-save text-white rounded-pill">
                                    SAVE CHANGES
                                </button>
                            </div>
                            
                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/crud/index" class="text-decoration-none text-secondary small">
                                    <i class="fa-solid fa-arrow-left"></i> Quay lại
                                </a>
                            </div>

                        </form>
                    </div>
                </div>
                </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
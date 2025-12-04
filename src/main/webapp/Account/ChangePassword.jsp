<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi mật khẩu</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: #f8f9fa;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card-auth {
            border: none;
            border-radius: 15px;
            overflow: hidden;
        }
        .card-header-auth {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); /* Màu đồng bộ */
            padding: 25px 20px;
            color: white;
            text-align: center;
        }
        .btn-auth {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 12px;
            font-weight: bold;
            letter-spacing: 1px;
            transition: 0.3s;
        }
        .btn-auth:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                
                <div class="card card-auth shadow-lg">
                    
                    <div class="card-header-auth">
                        <div class="mb-2">
                            <i class="fa-solid fa-shield-halved fa-3x"></i>
                        </div>
                        <h4 class="mb-0">Đổi mật khẩu</h4>
                        <small class="text-white-50">Bảo vệ tài khoản của bạn</small>
                    </div>

                    <div class="card-body p-4">
                        
                        <c:if test="${not empty message}">
                            <div class="alert alert-info text-center small py-2 mb-3">${message}</div>
                        </c:if>

                        <form action="ChangePassword" method="post">
                            
                            <div class="mb-3">
                                <label class="form-label text-muted small fw-bold">CURRENT PASSWORD</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white border-end-0">
                                        <i class="fa-solid fa-key text-secondary"></i>
                                    </span>
                                    <input type="password" class="form-control border-start-0" 
                                           name="currentPassword" required placeholder="••••••">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label text-muted small fw-bold">NEW PASSWORD</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white border-end-0">
                                        <i class="fa-solid fa-lock text-secondary"></i>
                                    </span>
                                    <input type="password" class="form-control border-start-0" 
                                           name="newPassword" required placeholder="••••••">
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label text-muted small fw-bold">CONFIRM PASSWORD</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white border-end-0">
                                        <i class="fa-solid fa-check-double text-secondary"></i>
                                    </span>
                                    <input type="password" class="form-control border-start-0" 
                                           name="confirmPassword" required placeholder="••••••">
                                </div>
                            </div>

                            <div class="d-grid mb-3">
                                <button type="submit" 
                                        formaction="${pageContext.request.contextPath}/changepassword" 
                                        class="btn btn-primary btn-auth text-white rounded-pill">
                                    UPDATE PASSWORD
                                </button>
                            </div>

                            <div class="text-center">
                                <a href="javascript:history.back()" class="text-decoration-none text-secondary small">
                                    <i class="fa-solid fa-xmark me-1"></i> Hủy bỏ
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
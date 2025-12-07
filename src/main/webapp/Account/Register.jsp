<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký thành viên - PolyOE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #20bf55 0%, #01baef 100%); /* Màu nền khác cho trang đăng ký */
            min-height: 100vh;
            margin-left: 180px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .register-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            overflow: hidden;
            width: 100%;
            max-width: 500px; /* Rộng hơn form login một chút */
        }
        .register-header {
            background: #198754; /* Màu xanh lá */
            color: white;
            padding: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="register-card">
                    <div class="register-header">
                        <h3 class="mb-0"><i class="fa-solid fa-user-plus"></i> ĐĂNG KÝ TÀI KHOẢN</h3>
                        <small>Tham gia cộng đồng PolyOE ngay hôm nay</small>
                    </div>
                    
                    <div class="p-4">
                        <c:if test="${not empty error}">
                             <div class="alert alert-danger text-center">${error}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/register" method="post">
                            
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Họ và tên" required>
                                <label for="fullname"><i class="fa-solid fa-signature me-1"></i> Họ và tên</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                                <label for="email"><i class="fa-solid fa-envelope me-1"></i> Địa chỉ Email</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="id" name="id" placeholder="Tên đăng nhập" required>
                                <label for="userId"><i class="fa-solid fa-user me-1"></i> Tên đăng nhập</label>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu" required>
                                        <label for="password"><i class="fa-solid fa-lock me-1"></i> Mật khẩu</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                                        <label for="confirmPassword"><i class="fa-solid fa-check-double me-1"></i> Nhập lại MK</label>
                                    </div>
                                </div>
                            </div>
                            
                            <div>
                            	<input type="hidden" name="admin" value="false">
                            </div>
                  
                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-success btn-lg fw-bold">ĐĂNG KÝ</button>
                            </div>
                            
                            <div
								class="d-flex justify-content-between align-items-center mb-4">									
								<a
									href="${pageContext.request.contextPath}/crud/index"
									class="text-decoration-none small"><-- Quay lại Trang chủ</a>
							</div>

                            <div class="text-center border-top pt-3">
                                Đã có tài khoản? <a href="Login.jsp" class="text-decoration-none fw-bold text-success">Đăng nhập ngay</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng nhập - PolyOE</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
body {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	min-height: 100vh;
	margin-left: 80px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.login-card {
	background: rgba(255, 255, 255, 0.95);
	border-radius: 15px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
	overflow: hidden;
	width: 100%;
	max-width: 400px;
}

.login-header {
	background: #0d6efd;
	color: white;
	padding: 20px;
	text-align: center;
}

.form-floating:focus-within {
	z-index: 2;
}
</style>
</head>
<body>

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-6 col-lg-4">
				<div class="login-card">
					<div class="login-header">
						<h3 class="mb-0">
							<i class="fa-solid fa-user-lock"></i> ĐĂNG NHẬP
						</h3>
						<small>Hệ thống giải trí PolyOE</small>
					</div>

					<div class="p-4">
						<c:if test="${not empty message}">
							<div class="alert alert-danger text-center mb-3">
								${message}</div>
						</c:if>

						<form action="${pageContext.request.contextPath}/login"
							method="post">

							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="username" name="id"
									placeholder="Tên đăng nhập" required> <label
									for="username"><i class="fa-solid fa-user me-1"></i>
									Tên đăng nhập</label>
							</div>

							<div class="form-floating mb-3">
								<input type="password" class="form-control" id="password"
									name="password" placeholder="Mật khẩu" required> <label
									for="password"><i class="fa-solid fa-key me-1"></i> Mật
									khẩu</label>
							</div>

							<div
								class="d-flex justify-content-between align-items-center mb-4">
								<a
									href="${pageContext.request.contextPath}/Account/ForgotPassword.jsp"
									class="text-decoration-none small">Quên mật khẩu?</a> 
									
								<a
									href="${pageContext.request.contextPath}/crud/index"
									class="text-decoration-none small"><-- Quay lại Trang chủ</a>
							</div>

							<div class="d-grid mb-3">
								<button type="submit" class="btn btn-primary btn-lg fw-bold">ĐĂNG
									NHẬP</button>
							</div>

							<div class="text-center border-top pt-3">
								Chưa có tài khoản? <a href="Register.jsp"
									class="text-decoration-none fw-bold">Đăng ký ngay</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
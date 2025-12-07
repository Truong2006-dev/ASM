<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Forgot Password</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

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
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	/* Giữ màu đồng bộ với trang trước */
	padding: 30px 20px;
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
						<div class="mb-3">
							<div
								class="bg-white bg-opacity-25 rounded-circle d-inline-flex p-3">
								<i class="fa-solid fa-lock fa-3x text-white"></i>
							</div>
						</div>
						<h4 class="mb-1">Quên mật khẩu?</h4>
						<p class="small text-white-50 mb-0">Nhập mã OTP</p>
					</div>

					<div class="card-body p-4">

						<form action="${pageContext.request.contextPath}/otp"
							method="post">
							<c:if test="${not empty message}">
								<div class="alert alert-danger text-center mb-3">
									${message}</div>
							</c:if>
							<div class="mb-4">
								<label class="form-label text-muted small fw-bold">OTP</label>
								<div class="input-group">
									<span class="input-group-text bg-white border-end-0"> <i
										class="fa-solid fa-key me-1"></i>
									</span> <input type="text" class="form-control border-start-0"
										name="otp" required placeholder="XXXXXXX">
								</div>
							</div>

							<div>
								<input type="hidden" name="email" value="${email}">
							</div>

							<div class="d-grid mb-3">
								<button type="submit"
									class="btn btn-primary btn-auth text-white rounded-pill">
									XÁC MINH</button>
							</div>

							<div class="text-center">
								<a href="${pageContext.request.contextPath}/Account/Login.jsp"
									class="text-decoration-none text-secondary small"> <i
									class="fa-solid fa-chevron-left me-1"></i> Quay lại đăng nhập
								</a>
							</div>

						</form>
					</div>
				</div>

			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
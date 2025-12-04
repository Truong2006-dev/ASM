<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
body {
	background-color: #f8f9fa;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

.main-content {
	flex: 1;
}

.footer {
	background-color: #343a40;
	color: white;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
		<div class="container">
			<a class="navbar-brand fw-bold"
				href="${pageContext.request.contextPath}/crud/index"><i
				class="fa-solid fa-play-circle"></i> POLY-OE</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav me-auto">
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/crud/index"> <i
							class="fa-solid fa-house"></i> Trang chủ
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/favorites"> <i
							class="fa-solid fa-heart"></i> Yêu thích
					</a></li>
				</ul>
				<ul class="navbar-nav ms-auto">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown"> <i class="fa-solid fa-user"></i>
							Tài khoản
					</a>
						<ul class="dropdown-menu dropdown-menu-end">
							<c:choose>
								<c:when test="${not empty sessionScope.user}">
									<li><a class="dropdown-item"
										href="${pageContext.request.contextPath}/Account/ChangePassword.jsp">Change
											Password</a></li>
									<li><a class="dropdown-item"
										href="${pageContext.request.contextPath}/Account/EditProfile.jsp">Edit
											Profile</a></li>
									<li><a class="dropdown-item"
										href="${pageContext.request.contextPath}/logoff">Logoff</a></li>
								</c:when>

								<c:otherwise>
									<li><a class="dropdown-item"
										href="${pageContext.request.contextPath}/Account/Login.jsp">Login</a></li>
									<li><a class="dropdown-item"
										href="${pageContext.request.contextPath}/Account/Register.jsp">Registration</a></li>
								</c:otherwise>
							</c:choose>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/admin">Vào
									trang Admin</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container main-content mt-4">
		<div class="row">
			<div class="col-12">
				<c:choose>
					<c:when test="${param.page == 'favorite'}">
						<div class="alert alert-warning">
							<i class="fa-solid fa-heart"></i> ĐÂY LÀ TRANG YÊU THÍCH
						</div>
					</c:when>
					<c:otherwise>
						<div class="alert alert-info">
							<i class="fa-solid fa-home"></i> ĐÂY LÀ TRANG CHỦ (Danh sách
							Video)
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
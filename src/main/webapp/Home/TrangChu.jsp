<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PolyOE - Giải trí trực tuyến</title>
</head>
<body>
	<jsp:include page="/Home/Header.jsp"></jsp:include>

	<c:url var="url" value="/crud" />

	<div class="container mt-4">
		<div class="row">
			<c:forEach var="v" items="${videos}">
				<c:if test="${v.active}">
					<div class="col-md-4 mb-4">
						<div class="card h-100 shadow-sm">

							<a
								href="${pageContext.request.contextPath}/crud/detail?id=${v.id}"
								class="position-relative text-decoration-none"> <img
								src="https://img.youtube.com/vi/${v.id}/mqdefault.jpg"
								class="card-img-top" alt="${v.titile}"
								style="height: 200px; object-fit: cover;"
								onerror="this.src='https://placehold.co/400x300?text=Video+Lỗi';">

								<div
									class="position-absolute top-50 start-50 translate-middle text-white"
									style="background: rgba(0, 0, 0, 0.6); border-radius: 50%; width: 50px; height: 50px; display: flex; align-items: center; justify-content: center;">
									<i class="fa-solid fa-play fa-xl"></i>
								</div>
							</a>

							<div class="card-body">
								<h5 class="card-title text-truncate">
									<a
										href="${pageContext.request.contextPath}/crud/detail?id=${v.id}"
										class="text-decoration-none text-dark"> ${v.titile} </a>
								</h5>
							</div>

							<div class="card-footer d-flex justify-content-between">
								<form method="post">
									<c:set var="liked" value="false" />

									<c:forEach var="f" items="${favorite}">
										<c:if test="${f.video.id == v.id}">
											<c:set var="liked" value="true" />
										</c:if>
									</c:forEach>

									<c:choose>
										<c:when test="${liked}">
											<button
												formaction="${pageContext.request.contextPath}/dislike?id=${v.id}&path=home"
												class="btn btn-sm btn-danger">
												<i class="fa-solid fa-heart-broken"></i> Dislike
											</button>
										</c:when>

										<c:otherwise>
											<button
												formaction="${pageContext.request.contextPath}/like?id=${v.id}&path=home"
												class="btn btn-sm btn-success">
												<i class="fa-solid fa-heart"></i> Like
											</button>
										</c:otherwise>
									</c:choose>

									<button formaction="${pageContext.request.contextPath}/share?id=${v.id}"
										class="btn btn-sm btn-warning">
										<i class="fa-solid fa-share"></i> Share
									</button>
								</form>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>

		<div class="d-flex justify-content-center mt-3">
			<form method="post" class="btn-group">
				<button class="btn btn-outline-primary"
					formaction="${url}/index?pageNumber=0&path=home">|<</button>
				<button class="btn btn-outline-primary"
					formaction="${url}/index?pageNumber=${pageNumber - 6}&path=home"><<</button>
				<button class="btn btn-outline-primary"
					formaction="${url}/index?pageNumber=${pageNumber + 6}&path=home">>></button>
				<button class="btn btn-outline-primary"
					formaction="${url}/index?pageNumberLast=0&path=home">>|</button>
			</form>
		</div>
	</div>

	<jsp:include page="/Home/Footer.jsp"></jsp:include>
</body>
</html>
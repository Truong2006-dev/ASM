<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>${video.titile}- PolyOE</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

	<jsp:include page="/Home/Header.jsp"></jsp:include>

	<div class="container mt-4">
		<div class="row justify-content-center">
			<div class="col-lg-10">

				<div class="ratio ratio-16x9 mb-3 shadow-sm"
					style="background: #000; border-radius: 8px; overflow: hidden;">
					<iframe id="videoIframe" src="" title="${video.titile}"
						frameborder="0"
						allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
						allowfullscreen> </iframe>
				</div>

				<div class="card shadow-sm border-0">
					<div class="card-body">
						<h3 class="card-title fw-bold mb-2">${video.titile}</h3>

						<div class="text-muted mb-3 border-bottom pb-2">
							<i class="fa-solid fa-eye"></i> ${video.views} lượt xem
						</div>

						<p class="card-text text-secondary">${video.description}</p>

						<div class="d-flex gap-2 mt-4">
							<form method="post">
								<input type="hidden" id="rawVideoId" value="${video.id}">

								<c:choose>
									<c:when test="${not empty favorite}">
										<button
											formaction="${pageContext.request.contextPath}/dislike?id=${video.id}&path=video"
											class="btn btn-danger">
											<i class="fa-solid fa-heart-broken"></i> Bỏ thích
										</button>
									</c:when>

									<c:otherwise>
										<button
											formaction="${pageContext.request.contextPath}/like?id=${video.id}&path=video"
											class="btn btn-success">
											<i class="fa-solid fa-heart"></i> Yêu thích
										</button>
									</c:otherwise>
								</c:choose>

								<button
									formaction="${pageContext.request.contextPath}/share?id=${video.id}"
									class="btn btn-warning">
									<i class="fa-solid fa-share"></i> Chia sẻ
								</button>

								<a href="${pageContext.request.contextPath}/crud/index"
									class="btn btn-secondary ms-2"> <i
									class="fa-solid fa-arrow-left"></i> Quay lại
								</a>
							</form>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

	<jsp:include page="/Home/Footer.jsp"></jsp:include>

	<script>
		document
				.addEventListener(
						"DOMContentLoaded",
						function() {
							var rawId = document.getElementById("rawVideoId").value
									.trim();
							var iframe = document.getElementById("videoIframe");

							function getYouTubeId(url) {
								var regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|&v=)([^#&?]*).*/;
								var match = url.match(regExp);

								if (match && match[2].length === 11) {
									return match[2];
								} else {
									return url;
								}
							}

							var cleanId = getYouTubeId(rawId);
							if (cleanId) {
								iframe.src = "https://www.youtube.com/embed/"
										+ cleanId + "?autoplay=1";
							}
						});
	</script>

</body>
</html>
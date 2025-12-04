<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<jsp:include page="/Home/Header.jsp"></jsp:include>

	<div class="container">
		<div class="row">
			<c:forEach var="f" items="${favorites}">
				<div class="col-md-4 mb-4">
					<div class="card h-100 shadow-sm"
						onclick="location.href='${pageContext.request.contextPath}/crud/detail?id=${f.video.id}'"
						style="cursor: pointer;">

						<!-- Poster -->
						<img src="${f.video.poster}" class="card-img-top"
							alt="Poster video">

						<!-- Nội dung -->
						<div class="card-body">
							<h5 class="card-title">${f.video.titile}</h5>
						</div>

						<!-- Like / Dislike -->
						<div class="card-footer d-flex justify-content-between">
							<form method="post">

								<button
									formaction="${pageContext.request.contextPath}/favoritesdislike?id=${f.id}"
									class="btn btn-sm btn-danger">
									<i class="fa fa-heart-broken"></i> Dislike
								</button>

								<button class="btn btn-sm btn-warning">
									<i class="fa fa-share"></i> Share
								</button>
							</form>
						</div>

					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- Phân trang -->
	<div class="d-flex justify-content-center mt-3">
		<form method="post" class="btn-group">
			<button class="btn btn-outline-primary"
				formaction="${pageContext.request.contextPath}/favorites?pageNumber=0">|<</button>
			<button class="btn btn-outline-primary"
				formaction="${pageContext.request.contextPath}/favorites?pageNumber=${pageNumber - 6}"><<</button>
			<button class="btn btn-outline-primary"
				formaction="${pageContext.request.contextPath}/favorites?pageNumber=${pageNumber + 6}">>></button>
			<button class="btn btn-outline-primary"
				formaction="${pageContext.request.contextPath}/favorites?pageNumberLast=0">>|</button>
		</form>
	</div>
	</div>

	<jsp:include page="/Home/Footer.jsp"></jsp:include>

</body>
</html>
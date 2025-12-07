<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row justify-content-center mb-4">
    <div class="col-md-8">
        <form action="${pageContext.request.contextPath}/crud/index" method="get" class="input-group">
            
            <input type="text" class="form-control" 
                   placeholder="Nhập tên video cần tìm..." 
                   name="keyword" 
                   value="${param.keyword}"> <button class="btn btn-primary" type="submit">
                <i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm
            </button>
            
            <c:if test="${not empty param.keyword}">
            	<a href="${pageContext.request.contextPath}/crud/index" class="btn btn-outline-secondary">
            		<i class="fa-solid fa-rotate-left"></i>
            	</a>
            </c:if>
        </form>
    </div>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="card card-custom">
    <div class="card-header-custom">
        <span><i class="fa-solid fa-chart-line me-2"></i>Báo cáo & Thống kê</span>
    </div>
    <div class="card-body">
        <ul class="nav nav-tabs mb-4">
            <li class="nav-item">
                <a class="nav-link ${tab == 'favorites' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/report?page=reports&tab=favorites">
                    Favorites
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${tab == 'favorite-users' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/report?page=reports&tab=favorite-users">
                    Favorite Users
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${tab == 'shared-friends' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/report?page=reports&tab=shared-friends">
                    Shared Friends
                </a>
            </li>
        </ul>

        <div class="tab-content">
            
            <c:if test="${tab == 'favorites'}">
                <div class="alert alert-info py-2"><i class="fa-solid fa-info-circle"></i> Thống kê số lượt thích của từng Video</div>
                <table class="table table-bordered table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Video Title</th>
                            <th>Favorite Count</th>
                            <th>Latest Date</th> <th>Oldest Date</th> </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="row" items="${reportData}">
                            <tr>
                                <td>${row[0]}</td>
                                <td class="fw-bold text-center">${row[1]}</td>
                                <td><fmt:formatDate value="${row[2]}" pattern="dd/MM/yyyy"/></td>
                                <td><fmt:formatDate value="${row[3]}" pattern="dd/MM/yyyy"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${tab == 'favorite-users'}">
                <form action="${pageContext.request.contextPath}/admin/report" method="get" class="row g-3 mb-3 bg-light p-2 rounded border">
                    <input type="hidden" name="page" value="reports">
                    <input type="hidden" name="tab" value="favorite-users">
                    
                    <label class="col-auto col-form-label fw-bold">Video Title?</label>
                    <div class="col-auto flex-grow-1">
                        <select name="vid" class="form-select" onchange="this.form.submit()">
                            <c:forEach var="v" items="${vidList}">
                                <option value="${v.id}" ${v.id == vidSelected ? 'selected' : ''}>${v.titile}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>

                <table class="table table-bordered table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Username</th>
                            <th>Fullname</th>
                            <th>Email</th>
                            <th>Favorite Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="row" items="${reportData}">
                            <tr>
                                <td>${row[0]}</td>
                                <td>${row[1]}</td>
                                <td>${row[2]}</td>
                                <td><fmt:formatDate value="${row[3]}" pattern="dd/MM/yyyy"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${tab == 'shared-friends'}">
                <form action="${pageContext.request.contextPath}/admin/report" method="get" class="row g-3 mb-3 bg-light p-2 rounded border">
                    <input type="hidden" name="page" value="reports">
                    <input type="hidden" name="tab" value="shared-friends">
                    
                    <label class="col-auto col-form-label fw-bold">Video Title?</label>
                    <div class="col-auto flex-grow-1">
                        <select name="vid" class="form-select" onchange="this.form.submit()">
                            <c:forEach var="v" items="${vidList}">
                                <option value="${v.id}" ${v.id == vidSelected ? 'selected' : ''}>${v.titile}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>

                <table class="table table-bordered table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Sender Name</th>
                            <th>Sender Email</th>
                            <th>Receiver Email</th>
                            <th>Sent Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="row" items="${reportData}">
                            <tr>
                                <td>${row[0]}</td>
                                <td>${row[1]}</td>
                                <td>${row[2]}</td>
                                <td><fmt:formatDate value="${row[3]}" pattern="dd/MM/yyyy"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>
</div>
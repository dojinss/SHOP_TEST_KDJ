<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<%
		String root = request.getContextPath();
		// 이미 로그인한 경우
		String loginId = (String) session.getAttribute("loginId");
		boolean login = loginId != null ? false : true;
	%>
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 container">
		<h1 class="display-5 fw-bold text-body-emphasis d-sm-flex justify-content-sm-center">메인화면</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4 d-sm-flex justify-content-sm-center">Shop 쇼핑몰 입니다.</p>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
				<a href="<%=root%>/shop/products.jsp" class="btn btn-primary">상품목록</a>
				<%if(login){ %>
				<a href="<%=root%>/user/login.jsp" class="btn btn-outline-dark">로그인</a>
				<%}else{ %>
				<a href="<%=root%>/user/logout.jsp" class="btn btn-outline-danger">로그아웃</a>
				<%} %>
			</div>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>






<%@page import="java.text.DecimalFormat"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
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
	// 통화 표현 (3자리마다 콤마찍기)
	DecimalFormat df = new DecimalFormat("\u00A4 #,###");
	
	// root 경로 불러오기
	String root = request.getContextPath();

	// 상품 DAO 생성
	ProductRepository proDAO = new ProductRepository();
	List<Product> proList = proDAO.list();
	%>

	<jsp:include page="/layout/header.jsp" />
	<div class="container-xl">
	<div class="px-4 py-5 mt-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 목록</h1>
		<h4 class="display-5 fs-5 text-body-emphasis">쇼핑몰 상품 목록 입니다.</h4>
	</div>
	<div
		class="container mb-5 d-flex flex-row justify-content-center column-gap-3">
		<a href="<%=root%>/shop/add.jsp" class="btn btn-primary">상품 등록</a> 
		<a href="<%=root%>/shop/cart.jsp" class="btn btn-warning">장바구니</a>
	</div>
	<div class="row row-cols-md-4 g-3">
		<%
		for (Product product : proList) {
		%>
		<div class="col">
			<div class="card h-100">
				<img src="<%=root + "/shop/img?id=" + product.getProductId()%>"
					class="card-img-top" alt="상품이미지">
				<div class="card-body">
					<!-- 상품명 -->
					<h5 class="card-title"><%=product.getName()%></h5>
					<!-- 상품설명 -->
					<p class="card-text"><%=product.getDescription()%></p>
				</div>
				<!-- 가격 -->
				<div class="d-flex justify-content-end p-3"><%=df.format(product.getUnitPrice())%></div>
				<!-- 버튼 모음 -->
				<div class="d-flex justify-content-end gap-2 p-3">
					<a href="<%=root%>/shop/update.jsp?id=<%=product.getProductId()%>"
						class="btn btn-primary d-flex align-items-center">수정</a>
					<a href="<%=root%>/shop/delete_pro.jsp?id=<%=product.getProductId()%>"
						class="d-flex btn btn-danger align-items-center">삭제</a>				
				</div>
			</div>
		</div>
		<%
		}
		%>
	</div>
	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>








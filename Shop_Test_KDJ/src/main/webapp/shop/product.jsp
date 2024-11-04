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
<style type="text/css">
	.table-title{ height:50px; }
	.table-content{ height:50px; }
</style>
</head>
<body>
	<%
	// 통화 표현 (3자리마다 콤마찍기)
	DecimalFormat df = new DecimalFormat("\u00A4 #,###");

	// root 경로 불러오기
	String root = request.getContextPath();

	// request 전달값
	String productId = request.getParameter("id");

	// 상품 DAO 생성
	ProductRepository proDAO = new ProductRepository();
	Product product = proDAO.getProductById(productId);
	%>

	<jsp:include page="/layout/header.jsp" />
	<div class="container-xl">
		<div class="px-4 py-2 mt-5 text-center">
			<h1 class="display-5 fw-bold text-body-emphasis">상품 목록</h1>
			<h4 class="display-5 fs-5 text-body-emphasis">쇼핑몰 상품 목록 입니다.</h4>
		</div>
		<div
			class="container d-flex flex-row justify-content-center column-gap-3">
			<a href="<%=root%>/shop/products.jsp" class="btn btn-primary">상품
				목록</a>
		</div>
		<div class="d-flex justify-content-center g-3 mt-5 pt-3">
			<div class="d-flex align-items-start p-5">
				<img src="<%=root + "/shop/img?id=" + product.getProductId()%>"
					class="card-img-top" alt="상품이미지">
			</div>
			<div class="table caption-top">
				<div class="fs-3 fw-bold text-align-center" style="text-align:center;">
				<%=product.getName()%></div>
					<div class="row d-flex align-items-center border-bottom border-light-subtle">
						<div class="col-3 table-title d-flex align-items-center">상품ID :</div>
						<div class="col-9 table-content d-flex align-items-center"><%=product.getProductId()%></div>
					</div>
					<div class="row d-flex align-items-center border-bottom border-light-subtle">
						<div class="col-3 table-title d-flex align-items-center">제조사 :</div>
						<div class="col-9 table-content d-flex align-items-center"><%=product.getManufacturer()%></div>
					</div>
					<div class="row d-flex align-items-center border-bottom border-light-subtle">
						<div class="col-3 table-title d-flex align-items-center">분류 :</div>
						<div class="col-9 table-content d-flex align-items-center"><%=product.getCategory()%></div>
					</div>
					<div class="row d-flex align-items-center border-bottom border-light-subtle">
						<div class="col-3 table-title d-flex align-items-center">상태 :</div>
						<div class="col-9 table-content d-flex align-items-center"><%=product.getCondition()%></div>
					</div>
					<div class="row d-flex align-items-center border-bottom border-light-subtle">
						<div class="col-3 table-title d-flex align-items-center">재고 수 :</div>
						<div class="col-9 table-content d-flex align-items-center"><%=product.getUnitsInStock()%></div>
					</div>
					<div class="row d-flex align-items-center border-bottom border-light-subtle">
						<div class="col-3 table-title d-flex align-items-center">가격 :</div>
						<div class="col-9 table-content d-flex align-items-center"><%=product.getUnitPrice()%></div>
					</div>
			</div>
		</div>
		<div class=" d-flex justify-content-end gap-3 p-4">
			<!-- 버튼 모음 -->
			<a href="<%=root%>/shop/cart_pro.jsp?id=<%=product.getProductId()%>"
				class="btn btn-warning d-flex align-items-center">장바구니</a> <a
				href="<%=root%>/shop/addCart.jsp?id=<%=product.getProductId()%>"
				class="d-flex btn btn-success align-items-center">주문하기</a>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>








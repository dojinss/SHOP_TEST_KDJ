<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop - 배송정보</title>
<jsp:include page="/layout/meta.jsp" />
<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<%
		// root 설정
		String root = request.getContextPath();
	
		// 유저 DAO 생성
		UserRepository userDAO = new UserRepository();
		
		// 로그인된 아이디 받아오기
		String loginId = (String) session.getAttribute("loginId");
		
		// 로그인된 회원정보 받아오기
		User loginUser = userDAO.getUserById(loginId);
		
		// 유저 정보 저장
		String userName = "";
		String addr = "";
		String phone = "";
		if(loginUser != null) {
			userName = loginUser.getName();
			addr = loginUser.getAddress();
			phone = loginUser.getPhone();
		}
	%>
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 mt-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">배송정보</h1>
	</div>


	<!--  -->
	<div class="container shop mb-5 p-4">
		<form action="ship_pro.jsp" class="form-horizontal" method="post">
			<input type="hidden" name="cartId"
				value="9B9F2F245A1038AADFCE63DFE7F75662">
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">성명</label> <input
					type="text" class="form-control col-md-10" name="name" value="<%=userName%>">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">배송일</label> <input
					type="text" class="form-control col-md-10" name="shippingDate"
					value="">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">국가명</label> <input
					type="text" class="form-control col-md-10" name="country" value="">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">우편번호</label> <input
					type="text" class="form-control col-md-10" name="zipCode" value="">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">주소</label> <input
					type="text" class="form-control col-md-10" name="addressName"
					value="<%=addr%>">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">전화번호</label> <input
					type="text" class="form-control col-md-10" name="phone" value="<%=phone%>">
			</div>

			<!-- 버튼 영역 -->
			<div class="d-flex justify-content-between mt-5 mb-5">
				<div class="item">
					<a href="<%=root%>/shop/cart.jsp" class="btn btn-lg btn-success">이전</a>
					<!-- 취소 프로세스는 이어서... -->
					<a href="<%=root %>/" class="btn btn-lg btn-danger">취소</a>
				</div>
				<div class="item">
					<input type="submit" class="btn btn-lg btn-primary" value="등록">
				</div>
			</div>

		</form>
	</div>
	<!--  -->

	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>









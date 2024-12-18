<%@page import="shop.dao.OrderRepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
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

	// 장바구니 내역 목록을 세션에서 가져오기
	List<Product> cartList = (List) session.getAttribute("cartList");
	int cartCount = cartList == null ? 0 : cartList.size();
	%>

	<jsp:include page="/layout/header.jsp" />


	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">장바구니 목록 입니다.</p>
		</div>
	</div>

	<div class="container order">
		<!-- 장바구니 목록 -->
		<table
			class="table table-striped table-hover table-bordered text-center align-middle">
			<thead>
				<tr class="table-primary">
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
				<%
				int sum = 0;
				for (int i = 0; i < cartCount; i++) {
					Product product = cartList.get(i);
					int total = product.getUnitPrice() * product.getQuantity();
					sum += total;
				%>
				<tr>
					<td><%=product.getName()%></td>
					<td><%=product.getUnitPrice()%></td>
					<td><%=product.getQuantity()%></td>
					<td><%=total%></td>
					<td><a
						href="<%=root%>/shop/deleteCart.jsp?id=<%=product.getProductId()%>"
						class="btn btn-danger">삭제</a></td>
				</tr>
				<%
				}
				%>
			</tbody>
			<tfoot>
				<%
				if ( cartList == null || cartList.isEmpty() ) {
				%>
				<tr>
					<td colspan="6">추가된 상품이 없습니다.</td>
				</tr>
				<%
				} else {
				%>
				<tr>
					<td></td>
					<td></td>
					<td>총액</td>
					<td id="cart-sum"><%=sum%></td>
					<td></td>
				</tr>
				<%
				}
				%>
			</tfoot>
		</table>
		<div class="d-flex justify-content-between align-items-center p-3">
			<a href="deleteCart.jsp?cartId=FC6FF627D2673B7A2445E74BD70E53F4"
				class="btn btn-lg btn-danger ">전체삭제</a> <a href="javascript:;"
				class="btn btn-lg btn-primary" onclick="order()">주문하기</a>
		</div>
	</div>

	<jsp:include page="/layout/footer.jsp" />



	<jsp:include page="/layout/script.jsp" />
	<script>
		let cartId = '<%=session.getId()%>'
		let cartCount = '<%=cartCount%>'
		let cartSum = document.getElementById('cart-sum')
		
		function order() {
			if( cartCount == 0 ) {
				alert('장바구니에 담긴 상품이 없습니다.')
				return
			}
			let msg = '총 ' + cartCount + '개의 상품을 주문합니다. \n총 주문금액 : ' + cartSum.textContent
			let check = confirm(msg)
			if( check ) {
				location.href = 'ship.jsp?cartId=' + cartId
			}
			
		}
	</script>
</body>
</html>









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
	List<String> orderList = session.getAttribute("")
	
	%>

	<jsp:include page="/layout/header.jsp" />

	<div class="row m-0 ">

		<div class="col-md-9 ms-sm-auto col-lg-10 p-0 m-0">
			<div class="px-4 py-3 my-3 text-center">
				<h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
				<h5 class="display-5 fs-5 text-body-emphasis">장바구니 목록 입니다.</h5>
			</div>

			<div class="container shop m-auto mb-5">
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
						for (int i = 0; i < orderCount; i++) {
							Product product = orderList.get(i);
							int total = product.getUnitPrice() * product.getQuantity();
							sum += total;
						%>
						<tr>
							<td><%=product.getName()%></td>
							<td><%=product.getUnitPrice()%></td>
							<td><%=product.getQuantity()%></td>
							<td><%=total%></td>
							<td></td>
						</tr>
						<%
						}
						%>
					</tbody>
					<tfoot>
						<%
						if (orderList.isEmpty()) {
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
			</div>

			<jsp:include page="/layout/footer.jsp" />
		</div>
	</div>



	<jsp:include page="/layout/script.jsp" />
</body>
</html>









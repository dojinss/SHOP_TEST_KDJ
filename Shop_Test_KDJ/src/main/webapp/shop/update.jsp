<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>shop - 상품수정</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>   
	<%
		// root 설정
		String root = request.getContextPath();
		// 상품 DAO 선언
		ProductRepository proDAO = new ProductRepository();
		
		// 전달 받은 값
		String productId = request.getParameter("id");
		
		Product product = proDAO.getProductById(productId);
	%>
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 mt-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 수정</h1>
	</div>
	
	<!-- 상품 등록 영역 -->
	<div class="container shop p-5 mb-5" >
		<form action="update_pro.jsp" name="product" method="post" enctype="multipart/form-data" onsubmit="javascript:return checkProduct();">
			<div class="input-group mb-3 row">
				<img src="<%=root%>/shop/img?id=<%=productId%>"/>
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">상품 이미지</label>
				<input type="file" class="form-control col-md-8" 
					   name="file" placeholder="상품이미지" >
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">상품코드</label>
				<input type="text" class="form-control col-md-8" 
					   name="productId" value="<%= product.getProductId()%>" placeholder="상품코드" readonly>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">상품명</label>
				<input type="text" class="form-control col-md-8" 
					   name="name" value="<%= product.getName() %>" placeholder="상품명" required>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">가격</label>
				<input type="text" class="form-control col-md-8" 
					   name="unitPrice" value="<%= product.getUnitPrice() %>" placeholder="가격" required>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">상세정보</label>
				<textarea class="d-block" rows="13" placeholder="상세정보 입력" name="description"><%=product.getDescription() %></textarea>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">제조사</label>
				<input type="text" class="form-control col-md-8" 
					   name="manu" value="<%= product.getManufacturer() %>" placeholder="제조사" required>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">분류</label>
				<input type="text" class="form-control col-md-8" 
					   name="cate" value="<%= product.getCategory() %>" placeholder="분류" required>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">재고수</label>
				<input type="text" class="form-control col-md-8" 
					   name="unitsInStock" value="<%= product.getUnitsInStock() %>" placeholder="재고수" required>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">상태</label>
				<div class="row col-md-8">
					<div class="col d-flex align-items-center gap-2">
						<input id="new-pro" type="radio" name="condition" 
							value="NEW" <%=product.getCondition().equals("NEW") ? "checked" : "" %>/>
						<label for="new-pro">신규제품</label>
					</div>
					<div class="col d-flex align-items-center gap-2">
						<input id="old-pro" type="radio" name="condition" 
							value="OLD" <%=product.getCondition().equals("OLD") ? "checked" : "" %>/>
						<label for="old-pro">중고제품</label>
					</div>
					<div class="col d-flex align-items-center gap-2">
						<input id="re-pro" type="radio" name="condition" 
							value="recycle" <%=product.getCondition().equals("recycle") ? "checked" : "" %>/>
						<label for="re-pro">재생제품</label>
					</div>
				</div>
			</div>
			
			<div class="d-grid gap-2 mt-5 mb-5 d-md-flex justify-content-md-between">
				<a href="<%=request.getContextPath() %>/shop/products.jsp" class="btn btn-lg btn-secondary">목록</a>
				<input type="submit" class="btn btn-lg btn-success" value="수정" id="add-btn"/>
			</div>	
			
			
		</form>
	
	</div>
	
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>









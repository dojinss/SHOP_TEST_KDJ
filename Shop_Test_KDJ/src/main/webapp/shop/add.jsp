<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>shop - 상품등록</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>   
	<%
		/*
		- 상품 등록 화면임을 제목 태그로 출력한다. 
		- 입력 양식 태그를 이용하여, 아래 정보를 입력 받는다. 
		- 상품 이미지, 상품 코드, 상품명, 가격, 상세 정보, 제조사, 분류, 재고 수, 상태 
		- 각 입력 정보는 아래 규칙에 따라 유효성 검사를 한다. 
		- 상품 코드 : 영문자 P로 시작 / 숫자 6자리 로 제한
		- [등록] 버튼을 구현하고 클릭 시, 상품등록 처리(~/shop/add_pro.sp)로 입력 정보를 제출하게 한다. 
		- [목록] 버튼을 구현하고 클릭 시, 상품목록 (~/shop/products.jsp) 화면으로 이동하게 한다.
		*/
	
	%>
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 mt-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 등록</h1>
	</div>
	
	<!-- 상품 등록 영역 -->
	<div class="container shop p-5 mb-5" >
		<form action="add_pro.jsp" name="joinForm" method="post" id="add-form" onsubmit="checkProduct();">
		
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">상품 이미지</label>
				<input type="file" class="form-control col-md-8" 
					   name="file" placeholder="상품이미지" required>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">상품코드</label>
				<input type="text" class="form-control col-md-8" 
					   name="product-id" placeholder="상품코드" required>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">상품명</label>
				<input type="text" class="form-control col-md-8" 
					   name="name" placeholder="비밀번호 확인" required>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">상세정보</label>
				<textarea class="d-block" rows="13" placeholder="상세정보 입력" name="description"></textarea>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">제조사</label>
				<input type="text" class="form-control col-md-8" 
					   name="manu" placeholder="제조사" required>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">분류</label>
				<input type="text" class="form-control col-md-8" 
					   name="cate" placeholder="분류" required>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">재고수</label>
				<input type="text" class="form-control col-md-8" 
					   name="stock" placeholder="재고수" required>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-4" id="">재고수</label>
				<div>
					<div>
						<input type="radio" name="condition" value="new"/>
						<label>신규제품</label>
					</div>
				</div>
			</div>
			
			<div class="d-grid gap-2 mt-5 mb-5 d-md-flex justify-content-md-between">
				<a href="<%=request.getContextPath() %>/shop/products.jsp" class="btn btn-lg btn-secondary">목록</a>
				<input type="submit" class="btn btn-lg btn-primary" value="등록" id="add-btn"/>
			</div>	
			
			
		</form>
	
	</div>
	
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>









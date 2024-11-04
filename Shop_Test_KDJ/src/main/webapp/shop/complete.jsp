<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop - 상품정보</title>
	<jsp:include page="/layout/meta.jsp" /> <jsp:include page="/layout/link.jsp" />
</head>
<body>   
	<% 
		String root = request.getContextPath(); 	// root 경로 불러오기 
		String msg = request.getParameter("msg");	// msg 전달값
		String printMsg = "";						// 출력할 메세지
		
		
		/*
		- 요청 파라미터 msg 의 값에 따라 위의 화면과 같이 메시지를 출력한다. 
		- 0 : 
		- 1 : 
		- 2 : 
		- 3 : 
		*/
		switch(msg){
			case "0" : printMsg = "상품 등록이 완료 되었습니다."; break; 
// 			case "1" : printMsg = "상품 등록이 완료 되었습니다."; break; 
			case "2" : printMsg = "상품 정보가 수정 되었습니다."; break; 
			case "3" : printMsg = "상품 정보가 삭제 되었습니다."; break; 
		}
	%>
	
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 정보</h1>
	</div>
	<div class="mb-5 row">
		<div class="col-12 text-center">
			<p class="display-5 text-body-emphasis text-center"><%=printMsg %></p>
		</div>
		<div class="col-12 text-center">
			<a href="<%=root %>/shop/products.jsp" class="btn btn-primary">상품 목록</a>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>








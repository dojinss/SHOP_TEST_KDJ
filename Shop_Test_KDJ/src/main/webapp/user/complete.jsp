<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" /> <jsp:include page="/layout/link.jsp" />
</head>
<body>   
	<% 
		String root = request.getContextPath(); 	// root 경로 불러오기 
		String msg = request.getParameter("msg");	// msg 전달값
		String printMsg = "";						// 출력할 메세지
		String loginId = (String) session.getAttribute("loginId"); // 로그인시 아이디값
		
		
		/*
		- 요청 파라미터 msg 의 값에 따라 위의 화면과 같이 메시지를 출력한다. 
		- 0 : 로그인
		- 1 : 회원 가입
		- 2 : 회원 수정
		- 3 : 회원 탈퇴
		*/
		switch(msg){
			case "0" : printMsg = loginId + "님 환영 합니다."; break; 
			case "1" : printMsg = "회원 가입이 완료되었습니다."; break; 
			case "2" : printMsg = "회원 정보가 수정되었습니다."; break; 
			case "3" : printMsg = "회원 정보가 삭제되었습니다."; break; 
		}
	%>
	
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">회원 정보</h1>
		
	</div>
	<!-- 회원 가입/수정/탈퇴 완료 -->
	<div class="container mb-5 d-flex-cols justify-content-center align-items-center">
		<p class="display-5 text-body-emphasis"><%=printMsg %></p>
		<a href="<%=root %>/" class="btn btn-primary">메인화면</a>
	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>








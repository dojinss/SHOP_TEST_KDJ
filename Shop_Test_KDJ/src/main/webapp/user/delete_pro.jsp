<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />

<%
	/* 
		회원 탈퇴 처리
	*/
	
	// 전달 받은값 변수에 저장
    String getId = request.getParameter("id");
	
	// 현재 로그인 중인지 판별
	String loginUser = (String) session.getAttribute("loginUser");
%>

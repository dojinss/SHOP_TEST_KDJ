<!-- 
	회원 가입 처리
 -->
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String root = request.getContextPath();	

	// 넘겨받은 파라미터값 변수에 저장
	String reId = request.getParameter("id");			// 아이디
	String rePw = request.getParameter("pw");			// 비밀번호
	String reName = request.getParameter("name");		// 이름
	String reGender = request.getParameter("gender");	// 성별
	
	String reBirth = request.getParameter("year");		// 생일
	reBirth += "/" + request.getParameter("month");
	reBirth += "/" + request.getParameter("day");
	
	String reEmail = request.getParameter("email1");	// 이메일
	reEmail += "@" + request.getParameter("email2");
	
	String rePhone = request.getParameter("phone");		// 전화번호
	String reAddr = request.getParameter("address");	// 주소
		
	// userDAO 생성
	UserRepository userDAO = new UserRepository();
	
	// 유저 객체 생성
	User user = new User();
	
	// 객체에 정보 대입
	user.setId(reId);
	user.setPassword(rePw);
	user.setName(reName);
	user.setGender(reGender);
	user.setBirth(reBirth);
	user.setMail(reEmail);
	user.setPhone(rePhone);
	user.setAddress(reAddr);
	
	// 가입 메소드 호출
	int result = userDAO.insert(user);
	
	if(result > 0){
	// 가입 성공시 가입완료페이지로
		response.sendRedirect(root + "/user/complete.jsp?msg=1");
	}
	else{
	// 가입 실패시 다시 가입페이지로
		response.sendRedirect(root + "/user/join.jsp?error=0");
	}
%>
    
    

    
    
    
    
    
    
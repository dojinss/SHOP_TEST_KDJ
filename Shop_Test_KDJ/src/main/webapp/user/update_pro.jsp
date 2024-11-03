<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />
<%

	/* 
		회원 정보 수정 처리
	*/
	
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
	
	// 수정 실행
    int result = userDAO.update(user);

	// 처리결과
    if (result >0 ){
        response.sendRedirect("complete.jsp?msg=2");
    } else {
        response.sendRedirect("update.jsp");
    }

%>

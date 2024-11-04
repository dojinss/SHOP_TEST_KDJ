<%@page import="shop.dto.Order"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
		
	// 서비스 설정
	OrderRepository orderDAO 		= new OrderRepository();
	
	// 주문 객체 생성
	Order order = new Order();
	
	
	
	// 전달 받은값 저장
	String name = request.getParameter("name");
	String shippingDate = request.getParameter("shippingDate");
	String country = request.getParameter("country");
	String zipCode = request.getParameter("zipCode");
	String address = request.getParameter("addressName");
	String phone = request.getParameter("phone");
	
	order.setAddress(address);
	order.setDate(shippingDate);
	order.setCountry(country);
	order.setZipCode(zipCode);
	order.setAddress(address);
	order.setPhone(phone);
	
	// 등록 시도
	if( orderDAO.insert(order) > 0 ) {
		int lastPK = orderDAO.lastOrderNo();
		
		response.sendRedirect( request.getContextPath() + "/shop/order.jsp?msg=0");
	}
	else {
		response.sendRedirect( request.getContextPath() + "/shop/cart.jsp?error=0");
	}
%>
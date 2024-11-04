<%@page import="shop.dao.ProductIORepository"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Order"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
		
	// 서비스 설정
	OrderRepository orderDAO 		= new OrderRepository();
	ProductIORepository ioDAO		= new ProductIORepository();	

	// 주문 객체 생성
	Order order = new Order();
	
	// 세션에서 장바구니 리스트 받아오기
	List<Product> cartList = (List<Product>) session.getAttribute("cartList");
	
	// 전달 받은값 저장
	String cartId = request.getParameter("cartId");
	String name = request.getParameter("name");
	String shippingDate = request.getParameter("shippingDate");
	String country = request.getParameter("country");
	String zipCode = request.getParameter("zipCode");
	String address = request.getParameter("addressName");
	String phone = request.getParameter("phone");
	String orderPw = request.getParameter("pw");
	
	// 로그인일 경우 아이디 저장
	String loginId = (String) session.getAttribute("loginId");
	if(!loginId.equals("") && !loginId.isEmpty())
		order.setUserId(loginId);
	else
		order.setOrderPw(orderPw);
	
	// 전달 받은값 객체에 저장
	order.setCartId(cartId);
	order.setShipName(name);
	order.setAddress(address);
	order.setDate(shippingDate);
	order.setCountry(country);
	order.setZipCode(zipCode);
	order.setAddress(address);
	order.setPhone(phone);
	
	// 등록 시도
	if( orderDAO.insert(order) > 0 ) {
		// 주문번호 가져오기
		int lastPK = orderDAO.lastOrderNo();
		// 입출고 내역에 주문수만큼 저장
		for(Product pro : cartList) {
			pro.setOrderNo(lastPK);
			ioDAO.insert(pro);
		}
		// 주문후 장바구니 초기화
		session.removeAttribute("cartList");
	
		// 주문완료 페이지로 이동
		response.sendRedirect( request.getContextPath() + "/user/order.jsp?msg=0");
	}
	else {
		response.sendRedirect( request.getContextPath() + "/shop/cart.jsp?error=0");
	}
%>
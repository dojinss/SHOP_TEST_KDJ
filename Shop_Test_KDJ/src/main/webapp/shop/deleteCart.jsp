<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	// 상품아이디 받기
	String productId = request.getParameter("id");
	String cartId = request.getParameter("cartId");
	
	// 상품DAO 생성
	ProductRepository proDAO = new ProductRepository();

	// 기존 세션 확인
	List<Product> cartList = (List) session.getAttribute("cartList");
	
	// 장바구니가 비었을경우 돌아감
	if( cartList == null ){
		response.sendRedirect( request.getContextPath() + "/shop/cart.jsp");
	}
	// 장바구니를 반복하여 같은 아이디 삭제
	for( int i = 0; i < cartList.size() ; i++ ) {
		Product pro = cartList.get(i);
		if( pro.getProductId().equals(productId) ) {
			cartList.remove(i);
		}
	}
	// 장바구니가 전부 삭제시 세션도 삭제
	if(cartList.size() < 1 ) 
		session.removeAttribute("cartList");
	else
		session.setAttribute("cartList", cartList);
	
	if(cartId != null && !cartId.equals(""))
		session.removeAttribute("cartList");
	
	response.sendRedirect( request.getContextPath() + "/shop/cart.jsp");
%>
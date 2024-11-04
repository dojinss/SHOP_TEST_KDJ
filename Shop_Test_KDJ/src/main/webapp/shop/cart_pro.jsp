<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	// 상품아이디 받기
	String productId = request.getParameter("id");
	
	// 상품DAO 생성
	ProductRepository proDAO = new ProductRepository();

	// 기존 세션 확인
	List<Product> cartList = (List) session.getAttribute("cartList");
	
	boolean check = true;
	if( cartList == null ){
		cartList = new ArrayList<Product>();
	}
	for( Product pro : cartList ) {
		if( pro.getProductId().equals(productId) ) {
			pro.setQuantity( pro.getQuantity() + 1 );
			check = false;
		}
	}
	if(check){
		Product newProduct = proDAO.getProductById(productId);
		newProduct.setQuantity(1);
		cartList.add(newProduct);
	}
	
	session.setAttribute("cartList", cartList);
	response.sendRedirect( request.getContextPath() + "/shop/products.jsp");
%>
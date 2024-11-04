<%@page import="java.io.File"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
		
	// 상품번호 받기
	String productId = request.getParameter("id");
	
	// 서비스 설정
	ProductRepository proDAO = new ProductRepository();
	
	// 상품 정보 불러오기
	Product product = proDAO.getProductById(productId);;	
	
	// 기존 파일 삭제
	File oldFile = new File(product.getFile());
	if(oldFile.exists()) {
		oldFile.delete();
	}
		
	// 삭제 시도
	if( proDAO.delete(productId) > 0 ) {
		response.sendRedirect( request.getContextPath() + "/shop/complete.jsp?msg=3");
	}
	else {
		response.sendRedirect( request.getContextPath() + "/shop/products.jsp?error=0");
	}
%>
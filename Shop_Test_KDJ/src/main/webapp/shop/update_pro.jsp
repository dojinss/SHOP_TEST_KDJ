<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
		
	// 상품 객체 생성
	Product product = new Product();	
	
	// 파일 업로드 경로
	String path 					= "/shopupload";
	
	// 서비스 설정
	ProductRepository proDAO 		= new ProductRepository();
	
	// commons file uplaod 객체 생성
	DiskFileUpload upload = new DiskFileUpload();
	
	// 업로드 파일 설정
	upload.setSizeMax(10*1000*1000); 		// 10MB - 파일 최대 크기
	upload.setSizeThreshold( 4 * 1024 );	// 4MB	- 메모리상의 최대 크기
	upload.setRepositoryPath(path);			// 임시 저장 경로
	
	List<FileItem> items = upload.parseRequest(request);
	List<String> filePaths = new ArrayList<String>();
	Iterator params = items.iterator();
	while( params.hasNext() ) {
		FileItem item = (FileItem) params.next();
		
		// 일반 데이터
		if( item.isFormField() ) {
			String name = item.getFieldName();
			String value = item.getString("utf-8");
			if(name.equals("productId") && !value.isEmpty() && !value.equals("null"))
				product.setProductId(value);
			if(name.equals("name") && !value.isEmpty() && !value.equals("null"))
				product.setName(value);
			if(name.equals("unitPrice") && !value.isEmpty() && !value.equals("null"))
				product.setUnitPrice( Integer.parseInt( value ) );
			if(name.equals("description") && !value.isEmpty() && !value.equals("null"))
				product.setDescription(value);
			if(name.equals("manu") && !value.isEmpty() && !value.equals("null"))
				product.setManufacturer(value);
			if(name.equals("cate") && !value.isEmpty() && !value.equals("null"))
				product.setCategory(value);
			if(name.equals("unitsInStock") && !value.isEmpty() && !value.equals("null"))
				product.setUnitsInStock( Integer.parseInt( value ) );
			if(name.equals("condition") && !value.isEmpty() && !value.equals("null"))
				product.setCondition(value);
				
		}
		// 파일 데이터
		else {
			String fileFieldName = item.getFieldName();
			String fileName = item.getName();
			String contentType = item.getContentType();
			
			fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
			long fileSize = item.getSize();
			File file = new File(path+ "/" + fileName);
			if(!file.exists() && !fileName.equals("")){
				item.write(file);
				filePaths.add(path+ "/" + fileName);
				product.setFile(path+ "/" + fileName);
			}
		}
	}
	// 새로운 이미지 교체시 기존 파일 삭제
	Product oldPro = proDAO.getProductById(product.getProductId());
	if( product.getFile() != null && !product.getFile().equals("") ){
		File oldFile = new File(oldPro.getFile());
		if(oldFile.exists())
			oldFile.delete();
	}
	else{
		// 새로운 이미지가 없을경우 기존 이미지를 그대로 적용
		product.setFile(oldPro.getFile());
	}
	// 수정 시도
	if( proDAO.update(product) > 0 ) {
		response.sendRedirect( request.getContextPath() + "/shop/complete.jsp?msg=2");
	}
	else {
		response.sendRedirect( request.getContextPath() + "/shop/editProducts.jsp?error=2");
	}
%>
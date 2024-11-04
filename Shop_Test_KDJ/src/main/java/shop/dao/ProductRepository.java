package shop.dao;

import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductRepository extends JDBConnection {

	/**
	 * 테이블명
	 * 
	 * @return
	 */
	public String table() {
		return "product";
	}

	/**
	 * 상품 목록
	 * 
	 * @return
	 */
	public List<Product> list() {
		List<Product> proList = new ArrayList<Product>();

		String SQL = " SELECT * FROM " + table() 
				   ;
		
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(SQL);
			while( rs.next() ) {
				Product product = new Product();
				product.setProductId(rs.getString("product_id"));
				product.setName( rs.getString("name") );
				product.setUnitPrice( rs.getInt("unit_price") );
				product.setDescription( rs.getString("description") );
				product.setManufacturer( rs.getString("manufacturer") );
				product.setUnitsInStock( rs.getLong("units_in_stock") );
				product.setCondition( rs.getString("condition") );
				product.setFile( rs.getString("file") );
				product.setQuantity( rs.getInt("quantity") );
				
				proList.add(product);
			}
			
		} catch (Exception e) {
			System.err.println("상품 목록 조회 시, 에러발생...");
			e.printStackTrace();
		}
		
		
		return proList;
	}

	/**
	 * 상품 목록 검색
	 * 
	 * @param keyword
	 * @return
	 */
	public List<Product> list(String keyword) {
		List<Product> proList = new ArrayList<Product>();

		String SQL = " SELECT * FROM " + table() 
				   + " WHERE name like CONCAT('%', ? '%') "
				   + " OR description like CONCAT('%', ? '%') "
				   + " OR category like CONCAT('%', ? '%') "
				   + " OR manufacturer like CONCAT('%', ? '%') "
				   ;
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, keyword);
			psmt.setString(2, keyword);
			psmt.setString(3, keyword);
			psmt.setString(4, keyword);
			rs = psmt.executeQuery();
			while( rs.next() ) {
				Product product = new Product();
				product.setProductId(rs.getString("product_id"));
				product.setName( rs.getString("name") );
				product.setUnitPrice( rs.getInt("unit_price") );
				product.setDescription( rs.getString("description") );
				product.setCategory( rs.getString("category") );
				product.setManufacturer( rs.getString("manufacturer") );
				product.setUnitsInStock( rs.getLong("units_in_stock") );
				product.setCondition( rs.getString("condition") );
				product.setFile( rs.getString("file") );
				product.setQuantity( rs.getInt("quantity") );
				
				proList.add(product);
			}
			
		} catch (Exception e) {
			System.err.println("상품 목록 검색 시, 에러발생...");
			e.printStackTrace();
		}
		
		return proList;
	}

	/**
	 * 상품 조회
	 * 
	 * @param productId
	 * @return
	 */
	public Product getProductById(String productId) {
		Product product = new Product();

		String SQL = " SELECT * FROM " + table() 
			       + " WHERE product_id = ? ";
		
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, productId);
			
			rs = psmt.executeQuery();
			if( rs.next() ) {
				product.setProductId(productId);
				product.setName( rs.getString("name") );
				product.setUnitPrice( rs.getInt("unit_price") );
				product.setCategory( rs.getString("category") );
				product.setDescription( rs.getString("description") );
				product.setManufacturer( rs.getString("manufacturer") );
				product.setUnitsInStock( rs.getLong("units_in_stock") );
				product.setCondition( rs.getString("condition") );
				product.setFile( rs.getString("file") );
				product.setQuantity( rs.getInt("quantity") );
			}
			
		} catch (Exception e) {
			System.err.println("상품아이디로 상품조회 시, 에러발생...");
			e.printStackTrace();
		}
		return product;
	}

	/**
	 * 상품 등록
	 * 
	 * @param product
	 * @return
	 */
	public int insert(Product product) {
		int result = 0;
		
		String SQL = " INSERT INTO product "
				   + " ( "
				   + " product_id, "
				   + " name, "
				   + " unit_price, "
				   + " description, "
				   + " manufacturer, "
				   + " category, "
				   + " units_in_stock, "
				   + " `condition`, "
				   + " file, "
				   + " quantity "
				   + " ) "
				   + " VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) "
				   ;
		
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, product.getProductId());
			psmt.setString(2, product.getName());
			psmt.setInt(3, product.getUnitPrice());
			psmt.setString(4, product.getDescription());
			psmt.setString(5, product.getManufacturer());
			psmt.setString(6, product.getCategory());
			psmt.setLong(7, product.getUnitsInStock());
			psmt.setString(8, product.getCondition());
			psmt.setString(9, product.getFile());
			psmt.setInt(10, product.getQuantity());
			
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.err.println("상품 등록시 에러 발생...");
			e.printStackTrace();
		}
		
		return result;
	}

	/**
	 * 상품 수정
	 * 
	 * @param product
	 * @return
	 */
	public int update(Product product) {
		int result = 0;

		String SQL = " UPDATE product SET " 
				   + " name = ? " 
				   + " ,unit_price = ? " 
				   + " ,description = ? " 
				   + " ,manufacturer = ? " 
				   + " ,category = ? " 
				   + " ,units_in_stock = ?"
				   + " ,`condition` = ? " 
				   + " ,file = ? " 
				   + " ,quantity = ? " 
				   + " WHERE product_id = ? ";

		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, product.getName());
			psmt.setInt(2, product.getUnitPrice());
			psmt.setString(3, product.getDescription());
			psmt.setString(4, product.getManufacturer());
			psmt.setString(5, product.getCategory());
			psmt.setLong(6, product.getUnitsInStock());
			psmt.setString(7, product.getCondition());
			psmt.setString(8, product.getFile());
			psmt.setInt(9, product.getQuantity());
			psmt.setString(10, product.getProductId());
			
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.err.println("상품 정보 수정 시 에러 발생...");
			e.printStackTrace();
		}

		return result;
	}

	/**
	 * 상품 삭제
	 * 
	 * @param product
	 * @return
	 */
	public int delete(String productId) {
		int result = 0;

		String SQL = " DELETE FROM " + table() + " WHERE product_id = ? ";

		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, productId);

			result = psmt.executeUpdate();

		} catch (Exception e) {
			System.err.println("상품정보 삭제시 에러 발생...");
			e.printStackTrace();
		}

		return result;
	}

}

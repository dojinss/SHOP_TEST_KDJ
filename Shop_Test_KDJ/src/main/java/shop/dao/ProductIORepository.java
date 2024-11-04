package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductIORepository extends JDBConnection {
	
	public String table() {
		return "product_io";
	}
	
	
	// CREATE
	/**
	 * 상품 입출고 등록
	 * @param product
	 * @param type
	 * @return
	 */
	public int insert(Product product) {
		int result = 0;
		
		String SQL = " INSERT INTO " + table() + " ( "
				   + " product_id "
				   + " ,order_no "
				   + " ,amount "
				   + " ,type "
				   + " ,io_date "
				   + " ,user_id "
				   + " ) "
				   + " VALUES ( ? , ? , ? , ? , ? , ? , ? ) "
				   ;
		
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, product.getProductId());
			psmt.setInt(2, product.getOrderNo());
			psmt.setInt(3, product.getAmount());
			psmt.setString(4, product.getType());
			psmt.setDate(5, product.getIoDate());
			psmt.setString(6, product.getUserId());
			
			result = psmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("입출고 정보 입력 시, 에러발생...");
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	// READ
	/**
	 * 입출고 정보 조회
	 * @param ioNo
	 * @return
	 */
	public Product select(int ioNo) {
		Product product = new Product();
		
		String SQL = " SELECT * FROM " + table()
				   + " WHERE ioNo = ? "
		   		   ;
		
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setInt(1, ioNo);
			rs = psmt.executeQuery();
			if(rs.next()) {
				product.setProductId( rs.getString("product_id") );
				product.setOrderNo( rs.getInt("order_no") );
				product.setAmount( rs.getInt("amount") );
				product.setType( rs.getString("type") );
				product.setIoDate( rs.getDate("io_date") );
				product.setUserId( rs.getString("user_id") );
			}
		} catch (Exception e) {
			System.err.println("입출고정보 조회시 에러 발생...");
			e.printStackTrace();
		}
		
		return product;
	}
	
	/**
	 * 입출고 목록 조회
	 * @return
	 */
	public List<Product> list(){
		List<Product> proList = new ArrayList<Product>();
		
		String SQL = " SELECT * FROM " + table()
				   ;
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(SQL);
			while( rs.next() ) {
				Product product = new Product();
				
				product.setProductId( rs.getString("product_id") );
				product.setOrderNo( rs.getInt("order_no") );
				product.setAmount( rs.getInt("amount") );
				product.setType( rs.getString("type") );
				product.setIoDate( rs.getDate("io_date") );
				product.setUserId( rs.getString("user_id") );
				
				proList.add(product);
			}
			
		} catch (Exception e) {
			System.err.println("입출고 목록 조회시 에러 발생...");
			e.printStackTrace();
		}
		
		return proList;
	}
	
	
	// UPDATE
	/**
	 * 입출고 정보 수정
	 * @param product
	 * @return
	 */
	public int update(Product product) {
		int result = 0;
		String SQL = " UPDATE " + table() + " SET "
				   + "  product_id = ? "
				   + "  ,order_no = ? "
				   + "  ,amount = ? "
				   + "  ,type = ? "
				   + "  ,io_date = ?"
				   + "  ,user_id = ? "
				   + " WHERE io_no = ?"
				   ;  
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, product.getProductId());
			psmt.setInt(2, product.getOrderNo());
			psmt.setInt(3, product.getAmount());
			psmt.setString(4, product.getType());
			psmt.setDate(5, product.getIoDate());
			psmt.setString(6, product.getUserId());
			psmt.setString(7, product.getProductId());
			
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.err.println("입출고 정보 수정시 에러 발생...");
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	// DELETE
	/**
	 * 입출고 정보 삭제
	 * @param productId
	 * @return
	 */
	public int delete(int ioNo) {
		int result = 0;
		
		String SQL = " DELETE FROM " + table()
				   + " WHERE io_no = ? "
				   ;
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setInt(1, ioNo);
			result = psmt.executeUpdate(); 
		} catch (Exception e) {
			System.err.println("입출고정보 삭제시 에러 발생...");
			e.printStackTrace();
		}
		return result;
	}
}
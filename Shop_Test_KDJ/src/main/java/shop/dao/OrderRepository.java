package shop.dao;

import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
	
	
	// CREATE
	/**
	 * 주문 등록
	 * @param user
	 * @return
	 */
	// 테이블명 반환 메소드
	// : SQL문 작성시 테이블명의 가독성을 높이기위해
	
	// 메소드 선언
	// - public : 전역
	// - String : 문자열 객체 ( 반환값이자 반환 객체형식 -> return할때 똑같은 형식으로 해줘야한다)
	// - table() : 메소드명
	public String table() {
		// " " 감싸면 -> 문자열
		return "`order`";
	}
	// table() -> "`order`"
	// SQL 에서 order by 라는 기본 예약어가 존재하기 때문에 오류를 피하기 위해서 ` 백틱을 쓴다.
	
	public int insert(Order order) {
		int result = 0;	// 반활할 변수 선언
		
		//기본세팅
//		String SQL = "  "
//				   + "  "
//				   ;  
		String SQL = " INSERT INTO " + table() + " ( "			// SQL 작성 
				   + " ship_name "
				   + " ,zip_code "
				   + " ,country "
				   + " ,address "
				   + " ,date "
				   + " ,order_pw "
				   + " ,user_id "
				   + " ,total_price "
				   + " ,phone ) "
				   + " VALUES( ? , ? , ? , ? , ? , ? , ? , ? , ? ) "
				   ;
		
		// try ~ catch
		// : try 안에서 실행한 결과가 오류(Exception:예외처리)발생시 catch 부분에 선언한 실행문이 실행된다.
		try {
			
			psmt = con.prepareStatement(SQL);				// psmt : preparedStatement 객체
			psmt.setString(1, order.getShipName() );		// ? 에 순서대로 변수 대입
			psmt.setString(2, order.getZipCode() );
			psmt.setString(3, order.getCountry() );
			psmt.setString(4, order.getAddress() );
			psmt.setString(5, order.getDate() );
			psmt.setString(6, order.getOrderPw() );
			psmt.setString(7, order.getUserId() );
			psmt.setInt(8, order.getTotalPrice() );
			psmt.setString(9, order.getPhone() );
			
			result = psmt.executeUpdate();					// result 변수에 쿼리 실행 결과값 입력
			
			// 0 : 실패
			// > 0 : 성공
			
//			if(result > 0 ) System.out.println("성공!");	
//			else			System.out.println("실패....");
			
		} catch (Exception e) {
			System.err.println( table() + "테이블에 insert 시 에러발생... ");	// 실행중 오류 방샐시 출력문
			e.printStackTrace();										// 전체 에러 구문
		}
		
		return result;	// 결과 값 반환
	}

	/**
	 * 최근 등록한 orderNo 
	 * @return
	 */
	// 마지막주문번호
	// SELECT
	// MAX() 함수 사용
	// : 해당 값 int 의 최댓값을 불러온다
	//   그리고 SELECT MAX( user_id ) as max_no FROM 테이블명
	//         - as : 변수명 짓는거랑 같다 -> 임의로 작명하는거다 내맘대로 쓰는거다
	//   getInt(user_id) -> max_no로 이름을 바꿧기 때문에 -> getInt(max_no) 해야 나온다....
	//   ex) int max = (쿼리실행생략) SELECT MAX( 컬럼명 ) FROM 테이블명
	//   		 max = 100
	
	// lastOrderNo() -> 165
	// int lastNo = lastOrderNo();
	// lastNo -> 165
	// 주문을하고 입출고 테이블에 주문번호를 들고가야함
	// -> 주문테이블에 먼저 값이들어가야 주문번호가 나옴
	// -> MAX 함수를 써서 마지막입력한값(기본키 AUTO_INCREMENT 는 최댓값이 마지막입력값)
	// -> 입출력테이블에 order_no 입력할수있따.
	public int lastOrderNo() {
		int result = 0;
		
		String SQL = " SELECT MAX(order_no) as max_no FROM " + table()
				   ;
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(SQL);
			if( rs.next() )
				result = rs.getInt("max_no");
			
		} catch (Exception e) {
			System.err.println("마지막주문번호 조회시 에러 발생...");
			e.printStackTrace();
		}
		
		return result;
	}

	// READ - 복수
	/**
	 * 주문 내역 조회 - 회원
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
		List<Product> proList = new ArrayList<Product>();
		
		// join
		// - product_io 테이블에 입출력 내역존재
		// - product 테이블에 상품정보 존재
		// - order 테이블에 주문내역 존재 해당 
//		String SQL = " SELECT * FROM product_io as pio , product as p  "   
//				   + " WHERE p.product_id = pio.product_id "
//				   + " and pio.order_no in ( "
//				   + " SELECT order_no FROM `order` "
//				   + " WHERE user_id = ? ) "
//				   ;
		String SQL = " SELECT o.order_no "   
				   + " 		 ,p.name "
				   + " 		 ,p.unit_price "
				   + " 		 ,io.amount "
				   + " FROM `order` o JOIN product_io io ON o.order_no = io.order_no "
				   + " 				  JOIN product p ON io.product_id = p.product_id "
				   + " WHERE o.user_id = ? "
				   ;
		
		try {
			// SQL 실행
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, userId);
			rs = psmt.executeQuery();
			while( rs.next() ) {
				// 객체 생성
				Product product = new Product();
				
				// DTO 와 table 컬럼 매칭
				product.setOrderNo( rs.getInt("order_no") );
				product.setName( rs.getString("name") );
				product.setUnitPrice( rs.getInt("unit_price"));
				product.setAmount( rs.getInt("amount") );
//				product.setProductId( rs.getString("product_id") );
//				product.setUnitPrice( rs.getInt("unit_price") );
//				product.setDescription( rs.getString("description"));
//				product.setManufacturer( rs.getString("manufacturer") );
//				product.setCategory( rs.getString("category") );
//				product.setUnitsInStock( rs.getInt("units_in_stock") );
//				product.setCondition( rs.getString("condition") );
//				product.setFile( rs.getString("file") );
//				product.setQuantity( rs.getInt("quantity") );
				
				// 상품 리스트에 추가
				proList.add(product);
			}
			
		} catch (Exception e) {
			System.err.println("userId 로 주문내역 조회시 에러 발생...");
			e.printStackTrace();
		}
		
		return proList;
	}
	
	/**
	 * 주문 내역 조회 - 비회원
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {
		List<Product> proList = new ArrayList<Product>();
		
		// join
		// - product_io 테이블에 입출력 내역존재
		// - product 테이블에 상품정보 존재
		// - order 테이블에 주문내역 존재 해당 
		String SQL = " SELECT o.order_no "   
				   + " 		 ,p.name "
				   + " 		 ,p.unit_price "
				   + " 		 ,io.amount "
				   + " FROM `order` o JOIN product_io io ON o.order_no = io.order_no "
				   + " 				  JOIN product p ON io.product_id = p.product_id "
				   + " WHERE o.phone = ? AND o.order_pw = ? "
				   ;
		
		try {
			// SQL 실행
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, phone);
			psmt.setString(2, orderPw);
			rs = psmt.executeQuery();
			while( rs.next() ) {
				// 객체 생성
				Product product = new Product();
				
				// DTO 와 table 컬럼 매칭
				product.setOrderNo( rs.getInt("order_no") );
				product.setName( rs.getString("name") );
				product.setUnitPrice( rs.getInt("unit_price"));
				product.setAmount( rs.getInt("amount") );
				
				// 상품 리스트에 추가
				proList.add(product);
			}
			
		} catch (Exception e) {
			System.err.println("userId 로 주문내역 조회시 에러 발생...");
			e.printStackTrace();
		}
		
		return proList;
	}
	
	
	// READ - 단일
	/**
	 * 주문정보 조회(단일 항목 조회)
	 * @param orderNo
	 * @return
	 */
	public Order select(int orderNo) {
		Order order = new Order();
		
		String SQL = " SELECT * FROM " + table()
				   + " WHERE order_no = ? "
				   ;
		
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setInt(1, orderNo);
			rs = psmt.executeQuery();
			if( rs.next() ) {
				order.setShipName(rs.getString("ship_name"));	
				order.setZipCode(rs.getString("zip_code"));	
				order.setCountry(rs.getString("country"));	
				order.setAddress(rs.getString("address"));	
				order.setDate(rs.getString("date"));	
				order.setOrderPw(rs.getString("order_pw"));	
				order.setUserId(rs.getString("user_id"));	
				order.setTotalPrice(rs.getInt("total_price"));	
				order.setPhone(rs.getString("phone"));	
			}
			
		} catch (Exception e) {
			System.err.println("");
			e.printStackTrace();
		}
		
		return order;
	}
	
	// UPDATE
	/**
	 * 주문정보 수정 - 회원
	 * @param order
	 * @return
	 */
	public int update(Order order) {
		int result = 0;
		String SQL = " UPDATE " + table() + " SET "
				   + "  ship_name = ? "
				   + "  ,zip_code = ? "
				   + "  ,country = ? "
				   + "  ,address = ? "
				   + "  ,date = ? "
				   // 주문 조회시 필요한 컬럼은 수정불가 필요할경우 따로 만듬 ex) 비밀번호 변경, 주문자 병경 등등..
//				   + "  ,order_pw = ?"		
//				   + "  ,user_id = ?"
				   + "  ,total_price = ? "
//				   + "  ,phone = ?"
				   + " WHERE order_no = ? AND user_id = ? "
				   ;  
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, order.getShipName() );		// ? 에 순서대로 변수 대입
			psmt.setString(2, order.getZipCode() );
			psmt.setString(3, order.getCountry() );
			psmt.setString(4, order.getAddress() );
			psmt.setString(5, order.getDate() );
			// psmt.setString(6, order.getOrderPw() );
			// psmt.setString(7, order.getUserId() );
			psmt.setInt(6, order.getTotalPrice() );
			// psmt.setString(9, order.getPhone() );
			psmt.setInt(7, order.getOrderNo() );
			psmt.setString(8, order.getUserId() );
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.err.println("");
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * 주문정보 수정 - 비회원
	 * @param order
	 * @return
	 */
	public int updateByPhone(Order order) {
		int result = 0;
		String SQL = " UPDATE " + table() + " SET "
				   + "  ship_name = ? "
				   + "  ,zip_code = ? "
				   + "  ,country = ? "
				   + "  ,address = ? "
				   + "  ,date = ? "
				   + "  ,total_price = ? "
				   + " WHERE order_no = ? AND phone = ? AND order_pw = ? "
				   ;  
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, order.getShipName() );		// ? 에 순서대로 변수 대입
			psmt.setString(2, order.getZipCode() );
			psmt.setString(3, order.getCountry() );
			psmt.setString(4, order.getAddress() );
			psmt.setString(5, order.getDate() );
			psmt.setInt(6, order.getTotalPrice() );
			psmt.setInt(7, order.getOrderNo() );
			psmt.setString(8, order.getPhone() );
			psmt.setString(9, order.getOrderPw() );
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.err.println("");
			e.printStackTrace();
		}
		
		return result;
	}
	
	//DELETE
	
	/**
	 * 주문정보 삭제
	 * @param orderNo
	 * @return
	 */
	public int delete(int orderNo) {
		int result = 0;
		
		String SQL = " DELETE FROM " + table()
				   + " WHERE order_no = ? "
				   ;
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setInt(1, orderNo);
			result = psmt.executeUpdate(); 
		} catch (Exception e) {
			System.err.println("주문정보 삭제시 에러 발생...");
			e.printStackTrace();
		}
		return result;
	}
}














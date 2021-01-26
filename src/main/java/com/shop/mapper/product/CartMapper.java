package com.shop.mapper.product;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shop.vo.Cart_Tbl;
import com.shop.vo.Like_Tbl;


public interface CartMapper {
	public List<Cart_Tbl> getUserCart(String u_id); 
	public int addCart(Cart_Tbl cart);
	
	// insert 
	
	public List<Cart_Tbl> cartMoney(); // 장바구니 total
	public List<Cart_Tbl> listCart(String u_id); // 장바구니 목록
	
	
	public int insertCart(Cart_Tbl cart); // 카트 담기
	
	public int delete(int p_no, String u_id); // 장바구니 개별 삭제
	// 칼럼타입 수정 2020.01.08 yunhj
	// 예외처리 
	
	public int deleteAll(String u_id); // 장바구니 모두 삭제
	//public String deleteAll(String u_id); // 장바구니 모두 삭제
	
	
	public int update(Cart_Tbl cart); // 장바구니 업데이트 
	public int modifyCart(Cart_Tbl car);
	//public int update(int p_no); // 장바구니 업데이트 
	
	
	
	
	public int sumTotal(String u_id); // 장바구니 total
	public Integer countCart(@Param("u_id")String u_id, @Param("p_no")int p_no); // 장바구니 상품 개수
	public int updateCart(Cart_Tbl cart); // 장바구니 수정
	
	
	
	
	
	public List<Like_Tbl> Like_tbl(String u_id); // like cart 방풀 
	public void insertLikeList(Cart_Tbl cart); // like mapper
	

	
	
	
	

}

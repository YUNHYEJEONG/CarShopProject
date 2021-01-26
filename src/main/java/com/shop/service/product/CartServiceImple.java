package com.shop.service.product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.mapper.product.CartMapper;
import com.shop.vo.Cart_Tbl;
import com.shop.vo.Like_Tbl;

import lombok.Setter;

@Service

public class CartServiceImple implements CartService {
	@Setter(onMethod_ = @Autowired)
	private CartMapper mapper;

	@Override
	public List<Cart_Tbl> getUserCart(String u_id) {
		return mapper.getUserCart(u_id);
	}

	@Override
	public int addCart(Cart_Tbl cart) {
		//System.out.println("addCartService 호출");
		Integer count = 0;
		try {
			count = mapper.countCart(cart.getU_id(),cart.getP_no());//상품이 장바구니에 들어있는지 체크
		}catch(Exception e) {
			
		}
			
		
		
		int result = 0;
		if(count == null) {
			System.out.println("addCart 호출");
			result = mapper.addCart(cart);
		}else {
			result = mapper.update(cart);
		}
		
		
		return result;
	}

	/*
	 * @Override public List<Cart_Tbl> listCart(String u_id) { return
	 * mapper.listCart(u_id); }
	 */

	@Override
	public List<Cart_Tbl> cartMoney() {
		// TODO Auto-generated method stub
		return mapper.cartMoney();
	}


	/*
	 * // cart update 2021.01.13
	 * 
	 * @Override public int update(Cart_Tbl cart) {
	 * 
	 * return mapper.update(cart); }
	 */

	
	
	@Override
	public int countCart(String u_id, int p_no) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void updateCart(Cart_Tbl vo) {
		// TODO Auto-generated method stub

	}

	@Override
	public int modifyCart(Cart_Tbl cart) {
		
		return mapper.modifyCart(cart);
	}

	/*
	 * @Override public int sumTotal(String u_id) {
	 * 
	 * return mapper.sumTotal(u_id); }
	 */

	@Override
	public int delete(int p_no, String u_id) {

		return mapper.delete(p_no, u_id);
	}

	@Override
	public int deleteAll(String u_id) {
		
		 return mapper.deleteAll(u_id);
		
	}
	// 2021/01/14 cart 담기 YHJ 
	@Override
	public int insertCart(Cart_Tbl cart) {
		
		return mapper.insertCart(cart);
	}
	// 딜리트 리턴 수정 yun.hj
	
	
	// 라이크의 정보를 받아와야함 // 디폴트는 1로 하고 보내면 반드시 1개가 와야함
	// 상품명 개수 가격을 가져와야 함

	

}

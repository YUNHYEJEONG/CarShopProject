package com.shop.controller.product;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.service.product.CartService;
import com.shop.service.product.ProductBuyService;
import com.shop.vo.Cart_Tbl;
import com.shop.vo.Like_Tbl;
import com.shop.vo.Prod_Tbl;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/carshop/*")
// 겟방식 
@Slf4j

public class CartController {
	@Setter(onMethod_ = @Autowired)
	private CartService cartService;
	@Setter(onMethod_ = @Autowired)
	private ProductBuyService productService;

	
	@RequestMapping("/cart")
	public String cart(Model model, HttpSession session) {
		
		String getId = (String)session.getAttribute("id");
		List<Cart_Tbl> cartList = cartService.getUserCart(getId);
		model.addAttribute("cartList", cartList);
		model.addAttribute("u_id", getId);
		// 특정
		
		return "carshop/cart";

	}
	
	
	// 장바구니 개별 삭제 controller 2020.01.08 yun.hj
	@RequestMapping("/cart_delete")
	public String delete(@RequestParam int p_no, @RequestParam String u_id) {
		// 문자열을 리턴 
		System.out.println("id는" + u_id + "p_no는" + p_no);
		//찍어보기
		
		cartService.delete(p_no, u_id);
		
		return "redirect:/carshop/cart";
		// 리다이렉트를 안하니까 결과값이 다시 나오지 않았음
		// redirect:/ -> jsp주소를 서버를 거치게 만들어준다. 브라우져로 와준다. 
		// 리다이렉트 서버를 한 번 더 거친다. 크롬에 url 보면 알 수 있음 
		
		
	}
	
	// 장바구니 전체 삭제
	
	@RequestMapping("/cart_deleteAll")
	public String deleteAll(@RequestParam String u_id) {
		
		System.out.println(u_id + " cart_controller 들어 왔습니다.");
		System.out.println( "cart 출력 "+cartService.deleteAll(u_id));
		//cartService.deleteAll(u_id);
		return "redirect:/carshop/cart";
	}

	
	
	@RequestMapping("/cart_update")
	public String update(@RequestParam int[] quantity, @RequestParam int [] p_no, HttpSession session) {
		// 메개변수타입과 매개변수명, mapper명과 인터페이스명 동일 
		
		String u_id = (String) session.getAttribute("id");
		// 레코드 개수 만큼 반복문 돔
		
		for(int i = 0; i < p_no.length; i++) {
			
			
			Cart_Tbl cart = new Cart_Tbl();
			
			cart.setU_id(u_id);;
			cart.setQuantity(quantity[i]);
			cartService.modifyCart(cart);
		
			System.out.println("카드 업데이트 잘 되나요?");
			
		}

		return "redirect:/carshop/cart";
		
		
		
	}
	

	
	  @RequestMapping("/insert_cart") //세부적인 url mapping
	  
	  public String insertCart(Cart_Tbl cart, HttpSession session){
	  System.out.println("장바구니 잘 저장 되나요?");
	  String u_id=(String)session.getAttribute("id");
	  //System.out.println("u_id : " + u_id);
	  
	  System.out.println("cart : " + cart);
	  
	  if(u_id==null) {
		  System.out.println("아이디 값이 뭔데"+ u_id); //로그인하지 않은 상태이면 로그인 화면으로 이동 return
		  return "redirect:/carshop/login";
	  }
	  Prod_Tbl prod = productService.getProduct(cart.getP_no());
	  System.out.println("prod : " + prod);
	  String pname = prod.getP_name();
	  int amount = prod.getAmount();
	  int quantity = 1; //기본수량 1 김보
	  cart.setPname(pname);
	  cart.setU_id(u_id);
	  cart.setAmount(amount);
	  cart.setQuantity(quantity);
	  cart.setTotal(amount * quantity);
	  System.out.println("cart : " + cart);
	  cartService.addCart(cart); //장바구니 테이블에 저장됨
	  
	  return "redirect:/carshop/like"; //장바구니 목록으로 이동 }
	  
	  }
	 
	
	
}


package com.shop.controller.product;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.service.product.AskService;
import com.shop.service.product.CartService;
import com.shop.service.product.CategoryService;
import com.shop.service.product.LikeService;
import com.shop.service.product.ProductBuyService;
import com.shop.service.product.ReplyService;
import com.shop.vo.Cart_Tbl;
import com.shop.vo.Like_Tbl;
import com.shop.vo.Prod_Tbl;
import com.shop.vo.ProductCategoryJoin;
import com.shop.vo.Reply_Tbl;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/carshop/*")
@AllArgsConstructor
@Slf4j
public class ProductBuyController {
	@Setter(onMethod_=@Autowired)
	private ProductBuyService productBuyService;
	@Setter(onMethod_=@Autowired)
	private CartService cartService;
	@Setter(onMethod_=@Autowired)
	private LikeService likeService;
	@Setter(onMethod_=@Autowired)
	private CategoryService categoryService;
	@Setter(onMethod_ = @Autowired)
	private AskService askService;
	@Setter(onMethod_ = @Autowired)
	private ReplyService replyService;
	
	@GetMapping("/product/details")
	public String detail(Model model,@Param("p_no") int p_no, HttpSession session) {
		model.addAttribute("product", productBuyService.getProduct(p_no));
		// session 에 담겨있는 id 를 가져와서 model 에 담음
		model.addAttribute("askList",askService.ask(p_no));
		model.addAttribute("user",session.getAttribute("user"));
		model.addAttribute("replyList",replyService.replyList(p_no));
		System.out.println("유저는 : " +session.getAttribute("user"));
		
		List<Reply_Tbl> list = replyService.replyList(p_no);
		List<String[]> array = new ArrayList<String[]>();
//		for(Reply_Tbl reply : list) {
//			System.out.println(Arrays.toString(reply.getR_img().split(",")));
//			array.add((reply.getR_img().split(",")));
//		}
////		for(int i =0; i<list.size(); i++) {
////			array.add(list.get(i).getR_img().split(","));
////			System.out.println(list.get(i).getR_img().split(","));
////
////		}

		
		model.addAttribute("imgArray",array );

		
		return "carshop/productdetails";
	}
	@RequestMapping("/product/list")
	public String list(Model model) {
		model.addAttribute("list", productBuyService.getProductAll());
		model.addAttribute("cateParent", categoryService.cateParent());
		model.addAttribute("category", categoryService.category());
		return "carshop/productList";
	}
	@ResponseBody
	@PostMapping("/product/list")
	public List<ProductCategoryJoin> selcetlist(@Param("categoryNum")Integer categoryNum) {
		return productBuyService.getProductCategory(categoryNum,null);
	}
	@ResponseBody
	@PostMapping("/product/detailList")
	public List<ProductCategoryJoin> selcetDetailList(@Param("categoryNum")Integer categoryNum) {
		return productBuyService.getProductCategory(null,categoryNum);
	}
	@ResponseBody
	@PostMapping("/product/addcart")
	public boolean pushCart(int p_no, String u_id) {
	    return productBuyService.pushCart(p_no, u_id);
	}  

	@ResponseBody
	@PostMapping("/product/addlike")
	public boolean addLike(int p_no, String u_id) {
		
		return productBuyService.addLike(p_no, u_id);
	}
	@ResponseBody
	@PostMapping("/product/checkLiked")
	public boolean checkLiked(@Param("p_no")int p_no,@Param("u_id")String u_id) {
		
		return likeService.getUserLikeProduct(p_no, u_id);
	}
	@ResponseBody
	@PostMapping("/product/removeLiked")
	public int checkOutLiked(int p_no,String u_id) {

		return likeService.deleteLike(p_no, u_id);
	}
	
}

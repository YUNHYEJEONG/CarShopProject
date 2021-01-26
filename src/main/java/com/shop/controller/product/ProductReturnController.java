package com.shop.controller.product;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.service.product.ProductReturnService;
import com.shop.vo.All_User_Tbl;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/carshop/*")
@Slf4j
public class ProductReturnController {

	@Setter(onMethod_ = @Autowired)
	private ProductReturnService service;

	@RequestMapping("/return_end")
	public String return_end(Model model,HttpSession session) {

		try {
			String s_id = (String) session.getAttribute("id");
			All_User_Tbl user = (All_User_Tbl) session.getAttribute("user");
			String seller = user.getSeller();
			model.addAttribute("list", service.retrun_(s_id));
			model.addAttribute("count",service.count(s_id));
			model.addAttribute("id",session.getAttribute("id"));		
			
			
			if(seller.equals("Y")) {
				

				return "carshop/return_end";
				
			}else {
				return "error/gradeError";
			}
			
		} catch (Exception e) {
				return "redirect:/carshop/error";  //문제가 생겼을 경우 에러페이지로 이동 -성연 2021.01.07";
		}
		



	}
	
	@GetMapping("/clickDate")
	@ResponseBody
	public Map<String, Object> order_date(@RequestParam("click_date") String click_date , @RequestParam("s_id")String s_id, Model model) {
			Map<String, Object> map = new HashMap<String, Object>();
			
		try {
			String str = click_date.substring(1);
			System.out.println("클릭 날짜 : " +click_date.substring(1));
			System.out.println("아이디 : " +s_id) ;
			map.put("list", service.order_date(str,s_id));
			map.put("errorCode", 1);
			// 예외 발생시 catch문으로 간다			
			
			} catch (Exception e) {
			map.put("errorCode", 2);
	
			}
				return map;


	}
	
	@PostMapping("/delete")
	@ResponseBody
	public Map<String, Object> delete(@RequestParam("ono") int ono ) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("delete 들어옴" + ono);
		
			try {
				service.insert_select(ono);
				map.put("errorCode", 1);
			} catch (Exception e) {
				map.put("errorCode", 2);			
				
			}


		return map;
	}

}

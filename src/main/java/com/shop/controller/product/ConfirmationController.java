package com.shop.controller.product;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.service.product.ConfirmationService;
import com.shop.vo.Order_Histroy_Tbl;
import com.shop.vo.Prod_Tbl;
import com.shop.vo.Return_Tbl;
import com.shop.vo.User_Tbl;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/carshop/*")
@Slf4j
public class ConfirmationController {
	
	@Setter(onMethod_ = @Autowired)
	private ConfirmationService service;
	
	@GetMapping("/confirmation")
	public String getConfirmation(Model model, HttpSession session, Order_Histroy_Tbl order, User_Tbl user, Prod_Tbl prod) {
		
		//String u_id = "something";
		String getId = (String)session.getAttribute("id"); // 이미 세션의 set attribute로 id가 설정 되어 있기 때문에 바로 get attribute로 id 가져옴 (재원/20.12.31)
		// 유저 vo 의 id 를 setter로 getId 설정 (재원/20.12.31)
		System.out.println(getId);
		user.setU_id(getId);
		
		model.addAttribute("buylist", service.formList(user.getU_id()));


		return "carshop/confirmation";
	}
	
	@PostMapping("/isRefundTrue") 
	@ResponseBody
	public boolean isRefundTrue (@RequestParam(value = "ono") int ono) {
		//@RequestParam(value = "ono", required = false)
		return service.returnOne(ono);
		
	}
	

	@GetMapping("/clickdateOrder")
	@ResponseBody
	public List<Order_Histroy_Tbl> order_dates(@RequestParam("order_date") String order_date, Model model, @RequestParam("u_id") String u_id, HttpSession session) {
		System.out.println("클릭 날짜 : " + order_date);
		//System.out.println("아이디 : " + u_id);
		//System.out.println("아이디 : " + u_id);
		// 유저 vo 의 id 를 setter로 getId 설정 (재원/20.12.31)
	
		model.addAttribute("order_date", service.orderListDate(u_id, order_date));

		return service.orderListDate(u_id, order_date);

	}
	
	@GetMapping("/clickeventOrder")
	@ResponseBody
	public List<Order_Histroy_Tbl> order_events(@RequestParam("ono") int ono, @RequestParam("order_date") String order_date, Model model, @RequestParam("u_id") String u_id, HttpSession session) {
		System.out.println("클릭 날짜 : " + order_date);
		//System.out.println("아이디 : " + u_id);
		//System.out.println("아이디 : " + u_id);
		// 유저 vo 의 id 를 setter로 getId 설정 (재원/20.12.31)
	
		model.addAttribute("order_event", service.orderEventLists(u_id, order_date, ono));

		return service.orderEventLists(u_id, order_date, ono);

	}
	
	@PostMapping("/confirmation")
	@ResponseBody
	public String getCallenderTitle(Model model, HttpSession session, User_Tbl user, Return_Tbl returntbl) {
		
		
		service.insertForms(returntbl);
		return "redirect:/carshop/confirmation";
		
	}
	
	
}

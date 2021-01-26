package com.shop.controller.member;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.service.member.CalService;
import com.shop.service.member.MyPageService;
import com.shop.vo.All_User_Tbl;
import com.shop.vo.CalendarVO;
import com.shop.vo.Criteria;
import com.shop.vo.MyAskPageDTO;
import com.shop.vo.Seller_Tbl;
import com.shop.vo.User_Tbl;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/carshop/*")
@AllArgsConstructor
public class MyPageController {

	@Setter(onMethod_ = @Autowired)
	private CalService calservice; // 달력 스케줄 추가삭제 서비스 -Monica 2020.12.31

	@Setter(onMethod_ = @Autowired)
	private MyPageService pageservice;  // -성연 2021.01.07

	@RequestMapping("/mypage") // 마이페이지 접근
	public String mypage(Model model, HttpSession session) { // 세션 받을 수 있게 HttpSession -Monica 2020.12.31
		// session.setAttribute("id", "asdf"); //셀러
		// session.setAttribute("id", "2sn$g"); //일반유저
		String uid = (String) session.getAttribute("id");
		// System.out.println(uid);
		model.addAttribute("schedules", calservice.getschdList(uid));
		//System.out.println(calservice.getschdList(uid));
		model.addAttribute("idcal", uid);
		model.addAttribute("bestpord", pageservice.bestprods());

		Seller_Tbl sellerVO;
		User_Tbl userVO;
		All_User_Tbl alluser = null;  //세션에서 user 받아오기 위해 필요 -성연 2021.01.07

		//try {
			alluser = (All_User_Tbl) session.getAttribute("user"); //로그인 된 유저 기본정보 가져옴 -성연 2021.01.07
			//System.out.println("셀러?" + alluser.getSeller());
			if ((alluser.getSeller()).equals("Y")) { //기본정보에서 seller값이 Y일 때
				sellerVO = pageservice.getseller(uid); //셀러테이블에서 아이디에 대한 정보 조회 -성연 2021.01.07
				model.addAttribute("userinfo", sellerVO);
				model.addAttribute("status", "seller");
			} else if ((alluser.getSeller()).equals("N")) {  //seller값이 N일 때
				userVO = pageservice.getuser(uid);  //일반유저테이블에서 아이디에 대한 정보 조회 -성연 2021.01.07
				model.addAttribute("userinfo", userVO);
				model.addAttribute("status", "user");
			}
		//} catch (Exception e) {
		//	System.out.println("셀러여부 가져오기 실패");
		//	return "redirect:/carshop/error";  //문제가 생겼을 경우 에러페이지로 이동 -성연 2021.01.07
		//}



		return "carshop/mypage";

	}

	@PostMapping("/insert") // 달력 스케쥴 db에 저장 -Monica 2020.12.31
	public String insertSchd(String u_id, String schdtitle, String schdstart, String cal_year, String cal_month,
			String cal_day) {
//		System.out.println("u_id: " + u_id);
//		System.out.println("schdtitle" + schdtitle);
//		System.out.println("schdstart" + schdstart);
//		System.out.println("cal_year" + cal_year);
//		System.out.println("cal_month" + cal_month);
//		System.out.println("cal_day" + cal_day);
		String endday = cal_year + "-" + cal_month + "-" + cal_day + " " + "23:59:59"; // 나중에 사용하기 편한 형태로 db에 저장 -Monica
																						// 2020.12.31
		CalendarVO calVO = new CalendarVO(); // 달력vo생성 -Monica 2020.12.31
		calVO.setSchdtitle(schdtitle);
		calVO.setSchdstart(schdstart);
		calVO.setSchdend(endday);
		calVO.setU_id(u_id);
		
		try {
			calservice.recordSchd(calVO); // 서비스 호출 -Monica 2020.12.31
		} catch (Exception e) {
			System.out.println("스케쥴인서트 에러");
		}
		

		return "redirect:/carshop/mypage"; // 마이페이지로 리다이렉트 -Monica 2020.12.31
	}

	@GetMapping("/delschd") // 달력 스케쥴 삭제 -Monica 2020.12.31
	public String deleteschd(String u_id, String schdtitle) {
//		System.out.println("u_id: " + u_id);
//		System.out.println("schdtitle" + schdtitle);

		try {
			int a = calservice.removeSchd(u_id, schdtitle); // 서비스 호출 -Monica 2020.12.31
			// System.out.println(a);
		} catch (Exception e) {
			System.out.println("스케쥴삭제 에러");
		}

		return "redirect:/carshop/mypage"; // 마이페이지로 리다이렉트 -Monica 2020.12.31
	}

	@GetMapping(value = "/asklistget", produces = { MediaType.APPLICATION_XML_VALUE, //마이페이지에 출력할 문의목록을 ajax로 가져옴 -성연 2021.01.07
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<MyAskPageDTO> myasklist(int pageNum, HttpSession session) {
		Criteria crit = new Criteria();  //페이징 위한 객체 생성 -성연 2021.01.07
		crit.setPageNum(pageNum);
		crit.setAmount(4);  //마이페이지에서 문의목록은 4개씩 뽑을것이기 때문에 4개로 설정 -성연 2021.01.07
		crit.setStartNum((crit.getPageNum() - 1) * crit.getAmount());  //중요! mysql의 시작인덱스는 1부터이기 때문 -성연 2021.01.07
		//System.out.println("ask crit: " + crit);

		String s_id = null;
		String u_id = null;

		String user = (String) session.getAttribute("id");
		//System.out.println("user id = " + user);
		//System.out.println(pageservice.checkid(user));

		All_User_Tbl alluser = null;

		try {
			alluser = (All_User_Tbl) session.getAttribute("user");
			//System.out.println("셀러?" + alluser.getSeller());
		} catch (Exception e) {
			System.out.println("셀러여부 가져오기 실패2");
		}

		if ((alluser.getSeller()).equals("Y")) { //Y이면 s_id에 세션에서 추출한 아이디값을 담음 -성연 2021.01.07
			s_id = user;
		} else if ((alluser.getSeller()).equals("N")) { //N이면 u_id에 담음 -성연 2021.01.07
			u_id = user;
		}
		//System.out.println("sid: " + s_id + " uid: " + u_id);

		//System.out.println(pageservice.getAskList(crit, s_id, u_id));

		return new ResponseEntity<>(pageservice.getAskList(crit, s_id, u_id), HttpStatus.OK);
	}
	
	@RequestMapping("/bsnspage")  //셀러로 로그인 했을때 사업자등록을 관리하는 페이지 -성연 2021.01.07
	public String businesspage(HttpSession session, Model model) {
		//System.out.println("비즈니즈페이지 입성");
		String s_id = (String)session.getAttribute("id");
		try {
			model.addAttribute("seller", pageservice.getseller(s_id));  //bno, bname위해 셀러정보 조회해서 모델에 담음 -성연 2021.01.07
			//System.out.println("모델입력 완료");
		} catch (Exception e) {
			System.out.println("셀러정보 조회 실패");
		}
		
		
		return "carshop/bsnsupdate";
	}
	
	@PostMapping("/updatebsns")  //사업자정보 업데이트
	public String updatebsns(String b_no, String b_name, HttpSession session) {
		//System.out.println("bno: " + b_no + " bname: " + b_name);
		try {
			pageservice.updatebsns(b_no, b_name, session);  //bno, bname을 입력받고 세션에서 아이디 추출하도록 세션 전달 -성연 2021.01.07
		} catch (Exception e) {
			System.out.println("사업자정보 업데이트 실패");
		}
		
		
		return "redirect:/carshop/mypage";
	}
	
	@RequestMapping("/error") //에러페이지 작동하는지 확인하는 맵핑, 상황에 따라 지울 수도 있음 -성연 2021.01.07
	public void errorpage() {
		//System.out.println("에러페이지 입장");
	}
	
	@ExceptionHandler(Exception.class)
	public String ex(Exception e) {
		System.err.println(e.getClass());
		return "redirect:/carshop/error";
	}
}

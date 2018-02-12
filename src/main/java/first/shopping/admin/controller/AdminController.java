package first.shopping.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.junit.runner.Request;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.support.RequestPartServletServerHttpRequest;
import org.springframework.web.servlet.ModelAndView;

import first.shopping.admin.Paging;
import first.shopping.admin.bean.MemberBean;
import first.shopping.admin.service.AdminService;

@Controller
public class AdminController {
	 Logger log = Logger.getLogger(this.getClass());
	
	
	@Resource(name="adminService")
	private AdminService adminService;
//로그인==================================================================================================
	@RequestMapping(value="signIn.do")
	public String signIn(@RequestParam(value="login_id")String id,@RequestParam(value="login_password")String password) throws Exception{ //이게 불려지기전에 인터셉터를 거쳐옴.
		
		adminService.updateLoginDate(id);
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH);
		
		return "redirect:/main.do?year="+year+"&month="+month;
	}
	
//회원가입==================================================================================================
	@RequestMapping(value="signUp.do")
	public String signUp(@RequestParam(value="signUp_name")String name,@RequestParam(value="signUp_id")String id,
			@RequestParam(value="signUp_password")String password,HttpServletRequest request) throws Exception {
		
		String ip = request.getRemoteAddr();
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("name", name);
		hashMap.put("id", id);
		hashMap.put("password", password);
		hashMap.put("ip", ip);
		adminService.signUp(hashMap);
		
		return "redirect:/index.jsp";
	}
	
//사용자관리==================================================================================================
	@RequestMapping(value="/user.do") //사용자관리 (전체 회원정보), 회원검색(이름,아이디로), 페이징
    public ModelAndView selectUserList(@RequestParam(value="name",required=false)String name,
			@RequestParam(value="id",required=false)String id,@RequestParam(value="page",required=false)String page) throws Exception{
		//
		int pageScale=5;
		int totalRow=0;
		
		if(name!=null || id!=null) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("name", name);
			map.put("id", id);
			totalRow = adminService.getTotalRow(map);
		}else {
			totalRow = adminService.getTotalRow(null);
		}
		
		Paging pg = new Paging();		
		HashMap<String, Object> map = pg.paging(pageScale, totalRow, page);
		map.put("name", name);
		map.put("id", id);
		
		
		ModelAndView mv = new ModelAndView("/admin/user");
        List<Map<String,Object>> list = adminService.selectUserList(map);
        mv.addObject("list", list);
        mv.addObject("map", map);
        mv.addObject("side","user");
         
        return mv;
    }
	
	@RequestMapping(value="/userInfo.do") //회원 상세정보
	public ModelAndView selectUserInfo(@RequestParam(value="id")String id) throws Exception{
		
		ModelAndView mv = new ModelAndView("/admin/userInfo");
		HashMap<String,Object> map =adminService.selectUserInfo(id);
		mv.addObject("map",map);
		System.out.println(map);
		return mv;
	}
	
	@RequestMapping(value="/updateUser.do") //회원 상세정보 업데이트, 수정일, 수정아이피 업데이트
	public String updateUser(@ModelAttribute MemberBean bean,HttpServletRequest request) throws Exception {
		
		String update_ip = request.getRemoteAddr();
		bean.setUpdate_ip(update_ip);
		adminService.updateUser(bean);
		request.setAttribute("errMsg", "수정되었습니다.");
		return "/inc/script";
	}
	
	@RequestMapping(value="/deleteMember.do") //회원 삭제(is_del 업데이트), 삭제일, 삭제아이피 업데이트
	public String deleteMember(@RequestParam(value="no")int no, @RequestParam(value="flag")String flag, HttpServletRequest request) throws Exception{
		
		String ip = request.getRemoteAddr();
		HashMap<String,Object> hashMap = new HashMap<>();
		hashMap.put("no" , no);
		hashMap.put("flag" , flag);
		hashMap.put("ip", ip);
		adminService.updateIsDel(hashMap);
		
		return "redirect:/user.do";
	}
	
//메인===================================================================================================
	@RequestMapping(value="main.do")
	public ModelAndView main(@RequestParam(value="year")int year,@RequestParam(value="month")int month) throws Exception {
		System.out.println(" AdminController.java  - @RequestMapping(value=\"/managePd.do\")");
		ModelAndView mv = new ModelAndView("/admin/main");
		HashMap<String, Object> map = new HashMap<>();
		map.put("year", year);
		map.put("month", month+1);
		
		List<Map<String,Object>> list = adminService.selectCalList(map);
		mv.addObject("list", list);
		mv.addObject("side","main");
		return mv;
	}
	
//코드관리==================================================================================================
	@RequestMapping(value="/Code.do")
    public ModelAndView selectCodeList(@RequestParam(value="name",required=false)String name,
    					@RequestParam(value="use",required=false)String id, @RequestParam(value="page",required=false)String page) throws Exception{
		//
		int pageScale=5;
		int totalRow=0;
		
		if(name!=null) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("name", name);
			map.put("use", id);
			totalRow = adminService.Code_getTotalRow(map);
		}else {
			totalRow = adminService.Code_getTotalRow(null);
		}
		
		Paging pg = new Paging();		
		HashMap<String, Object> map = pg.paging(pageScale, totalRow, page);
		map.put("name", name);
		map.put("use", id);
		
		
		ModelAndView mv = new ModelAndView("/admin/code");
        List<Map<String,Object>> list = adminService.selectCodeList(map);
        mv.addObject("list", list);
        mv.addObject("map", map);
        mv.addObject("side","code");
         
        return mv;
    }
	
//입고재고관리==================================================================================================
	@RequestMapping(value="/product.do")
    public ModelAndView selectproductList(@RequestParam(value="strdate",required=false)String strdate, @RequestParam(value="enddate",required=false)String enddate,
    					@RequestParam(value="workgb",required=false)String workgb, @RequestParam(value="page",required=false)String page) throws Exception{
		//
		int pageScale=5;
		int totalRow=0;
		String Cstrdate = "00000000";
		String Cenddate = "99999999";
		String Cworkgb = "%";
		if(!strdate.equals("")&&!strdate.equals(null)) {
			Cstrdate = strdate;
		}
		if(!enddate.equals("")&&!enddate.equals(null)) {
			Cenddate = enddate;
		}
		if(!enddate.equals("")&&!enddate.equals(null)) {
			Cworkgb = workgb;
		}
		
		System.out.println(Cstrdate+"++"+Cenddate+"++"+Cworkgb);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("strdate", Cstrdate);
		map.put("enddate", Cenddate);
		map.put("workgb", workgb);
		totalRow = adminService.Product_getTotalRow(map);
		
		Paging pg = new Paging();		
		map = pg.paging(pageScale, totalRow, page);
		
		ModelAndView mv = new ModelAndView("/admin/product");
        List<Map<String,Object>> list = adminService.selectProductList(map);
        mv.addObject("list", list);
        mv.addObject("map", map);
        mv.addObject("side","product");
         
        return mv;
    }
	
	//입고재고관리_상세==================================================================================================
		@RequestMapping(value="/product_detail.do")
	    public ModelAndView selectproductList_detail(@RequestParam(value="offer_no",required=false)String offer_no, @RequestParam(value="work_gb",required=false)String work_gb
	    											, @RequestParam(value="insert_gb",required=false)String insert_gb) throws Exception{
			
			HashMap<String, Object> map = new HashMap<>();
			map.put("offer_no", offer_no);
			map.put("work_gb", work_gb);
			map.put("insert_gb", insert_gb);
			
			ModelAndView mv = new ModelAndView("/admin/product_detail");
	        List<Map<String,Object>> list = adminService.selectProductList_detail(map);
	        List<Map<String,Object>> info = adminService.selectinfo(map);
	        mv.addObject("list", list);
	        mv.addObject("map", map);
	        mv.addObject("info", info);
	        mv.addObject("side","product_detail");
	         
	        return mv;
	    }
		
	//입고저장=========================================================================================================
		
		@RequestMapping(value="ipjego.do")
		public ModelAndView ipgoinsert(@RequestParam(value="QTY_ST02", required=true) List<String> QTY_ST02, HttpServletRequest httpServletRequest) throws Exception {
			
			String insert_gb = httpServletRequest.getParameter("insert_gb");

			System.out.println("flag11231 = "+ insert_gb);
			
			
			System.out.println("ipgoinsert test1234");
			System.out.println(QTY_ST02.size()+"!!!!!!!");
			
			ModelAndView mv = new ModelAndView("/admin/main");
			
			return mv;
		}

	
////페이지 전체 예외처리 예외발생시 예외페이지 이동----------------------------------
//		@ExceptionHandler
//	    public ModelAndView exception(HttpServletRequest req, Exception e) throws Exception {       
//			
//			ModelAndView mv = new ModelAndView("/admin/exception");
//			HashMap<String, Object> map = new HashMap<>();
//			map.put("exceptioncontent", e);
//	        mv.addObject("map", map);
//			
//			return mv;
//	    }
//	
	
	
	
	
	
//안쓰는거===================================================================================================
	@RequestMapping(value="/updateRating.do") //등급 업데이트(관리자<->회원), 수정일, 수정아이피 업데이트
	public String updateRating(@RequestParam(value="no")int no,@RequestParam(value="flag")String flag,
			HttpServletRequest request) throws Exception {
		
		String ip = request.getRemoteAddr();
		HashMap<String,Object> hashMap = new HashMap<>();
		hashMap.put("no" , no);
		hashMap.put("flag" , flag);
		hashMap.put("ip", ip);
		adminService.updateRating(hashMap);
		return "redirect:/user.do";
	}

	@RequestMapping(value="/managePd.do") //상품정보
	public ModelAndView selectProductList() throws Exception{
		System.out.println(" AdminController.java  - @RequestMapping(value=\"/managePd.do\")");
		ModelAndView mv = new ModelAndView("/admin/managePd");
		List<Map<String,Object>> list = adminService.selectPdList();
		mv.addObject("list", list);
		return mv;
	}
	
	
}
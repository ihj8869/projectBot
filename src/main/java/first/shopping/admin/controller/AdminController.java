package first.shopping.admin.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.tools.DocumentationTool.Location;

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
import first.shopping.admin.bean.CodeIUbean;
import first.shopping.admin.bean.MemberBean;
import first.shopping.admin.service.AdminService;

@Controller
public class AdminController {
	 Logger log = Logger.getLogger(this.getClass());
	
	
	@Resource(name="adminService")
	private AdminService adminService;
//로그인, 로그아웃==================================================================================================
	@RequestMapping(value="signIn.do")
	public String signIn(@RequestParam(value="login_id")String id,@RequestParam(value="login_password")String password) throws Exception{ //이게 불려지기전에 인터셉터를 거쳐옴.
		
		adminService.updateLoginDate(id);
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH);
		
		return "redirect:/main_v2.do?year="+year+"&month="+month;
	}
	@RequestMapping(value="logout.do")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/index.jsp";
	}
	
//회원가입==================================================================================================
	@RequestMapping(value="signUp.do")
	public String signUp(@RequestParam(value="signUp_name")String name,@RequestParam(value="signUp_id")String id,
			@RequestParam(value="signUp_password")String password,HttpServletRequest request) throws Exception {
		
		String checkPw = adminService.checkPw(id);
		if(checkPw != null) { //아이디 중복체크
			return "redirect:/index.jsp?err_code=dupl_id";
			
		} else {
			String ip = request.getRemoteAddr();
			HashMap<String, Object> hashMap = new HashMap<>();
			hashMap.put("name", name);
			hashMap.put("id", id);
			hashMap.put("password", password);
			hashMap.put("ip", ip);
			adminService.signUp(hashMap);
			
			return "redirect:/index.jsp";
		}
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
		System.out.println(bean.toString());
		return "/inc/script";
	}
	
/*	@RequestMapping(value="/deleteMember.do") //회원 삭제(is_del 업데이트), 삭제일, 삭제아이피 업데이트
	public String deleteMember(@RequestParam(value="no")int no, @RequestParam(value="flag")String flag, HttpServletRequest request) throws Exception{
		
		String ip = request.getRemoteAddr();
		HashMap<String,Object> hashMap = new HashMap<>();
		hashMap.put("no" , no);
		hashMap.put("flag" , flag);
		hashMap.put("ip", ip);
		adminService.updateIsDel(hashMap);
		
		return "redirect:/user.do";
	}*/
	
//메인===================================================================================================
	@RequestMapping(value="main.do")
	public ModelAndView main(@RequestParam(value="year")int year,@RequestParam(value="month")int month) throws Exception {
		
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
	@RequestMapping(value="/code.do")
    public ModelAndView selectCodeList(@RequestParam(value="name",required=false)String name,
    					@RequestParam(value="use",required=false)String id, @RequestParam(value="page",required=false)String page) throws Exception{
		//
		int pageScale=10;
		int totalRow=0;
		HashMap<String, Object> map = new HashMap<>();
		map.put("code", "PRGB");
		System.out.println("11111111111111= " +name);
		
		map.put("name", name);
		map.put("use", id);
		
		totalRow = adminService.Code_getTotalRow(map);
		Paging pg = new Paging();		
		map = pg.paging(pageScale, totalRow, page);
		
		map.put("code", "PRGB");
		map.put("name", name);
		map.put("use", id);
		
		
		ModelAndView mv = new ModelAndView("/admin/code");
        List<Map<String,Object>> list = adminService.selectCodeList(map);
        mv.addObject("list", list);
        mv.addObject("map", map);
        mv.addObject("side","code");
         
        return mv;
    }
	
	@RequestMapping(value="/codeInfo.do") 
	public ModelAndView selectCodeInfo(@RequestParam(value="minor_cd")String minor_cd, @RequestParam(value="insert_gb")String insert_gb) throws Exception{
		
		ModelAndView mv = new ModelAndView("/admin/codeInfo");
		HashMap<String, Object> map = new HashMap<>();
		map.put("code", "PRGB");
		map.put("minor_cd", minor_cd);
		map =adminService.selectCodeInfo(map);
		mv.addObject("map",map);
		mv.addObject("insert_gb",insert_gb);
		
		System.out.println("insert_gb = "+insert_gb);
		
		if(minor_cd.equals("0000")) {
			String code = adminService.selectnewcode("PRGB");
			mv.addObject("new_code", code);
		}
		return mv;
	}
	
	@RequestMapping(value="/codeIU.do")
	public String codeIU(@ModelAttribute MemberBean bean,HttpServletRequest request) throws Exception {
		
		String update_ip = request.getRemoteAddr();
		bean.setUpdate_ip(update_ip);
		bean.setGrade("PRGB");
		
		System.out.println(bean.toString());
		
		if(bean.getInsert_gb().equals("I")) {
			adminService.insertcode(bean);			
		}else if(bean.getInsert_gb().equals("U")) {
			if(bean.getState_gb().equals("N")) {
				
				Calendar cal = Calendar.getInstance();
				String year = String.valueOf(cal.get(Calendar.YEAR));
				String month =  String.valueOf(cal.get(Calendar.MONTH)+1);
				if(month.length()==1) {
					month = "0"+month;
				}
				String date = String.valueOf(cal.get(Calendar.DATE));
				if(date.length()==1) {
					date = "0"+date;
				}
						
				bean.setId(year+month+date);
			}else {
				bean.setId("");
			}
			adminService.updatecode(bean);	
		}
		request.setAttribute("errMsg", "수정되었습니다.");
		System.out.println(bean.toString());
		return "/inc/script";
	}

	
	
//---------------------------------------------------이유코드관리	
	@RequestMapping(value="/code_rs.do")
    public ModelAndView selectCodeList_rs(@RequestParam(value="name",required=false)String name,
    					@RequestParam(value="use",required=false)String id, @RequestParam(value="page",required=false)String page) throws Exception{
		//
		int pageScale=10;
		int totalRow=0;
		HashMap<String, Object> map = new HashMap<>();
		map.put("code", "RSGB");
		
		if(name!=null) {
			map.put("name", name);
			map.put("use", id);
			totalRow = adminService.Code_getTotalRow(map);
		}else {
			totalRow = adminService.Code_getTotalRow(null);
		}
		
		Paging pg = new Paging();		
		map = pg.paging(pageScale, totalRow, page);
		map.put("name", name);
		map.put("use", id);
		
		
		
		ModelAndView mv = new ModelAndView("/admin/code_rs");
        List<Map<String,Object>> list = adminService.selectCodeList(map);
        mv.addObject("list", list);
        mv.addObject("map", map);
        mv.addObject("side","code_rs");
         
        return mv;
    }
	
	
	@RequestMapping(value="/codeInfo_rs.do") 
	public ModelAndView selectCodeInfo_rs(@RequestParam(value="minor_cd")String minor_cd, @RequestParam(value="insert_gb")String insert_gb) throws Exception{
		
		ModelAndView mv = new ModelAndView("/admin/codeInfo_rs");
		HashMap<String, Object> map = new HashMap<>();
		map.put("code", "RSGB");
		map.put("minor_cd", minor_cd);
		map =adminService.selectCodeInfo(map);
		mv.addObject("map",map);
		mv.addObject("insert_gb",insert_gb);
		
		System.out.println("insert_gb = "+insert_gb);
		
		if(minor_cd.equals("0000")) {
			String code = adminService.selectnewcode("RSGB");
			mv.addObject("new_code", code);
		}
		return mv;
	}
	
	
	
	@RequestMapping(value="/codeIU_rs.do")
	public String codeIU_rs(@ModelAttribute MemberBean bean,HttpServletRequest request) throws Exception {
		
		String update_ip = request.getRemoteAddr();
		bean.setUpdate_ip(update_ip);
		bean.setGrade("RSGB");
		
		System.out.println(bean.toString());
		
		if(bean.getInsert_gb().equals("I")) {
			adminService.insertcode(bean);			
		}else if(bean.getInsert_gb().equals("U")) {
			if(bean.getState_gb().equals("N")) {
				
				Calendar cal = Calendar.getInstance();
				String year = String.valueOf(cal.get(Calendar.YEAR));
				String month =  String.valueOf(cal.get(Calendar.MONTH)+1);
				if(month.length()==1) {
					month = "0"+month;
				}
				String date = String.valueOf(cal.get(Calendar.DATE));
				if(date.length()==1) {
					date = "0"+date;
				}
						
				bean.setId(year+month+date);
			}else {
				bean.setId("");
			}
			adminService.updatecode(bean);	
		}
		request.setAttribute("errMsg", "수정되었습니다.");
		System.out.println(bean.toString());
		return "/inc/script";
	}
//입고재고관리==================================================================================================
	 @RequestMapping(value="/product.do")
    public ModelAndView selectproductList(@RequestParam(value="strdate",required=false)String strdate, @RequestParam(value="enddate",required=false)String enddate,
    					@RequestParam(value="workgb",required=false)String workgb, @RequestParam(value="page",required=false)String page) throws Exception{
		int pageScale=10;
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
				
		HashMap<String, Object> map = new HashMap<>();
		map.put("strdate", Cstrdate);
		map.put("enddate", Cenddate);
		map.put("workgb", workgb);
		
		String[] keys = map.keySet().toArray(new String[0]);
		
		
		totalRow = adminService.Product_getTotalRow(map);
		
		System.out.println("totalRow = " + totalRow);
		
		Paging pg = new Paging();		
		map = pg.paging(pageScale, totalRow, page);
		
		ModelAndView mv = new ModelAndView("/admin/product");
		
        List<Map<String,Object>> list = adminService.selectProductList(map);
        mv.addObject("list", list);
        mv.addObject("map", map);
        mv.addObject("side","product");
         
        return mv;
    }
	
	//입고관리_상세==================================================================================================
		@RequestMapping(value="/product_detail_ipgo.do")
	    public ModelAndView selectproductList_detail(@RequestParam(value="offer_no",required=false)String offer_no, @RequestParam(value="work_gb",required=false)String work_gb
	    											, @RequestParam(value="insert_gb",required=false)String insert_gb) throws Exception{
			
			String upornew = "up";
			if(offer_no.equals("0000000000")) {
				Calendar cal = Calendar.getInstance();
				String year = String.valueOf(cal.get(Calendar.YEAR));
				String month =  String.valueOf(cal.get(Calendar.MONTH)+1);
				if(month.length()==1) {
					month = "0"+month;
				}
				String date =  String.valueOf(cal.get(Calendar.DATE));
				offer_no = year+month+date+"99";
				
				upornew = "new";
			}
			
			String date_nm = offer_no.substring(0,4)+"년"+offer_no.substring(4,6)+"월"+offer_no.substring(6,8)+"일";
			
			HashMap<String, Object> map = new HashMap<>();
			map.put("offer_no", offer_no);
			map.put("work_gb", work_gb);
			map.put("insert_gb", insert_gb);
			map.put("date_nm", date_nm);
			map.put("upornew", upornew);
			
			ModelAndView mv = new ModelAndView("/admin/product_detail_ipgo");
	        List<Map<String,Object>> list = adminService.selectProductList_detail(map);
	        List<Map<String,Object>> info = adminService.selectinfo(map);
	        mv.addObject("list", list);
	        mv.addObject("map", map);
	        mv.addObject("info", info);
	        mv.addObject("side","product_detail_ipgo");
	         
	        return mv;
	    }
		
	//입고저장=========================================================================================================
		
		@RequestMapping(value="ipjego.do")
		public String ipgoinsert(@RequestParam(value="PRO_GB", required=true) List<String> PRO_GB, @RequestParam(value="QTY_ST02", required=true) List<String> QTY_ST02, @RequestParam(value="QTY_ST01", required=true) List<String> QTY_ST01
										,@RequestParam(value="OFFER_NO", required=true) String OFFER_NO, HttpServletRequest httpServletRequest) throws Exception {
			
			String insert_gb = httpServletRequest.getParameter("insert_gb");
			String upornew = httpServletRequest.getParameter("upornew");
			String new_offer_no = adminService.selectnewofferno();
			System.out.println("OFFER_NO");
			String page_offer_no = OFFER_NO;
			
			if(upornew.equals("new")) {
				System.out.println("new 페이지 수정");
				page_offer_no = new_offer_no;
			}else {
				System.out.println("삭제후 저장 한다");
				HashMap<String, Object> map= new HashMap<>();
				map.put("offer_no", page_offer_no);
				adminService.product_delete(map);
			}
			
			
			
			for(int i = 0 ; i<PRO_GB.size() ; i++) {
				System.out.println(PRO_GB.get(i));
				
//				System.out.println("new_offer_no ="+page_offer_no+" pro_gb = "+ PRO_GB.get(i) +" QTY_ST01 = "+ QTY_ST01.get(i) +" QTY_ST02 = "+ QTY_ST02.get(i));
				
				HashMap<String, Object> hashMap = new HashMap<>();
				hashMap.put("OFFER_NO",page_offer_no);
				hashMap.put("PRO_GB", PRO_GB.get(i));
				hashMap.put("QTY_ST01", QTY_ST01.get(i));
				hashMap.put("QTY_ST02", QTY_ST02.get(i));
				
				if(!QTY_ST01.get(i).equals("") && !QTY_ST01.get(i).equals("0")) {
					adminService.ipgoinsert_st01(hashMap);
				}
				if(!QTY_ST02.get(i).equals("") && !QTY_ST02.get(i).equals("0")) {
					adminService.ipgoinsert_st02(hashMap);
				}
				hashMap.clear();
				
			}
			
			if(upornew.equals("new")) {
				HashMap<String, Object> map_magam= new HashMap<>();
				map_magam.put("offer_no", page_offer_no);
				adminService.magam(map_magam);
			}
			
			return "redirect:product_detail_ipgo.do?offer_no="+page_offer_no+"&work_gb=WK01&insert_gb=V";
		}
		
		
		//입고 재고관리 삭제 =========================================================================================================
		
			@RequestMapping(value="product_delete.do")
			public String product_delete(@RequestParam(value="offer_no", required=false) String offer_no
												,@RequestParam(value="work_gb", required=false) String work_gb) throws Exception {
				
				System.out.println("입고관리 삭제");
				System.out.println("offer_no = " + offer_no + " work_gb = "+work_gb);
				
				HashMap<String, Object> map= new HashMap<>();
				map.put("offer_no", offer_no);
				map.put("work_gb", work_gb);
				
				adminService.product_delete(map);
				
				return "redirect:/product.do?strdate=&enddate=&workgb=";
			}
			
		//재고관리_상세==================================================================================================
			@RequestMapping(value="/product_detail_jego.do")
		    public ModelAndView selectproductList_detail_jego(@RequestParam(value="offer_no",required=false)String offer_no, @RequestParam(value="work_gb",required=false)String work_gb
		    											, @RequestParam(value="insert_gb",required=false)String insert_gb) throws Exception{
				
				System.out.println("offer_no = " + offer_no);
				String upornew = "up";
				if(offer_no.equals("0000000000")) {
					Calendar cal = Calendar.getInstance();
					String year = String.valueOf(cal.get(Calendar.YEAR));
					String month =  String.valueOf(cal.get(Calendar.MONTH)+1);
					if(month.length()==1) {
						month = "0"+month;
					}
					String date =  String.valueOf(cal.get(Calendar.DATE));
					offer_no = year+month+date+"99";
					
					upornew = "new";
				}
				
				String date_nm = offer_no.substring(0,4)+"년"+offer_no.substring(4,6)+"월"+offer_no.substring(6,8)+"일";
				
				HashMap<String, Object> map = new HashMap<>();
				map.put("offer_no", offer_no);
				map.put("work_gb", work_gb);
				map.put("insert_gb", insert_gb);
				map.put("date_nm", date_nm);
				map.put("upornew", upornew);
				
				ModelAndView mv = new ModelAndView("/admin/product_detail_jego");
		        List<Map<String,Object>> jego_pre = adminService.pro_det_jego_pre(map);
		        List<Map<String,Object>> jego_wk02 = adminService.pro_det_jego_wk02(map);
		        List<Map<String,Object>> jego_wk03 = adminService.pro_det_jego_wk03(map);
		        List<Map<String,Object>> info = adminService.selectinfo(map);
		        mv.addObject("jego_pre", jego_pre);
		        mv.addObject("jego_wk02", jego_wk02);
		        mv.addObject("jego_wk03", jego_wk03);
		        mv.addObject("map", map);
		        mv.addObject("info", info);
		        mv.addObject("side","product_detail_ipgo");
		         
		        return mv;
		    }
			
			//재고저장=========================================================================================================
			
			@RequestMapping(value="jegoinsert.do")
			public String jegoinsert(@RequestParam(value="PRO_GB", required=true) List<String> PRO_GB, @RequestParam(value="QTY_ST02", required=true) List<String> QTY_ST02, @RequestParam(value="QTY_ST01", required=true) List<String> QTY_ST01
											, @RequestParam(value="QTY_ST02_WK03", required=true) List<String> QTY_ST02_WK03, @RequestParam(value="QTY_ST01_WK03", required=true) List<String> QTY_ST01_WK03
											,@RequestParam(value="OFFER_NO", required=true) String OFFER_NO, HttpServletRequest httpServletRequest) throws Exception {
				
				String insert_gb = httpServletRequest.getParameter("insert_gb");
				String upornew = httpServletRequest.getParameter("upornew");
				String new_offer_no = adminService.selectnewofferno();
				System.out.println("OFFER_NO");
				String page_offer_no = OFFER_NO;
				
				System.out.println(page_offer_no);
				
				if(upornew.equals("new")) {
					System.out.println("new 페이지 수정");
					page_offer_no = new_offer_no;
				}else {
					System.out.println("삭제후 저장 한다");
					HashMap<String, Object> map= new HashMap<>();
					map.put("offer_no", page_offer_no);
					adminService.product_delete(map);
				}
				
				
				
				for(int i = 0 ; i<PRO_GB.size() ; i++) {
					System.out.println(PRO_GB.get(i));
					
					System.out.println("new_offer_no ="+page_offer_no+" pro_gb = "+ PRO_GB.get(i) +" QTY_ST01 = "+ QTY_ST01.get(i) +" QTY_ST02 = "+ QTY_ST02.get(i));
					
					HashMap<String, Object> hashMap = new HashMap<>();
					hashMap.put("OFFER_NO",page_offer_no);
					hashMap.put("PRO_GB", PRO_GB.get(i));
					hashMap.put("QTY_ST01", QTY_ST01.get(i));
					hashMap.put("QTY_ST02", QTY_ST02.get(i));
					
					if(!QTY_ST01.get(i).equals("") && !QTY_ST01.get(i).equals("0")) {
						adminService.jegoinsert_st01_wk02(hashMap);
					}
					if(!QTY_ST02.get(i).equals("") && !QTY_ST02.get(i).equals("0")) {
						adminService.jegoinsert_st02_wk02(hashMap);
					}
					
					if(i==0&&(QTY_ST01.get(i).equals("") || QTY_ST01.get(i).equals("0"))&&(QTY_ST02.get(i).equals("") || QTY_ST02.get(i).equals("0"))) {
						adminService.jegoinsert_st01_wk02(hashMap);
					}
					
					hashMap.clear();
					
					System.out.println("new_offer_no ="+page_offer_no+" pro_gb = "+ PRO_GB.get(i) +" QTY_ST01 = "+ QTY_ST01_WK03.get(i) +" QTY_ST02 = "+ QTY_ST02_WK03.get(i));
					
					hashMap.put("OFFER_NO",page_offer_no);
					hashMap.put("PRO_GB", PRO_GB.get(i));
					hashMap.put("QTY_ST01", QTY_ST01_WK03.get(i));
					hashMap.put("QTY_ST02", QTY_ST02_WK03.get(i));
					
					if(!QTY_ST01_WK03.get(i).equals("") && !QTY_ST01_WK03.get(i).equals("0")) {
						adminService.jegoinsert_st01_wk03(hashMap);
					}
					if(!QTY_ST02_WK03.get(i).equals("") && !QTY_ST02_WK03.get(i).equals("0")) {
						adminService.jegoinsert_st02_wk03(hashMap);
					}
					
					hashMap.clear();
					
				}
				
				if(upornew.equals("new")) {
					HashMap<String, Object> map_magam= new HashMap<>();
					map_magam.put("offer_no", page_offer_no);
					adminService.magam(map_magam);
				}
				
				return "redirect:product_detail_jego.do?offer_no="+page_offer_no+"&work_gb=WK02&insert_gb=V";
			}
			
			@RequestMapping(value="/startsetting.do") 
			public String startsetting() throws Exception{
				
				ModelAndView mv = new ModelAndView("/");
				adminService.createBFS_CODE();
				adminService.createBFS_PRODUCT();
				adminService.createBFS_USER();
				adminService.insertcode();
				adminService.insertuser();
				
				return "redirect:/index.jsp";
			}
			
			
			@RequestMapping(value="/statistics.do") 
			public ModelAndView statistics(@RequestParam(value="month", required=true) String month) throws Exception{
				
				ModelAndView mv = new ModelAndView("/admin/statistics");
				
				return mv;
			}

	
//////페이지 전체 예외처리 예외발생시 예외페이지 이동----------------------------------
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

		//V.2==================================================================================================
			
			
		//메인===================================================================================================
		@RequestMapping(value="main_v2.do")
		public ModelAndView main_v2(@RequestParam(value="year")int year,@RequestParam(value="month")int month) throws Exception {
			
			ModelAndView mv = new ModelAndView("/admin/main_v2");
			HashMap<String, Object> map = new HashMap<>();
			map.put("year", year);
			map.put("month", month+1);
			
			List<Map<String,Object>> list = adminService.selectCalList_v2(map);
			mv.addObject("list", list);
			mv.addObject("side","main_v2");
			return mv;
		}
		
			
		@RequestMapping(value="/code_v2.do")
	    public ModelAndView selectCodeList_v2(@RequestParam(value="name",required=false)String name,@RequestParam(value="code_gb")String code_gb,
	    					@RequestParam(value="use",required=false)String id, @RequestParam(value="page",required=false)String page) throws Exception{
			System.out.println("code_v2.do");
			int pageScale=10;
			int totalRow=0;
			HashMap<String, Object> map = new HashMap<>();
			map.put("code_gb", code_gb);
			System.out.println("v2 code_list " +map);
			
			map.put("name", name);
			map.put("use", id);
			
			totalRow = adminService.Code_getTotalRow_v2(map);
			Paging pg = new Paging();		
			map = pg.paging(pageScale, totalRow, page);
			
			map.put("code_gb", code_gb);
			map.put("name", name);
			map.put("use", id);
			
			
			ModelAndView mv = new ModelAndView("/admin/code_v2");
	        List<Map<String,Object>> list = adminService.selectCodeList_v2(map);
	        mv.addObject("list", list);
	        mv.addObject("map", map);
	        mv.addObject("side","code_"+code_gb);
	         
	        return mv;
	    }		
	
		@RequestMapping(value="/codeInfo_v2.do") 
		public ModelAndView selectCodeInfo_v2(@RequestParam(value="code")String code, @RequestParam(value="insert_gb")String insert_gb, 
												@RequestParam(value="code_gb")String code_gb ) throws Exception{
			
			ModelAndView mv = new ModelAndView("/admin/codeInfo_v2");
			HashMap<String, Object> map = new HashMap<>();
			map.put("code", code);
			map.put("code_gb", code_gb);
			map =adminService.selectCodeInfo_v2(map);
			mv.addObject("map",map);
			mv.addObject("insert_gb",insert_gb);
			mv.addObject("code_gb",code_gb);
			
			System.out.println("insert_gb = "+insert_gb);
			
			if(code.equals("0000")) {
				String new_code = adminService.selectnewcode_v2(code_gb);
				List<Map<String,Object>> select_map = adminService.select_upcode(code_gb);
				
				mv.addObject("new_code", new_code);
				mv.addObject("list", select_map);
				
			}
			return mv;
		}
		
		@RequestMapping(value="/codeIU_v2.do")
		public String codeIU_v2(@ModelAttribute CodeIUbean bean,HttpServletRequest request) throws Exception {
			
			String update_ip = request.getRemoteAddr();
			
			System.out.println(bean.toString());
			
			System.out.println("1=" + bean.getCode());
			System.out.println("2=" + bean.getCode_gb());
			System.out.println("3=" + bean.getCode_nm());
			System.out.println("4=" + bean.getInsert_gb());
			System.out.println("5=" + bean.getState_gb());
			System.out.println("6=" + bean.getUp_code());
			System.out.println("7=" + bean.getUp_code_nm());
			
			if(bean.getInsert_gb().equals("I")) {
				
				adminService.insertcode_v2(bean);		
				
				
				
			}else if(bean.getInsert_gb().equals("U")) {
				if(bean.getState_gb().equals("N")) {
					
					Calendar cal = Calendar.getInstance();
					String year = String.valueOf(cal.get(Calendar.YEAR));
					String month =  String.valueOf(cal.get(Calendar.MONTH)+1);
					if(month.length()==1) {
						month = "0"+month;
					}
					String date = String.valueOf(cal.get(Calendar.DATE)+1);
					if(date.length()==1) {
						date = "0"+date;
					}
					
					bean.setUp_code_nm(year+month+date);
							
				}else {
					
				}
				adminService.updatecode_v2(bean);
				adminService.updatecode_v2_plus(bean);
			}
			
			if(bean.getInsert_gb().equals("I")) {
				request.setAttribute("errMsg", "저장되었습니다.");
			}else if(bean.getInsert_gb().equals("I")) {
				request.setAttribute("errMsg", "수정되었습니다.");
			}
			
			System.out.println(bean.toString());
			return "/inc/script";
		}
		
		@RequestMapping(value="/product_v2.do")
	    public ModelAndView ipgolist(@RequestParam(value="strdate",required=false)String strdate, @RequestParam(value="enddate",required=false)String enddate, 
	    							@RequestParam(value="work_gb",required=false)String work_gb,@RequestParam(value="page",required=false)String page
	    							,@RequestParam(value="bigo_text",required=false)String bigo_text
	    							) throws Exception{

				
			int pageScale=10;
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
					
			HashMap<String, Object> map = new HashMap<>();
			map.put("strdate", Cstrdate);
			map.put("enddate", Cenddate);
			map.put("work_gb", work_gb);
			map.put("bigo_text", bigo_text);
			
			String[] keys = map.keySet().toArray(new String[0]);
			
			
			totalRow = adminService.ipgolist_getTotalRow(map);
			
			System.out.println("totalRow = " + totalRow);
			
			Paging pg = new Paging();		
			map = pg.paging(pageScale, totalRow, page);
			
			map.put("strdate", Cstrdate);
			map.put("enddate", Cenddate);
			map.put("work_gb", work_gb);
			map.put("bigo_text", bigo_text);
			
			ModelAndView mv = new ModelAndView("/admin/product_v2");
			
	        List<Map<String,Object>> list = adminService.selectipgolist(map);
	        mv.addObject("list", list);
	        mv.addObject("map", map);
	        
	        if(work_gb.equals("WK01")) {
	        	 mv.addObject("side","product_ipgo");
	        }else if(work_gb.equals("WK02")) {
	        	 mv.addObject("side","product_jego");
	        }
	       
	         
	        return mv;
	    }
		
		@RequestMapping(value="/product_detail_ipgo_v2.do")
	    public ModelAndView selectproductList_detail_v2(@RequestParam(value="offer_no",required=false)String offer_no, @RequestParam(value="work_gb",required=false)String work_gb
	    												, @RequestParam(value="code_gb",required=false)String code_gb , @RequestParam(value="magam_gb",required=false)String magam_gb
	    												, @RequestParam(value="insert_gb",required=false)String insert_gb, HttpServletResponse response) throws Exception{
			
			HashMap<String, Object> map = new HashMap<>();
			ModelAndView mv = new ModelAndView("/admin/product_detail_ipgo_v2");
			List<Map<String,Object>> work = null;
	        List<Map<String,Object>> ipgo = null;
	        List<Map<String,Object>> jin = null;
	        String gostop = "g";
	        
	        int jego_magam_check = adminService.jego_magam_check();
			
			if(jego_magam_check>0) {
				response.setContentType("text/html; charset=UTF-8");

	            PrintWriter out = response.getWriter();

	            out.println("<script>alert('마감되지 않은 재고작업이 존재합니다.'); history.go(-1);</script>");

	            out.flush(); 
	            
	            gostop= "s";
			}
			
			if(gostop.equals("g")) {
				
				map.put("magam_gb", magam_gb);
		        map.put("work_gb", work_gb);
		        map.put("code_gb", code_gb);
		        
				if(insert_gb.equals("I")) {
					String new_offer_no = adminService.selectnewofferno_v2();
					System.out.println(new_offer_no);
					map.put("new_offer_no", new_offer_no);
					
					adminService.new_work_insert(map);
					
					offer_no = new_offer_no;
				}
				
				map.put("offer_no", offer_no);
				map.put("magam_gb", magam_gb);
				
				
				if(Integer.parseInt(magam_gb)>0) {
					
					work = adminService.selectwork(map);
					
					if(magam_gb.equals("1")) {
						ipgo = adminService.selectipgo(map);
					}
					
					if(Integer.parseInt(magam_gb)>1) {
						
						ipgo = adminService.selectipgo(map);
						
						if(magam_gb.equals("2")) {
							jin = adminService.selectjin(map);
						}
						
						if(Integer.parseInt(magam_gb)>2) {
							
							jin = adminService.selectjin(map);
							
						}
					}
				}
				
				map.put("offer_no", offer_no);
				map.put("work_gb", work_gb);
				map.put("insert_gb", insert_gb);
				
				
		        mv.addObject("work", work);
		        mv.addObject("map", map);
		        mv.addObject("ipgo", ipgo);
		        mv.addObject("jin", jin);
		        mv.addObject("side","product_ipgo");
				
			}
			
	        
	         
	        return mv;
	    }
		
		@RequestMapping(value="ipjego_v2.do")
		public String ipgoinsert_v2(@RequestParam(value="b_code", required=true) List<String> b_code, @RequestParam(value="b_code_nm", required=true) List<String> b_code_nm
									, @RequestParam(value="b_qty_b", required=true) List<String> b_qty_b ,@RequestParam(value="offer_no", required=true) String offer_no
									, @RequestParam(value="magam_gb", required=true) String magam_gb , @RequestParam(value="next_magam_gb", required=true) String next_magam_gb 
									, @RequestParam(value="work_bigo", required=true) String work_bigo , @RequestParam(value="savenext", required=true) String savenext
									, @RequestParam(value="work_gb", required=true) String work_gb, @RequestParam(value="b_bigo_qty", required=true) List<String> b_bigo_qty
									, @RequestParam(value="b_bigo_gb", required=true) List<String> b_bigo_gb, @RequestParam(value="b_bigo", required=true) List<String> b_bigo
									
									, @RequestParam(value="c_code", required=false) List<String> c_code, @RequestParam(value="c_code_b", required=false) List<String> c_code_b
									, @RequestParam(value="c_code_nm", required=false) List<String> c_code_nm, @RequestParam(value="c_qty_c", required=false) List<String> c_qty_c
									, @RequestParam(value="c_price", required=false) List<String> c_price
									
									
									, HttpServletRequest httpServletRequest) throws Exception {
			
			
			System.out.println("------------------------------");
			System.out.println(b_code);
			System.out.println("------------------------------");
			System.out.println(b_code_nm);
			System.out.println("------------------------------");
			System.out.println(b_qty_b);
			System.out.println("------------------------------");
			System.out.println(offer_no);
			System.out.println("------------------------------");
			System.out.println(magam_gb);
			System.out.println("------------------------------");
			System.out.println(next_magam_gb);
			
			HashMap<String, Object> map = new HashMap<>();
			HashMap<String, Object> datamap = new HashMap<>();
			String movemagam = magam_gb;
			
			//work 업데이트
			map.put("offer_no", offer_no);
			map.put("magam_gb", magam_gb);
			map.put("next_magam_gb",next_magam_gb);
			map.put("work_bigo", work_bigo);
			map.put("savenext", savenext);
			
			adminService.work_update(map);
			
			//ipgo 인서트
			if(magam_gb.equals("1")) {
				for(int i = 0 ; i<b_code.size() ; i++) {
					System.out.println(b_code.get(i)+"--"+b_qty_b.get(i));
					
					HashMap<String, Object> hashMap = new HashMap<>();
					datamap.put("offer_no", offer_no);
					datamap.put("b_code", b_code.get(i));
					datamap.put("b_qty_b", b_qty_b.get(i));
					datamap.put("b_bigo", b_bigo.get(i));
					
					adminService.ipgo_insert(datamap);
					
					hashMap.clear();
					
				}
			}
			
			//ipgo 업데이트
			if(magam_gb.equals("2")||magam_gb.equals("3")) {
				for(int i = 0 ; i<b_code.size() ; i++) {
					System.out.println(b_code.get(i)+"--"+b_qty_b.get(i));
					
					HashMap<String, Object> hashMap = new HashMap<>();
					datamap.put("offer_no", offer_no);
					datamap.put("b_code", b_code.get(i));
					datamap.put("b_qty_b", b_qty_b.get(i));
					datamap.put("b_bigo_qty", b_bigo_qty.get(i));
					datamap.put("b_bigo_gb", b_bigo_gb.get(i));
					datamap.put("b_bigo", b_bigo.get(i));
					
					adminService.ipgo_update(datamap);
					
					hashMap.clear();
					
				}
			}
			
			//jin 인서트
			if(magam_gb.equals("2")) {
				System.out.println("c_code.size = " + c_code.size());
				
				for(int i = 0 ; i<c_code.size() ; i++) {
					System.out.println(c_code.get(i)+"--"+c_qty_c.get(i));
					
					HashMap<String, Object> hashMap = new HashMap<>();
					datamap.put("offer_no", offer_no);
					datamap.put("c_code", c_code.get(i));
					datamap.put("c_qty_c", c_qty_c.get(i));
					datamap.put("c_code_b", c_code_b.get(i));
					datamap.put("c_price", c_price.get(i));
					
					adminService.jin_insert(datamap);
					
					hashMap.clear();
					
				}
			}
			
			//jin 업데이트
			if(magam_gb.equals("3")) {
				for(int i = 0 ; i<c_code.size() ; i++) {
					System.out.println(c_code.get(i)+"--"+c_qty_c.get(i));
					
					HashMap<String, Object> hashMap = new HashMap<>();
					datamap.put("offer_no", offer_no);
					datamap.put("c_code", c_code.get(i));
					datamap.put("c_qty_c", c_qty_c.get(i));
					datamap.put("c_code_b", c_code_b.get(i));
					datamap.put("c_price", c_price.get(i));
					
					adminService.jin_update(datamap);
					
					hashMap.clear();
					
				}
			}
			
			if(savenext.equals("Y")) {
				movemagam = next_magam_gb;
			}
			
			return "redirect:product_detail_ipgo_v2.do?offer_no="+offer_no+"&work_gb="+work_gb+"&insert_gb=V&code_gb=B&magam_gb="+movemagam;
		}
		
		@RequestMapping(value="product_delete_v2.do")
		public String product_delete_v2(@RequestParam(value="offer_no", required=false) String offer_no
											,@RequestParam(value="work_gb", required=false) String work_gb) throws Exception {
			
			HashMap<String, Object> map= new HashMap<>();
			map.put("offer_no", offer_no);
			map.put("work_gb", work_gb);
			
			adminService.product_delete_work(map);
			adminService.product_delete_ipgo(map);
			adminService.product_delete_jin(map);
			adminService.product_delete_jego(map);
			
			return "redirect:/product_v2.do?strdate=&enddate=&work_gb="+work_gb;
		}
		
		@RequestMapping(value="/product_detail_jego_v2.do")
	    public ModelAndView selectproductList_detail_jego_v2(@RequestParam(value="offer_no",required=false)String offer_no, @RequestParam(value="work_gb",required=false)String work_gb
	    												, @RequestParam(value="code_gb",required=false)String code_gb , @RequestParam(value="magam_gb",required=false)String magam_gb
	    												, @RequestParam(value="insert_gb",required=false)String insert_gb, HttpServletResponse response) throws Exception{
			
			HashMap<String, Object> map = new HashMap<>();
			ModelAndView mv = new ModelAndView("/admin/product_detail_jego_v2");
			List<Map<String,Object>> work = null;
	        List<Map<String,Object>> jego = null;
			
	        map.put("magam_gb", magam_gb);
	        map.put("work_gb", work_gb);
	        map.put("code_gb", code_gb);
	        String gostop = "g";
	        
			if(insert_gb.equals("I")) {
				String new_offer_no = adminService.selectnewofferno_v2();
				String pre_offer_no = adminService.selectpreofferno_v2();
				System.out.println(new_offer_no);
				map.put("new_offer_no", new_offer_no);
				map.put("pre_offer_no", pre_offer_no);
				
				int ipgo_magam_check = adminService.ipgo_magam_check(map);
				int jego_magam_check = adminService.jego_magam_check();
				
				
				if(ipgo_magam_check>0) {
					response.setContentType("text/html; charset=UTF-8");

		            PrintWriter out = response.getWriter();

		            out.println("<script>alert('마감되지 않은 입고작업이 존재합니다.'); history.go(-1);</script>");

		            out.flush(); 
		            
		            gostop= "s";
		            
				}
				
				
				if(jego_magam_check>0) {
					response.setContentType("text/html; charset=UTF-8");

		            PrintWriter out = response.getWriter();

		            out.println("<script>alert('마감되지 않은 재고작업이 존재합니다.'); history.go(-1);</script>");

		            out.flush(); 
		            
		            gostop= "s";
				}
				
				
				if(gostop.equals("g")) {
					adminService.new_work_insert(map);
					adminService.new_jego_insert(map);
					
					offer_no = new_offer_no;
				}
				
			}
			
			if(gostop.equals("g")) {
			
				map.put("offer_no", offer_no);
				map.put("magam_gb", magam_gb);
				
				
				work = adminService.selectwork(map);
				jego = adminService.selectjego(map);
				
				map.put("offer_no", offer_no);
				map.put("work_gb", work_gb);
				map.put("insert_gb", insert_gb);
				
				
		        mv.addObject("work", work);
		        mv.addObject("map", map);
		        mv.addObject("jego", jego);
		        mv.addObject("side","product_jego");
			}
	         
	        return mv;
	    }
		
		@RequestMapping(value="jego_v2.do")
		public String jegoinsert_v2(@RequestParam(value="a_code", required=true) List<String> a_code, @RequestParam(value="a_code_nm", required=true) List<String> a_code_nm
									, @RequestParam(value="a_qty_a", required=true) List<String> a_qty_a , @RequestParam(value="a_qty_p", required=true) List<String> a_qty_p 
									, @RequestParam(value="a_qty_d", required=true) List<String> a_qty_d 
									, @RequestParam(value="offer_no", required=true) String offer_no, @RequestParam(value="magam_gb", required=true) String magam_gb 
									, @RequestParam(value="next_magam_gb", required=true) String next_magam_gb 
									, @RequestParam(value="work_bigo", required=true) String work_bigo , @RequestParam(value="savenext", required=true) String savenext
									, @RequestParam(value="work_gb", required=true) String work_gb, @RequestParam(value="a_bigo_qty", required=true) List<String> a_bigo_qty
									, @RequestParam(value="a_bigo_gb", required=true) List<String> a_bigo_gb, @RequestParam(value="a_bigo", required=true) List<String> a_bigo
									
									, HttpServletRequest httpServletRequest) throws Exception {
			
			
			System.out.println("------------------------------");
			System.out.println(a_code);
			System.out.println("------------------------------");
			System.out.println(a_code_nm);
			System.out.println("------------------------------");
			System.out.println(a_qty_a);
			System.out.println("------------------------------");
			System.out.println(offer_no);
			System.out.println("------------------------------");
			System.out.println(magam_gb);
			System.out.println("------------------------------");
			System.out.println(next_magam_gb);
			
			HashMap<String, Object> map = new HashMap<>();
			HashMap<String, Object> datamap = new HashMap<>();
			String movemagam = magam_gb;
			
			//work 업데이트
			map.put("offer_no", offer_no);
			map.put("magam_gb", magam_gb);
			map.put("next_magam_gb",next_magam_gb);
			map.put("work_bigo", work_bigo);
			map.put("savenext", savenext);
			
			adminService.work_update(map);
			
			//jego 업데이트
			for(int i = 0 ; i<a_code.size() ; i++) {
				System.out.println(a_code.get(i)+"--"+a_qty_a.get(i));
				
				HashMap<String, Object> hashMap = new HashMap<>();
				datamap.put("offer_no", offer_no);
				datamap.put("a_code", a_code.get(i));
				datamap.put("a_code_nm", a_code.get(i));
				datamap.put("a_qty_a", a_qty_a.get(i));
				datamap.put("a_qty_d", a_qty_d.get(i));
				datamap.put("a_qty_p", a_qty_p.get(i));
				datamap.put("a_bigo_qty", a_bigo_qty.get(i));
				datamap.put("a_bigo_gb", a_bigo_gb.get(i));
				datamap.put("a_bigo", a_bigo.get(i));
				
				adminService.jego_update(datamap);
				
				hashMap.clear();
				
			}
			
			
			if(savenext.equals("Y")) {
				movemagam = next_magam_gb;
			}
			
			return "redirect:product_detail_jego_v2.do?offer_no="+offer_no+"&work_gb="+work_gb+"&insert_gb=V&code_gb=B&magam_gb="+movemagam;
		}

		
		
		
		
	
	
	
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
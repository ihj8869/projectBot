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
	
	@RequestMapping(value="loginPro.do")
	public String loginProcess(@RequestParam(value="email")String email,@RequestParam(value="password")String password){ //이게 불려지기전에 인터셉터를 거쳐옴.
		System.out.println(" AdminController.java  - @RequestMapping(value=\\\"loginPro.do\\\")");
		
		Calendar cal = Calendar.getInstance();
		
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH);
		
		System.out.println("@@@@@@ month" + month);
		return "redirect:/main.do?year="+year+"&month="+month;
	}
	
	@RequestMapping(value="main.do")
	public ModelAndView main(@RequestParam(value="year")int year,@RequestParam(value="month")int month) throws Exception {
		System.out.println(" AdminController.java  - @RequestMapping(value=\"/managePd.do\")");
		ModelAndView mv = new ModelAndView("/admin/main");
		HashMap<String, Object> map = new HashMap<>();
		map.put("year", year);
		map.put("month", month+1);
		
		List<Map<String,Object>> list = adminService.selectCalList(map);
		mv.addObject("list", list);
		return mv;
	}
//===================================================================================================
	@RequestMapping(value="/manageMember.do") //index.jsp에서 admin 클릭 (전체 회원정보), 회원검색(이름,아이디로), 페이징
    public ModelAndView selectMemberList(@RequestParam(value="name",required=false)String name,
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
		
		
		ModelAndView mv = new ModelAndView("/admin/code");
        List<Map<String,Object>> list = adminService.selectMemberList(map);
        mv.addObject("list", list);
        mv.addObject("map", map);
         
        return mv;
    }
	
	@RequestMapping(value="/updateRating.do") //등급 업데이트(관리자<->회원), 수정일, 수정아이피 업데이트
	public String updateRating(@RequestParam(value="no")int no,@RequestParam(value="flag")String flag,
			HttpServletRequest request) throws Exception {
		
		String ip = request.getRemoteAddr();
		HashMap<String,Object> hashMap = new HashMap<>();
		hashMap.put("no" , no);
		hashMap.put("flag" , flag);
		hashMap.put("ip", ip);
		adminService.updateRating(hashMap);
		return "redirect:/manageMember.do";
	}
	
	@RequestMapping(value="/memberInfo.do") //회원 상세정보
	public ModelAndView selectMemberInfo(@RequestParam(value="no")int no) throws Exception{
		
		ModelAndView mv = new ModelAndView("/admin/memberInfo");
		HashMap<String,Object> map =adminService.selectMemberInfo(no);
		mv.addObject("map",map);
		System.out.println(map);
		return mv;
	}
	
	@RequestMapping(value="/updateMember.do") //회원 상세정보 업데이트, 수정일, 수정아이피 업데이트
	public String updateMember(@ModelAttribute MemberBean bean,HttpServletRequest request) throws Exception {
		
		String ip = request.getRemoteAddr();
		bean.setMod_ip(ip);
		adminService.updateMember(bean);
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
		
		return "redirect:/manageMember.do";
	}
//====================================================================================================
	@RequestMapping(value="/managePd.do") //상품정보
	public ModelAndView selectProductList() throws Exception{
		System.out.println(" AdminController.java  - @RequestMapping(value=\"/managePd.do\")");
		ModelAndView mv = new ModelAndView("/admin/managePd");
		List<Map<String,Object>> list = adminService.selectPdList();
		mv.addObject("list", list);
		return mv;
	}
	
}
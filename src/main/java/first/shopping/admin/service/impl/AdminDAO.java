package first.shopping.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import first.common.dao.AbstractDAO;
import first.shopping.admin.bean.MemberBean;
 
@Repository("adminDAO")
public class AdminDAO extends AbstractDAO{
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectUserList(HashMap<String, Object> map) throws Exception{
		
		//manageMember.jsp에 form이 있을경우(현재는 삭제함), 회원 검색 후 수정버튼 클릭시 현재 페이지가 새로고침되기 때문에 파라미터가 null 이라서 부적합한 열유형 #1 에러 발생
		if(map.get("name")==null && map.get("id")==null) { // 파라미터가 null 일 경우, 전체 회원검색
			return (List<Map<String, Object>>)selectList("admin.selectUserList", map);
		}else {
			return (List<Map<String, Object>>)selectList("admin.searchUserList", map);			
		}
	}
	
	public int getTotalRow(HashMap<String, Object> map) throws Exception{
		return (int)selectOne("admin.getTotalRow",map);
	}
	
	public void updateRating(HashMap<String, Object> map) throws Exception{
		update("admin.updateRating", map);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> selectUserInfo(String id) throws Exception{
		return (HashMap<String, Object>)selectOne("admin.selectUserInfo", id);
	}
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> selectCodeInfo(String minor_cd) throws Exception{
		return (HashMap<String, Object>)selectOne("admin.selectCodeInfo", minor_cd);
	}
	
	public void updateUser(MemberBean bean) throws Exception{
		update("admin.updateUser", bean);
	}
	
	public void updateIsDel(HashMap<String, Object> map) throws Exception{
		update("admin.updateIsDel", map);
	}
//====================================================================================================
	public String checkPw(String id) throws Exception{
		return (String)selectOne("admin.checkPw", id);
	}
	public String checkState(String id) throws Exception{
		return (String)selectOne("admin.checkState", id);
	}
	public String checkId(String id) throws Exception{
		return (String)selectOne("admin.checkId", id);
	}
	
	public void updateLoginDate(String id) throws Exception{
		update("admin.updateLoginDate", id);
	}
	
	public void signUp(HashMap<String, Object> map) throws Exception{
		insert("admin.signUp", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPdList() throws Exception{
		return (List<Map<String, Object>>)selectList("admin.selectPdList");
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCalList(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO - public List<Map<String, Object>> selectCalList() throws Exception");
		return (List<Map<String, Object>>)selectList("admin.selectCalList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCodeList(HashMap<String, Object> map) throws Exception{
		
		return (List<Map<String, Object>>)selectList("admin.searchCodeList", map);			
	}
	
	public int Code_getTotalRow(HashMap<String, Object> map) throws Exception{
		return (int)selectOne("admin.Code_getTotalRow",map);
	}
	
	public int Product_getTotalRow(HashMap<String, Object> map) throws Exception{
		return (int)selectOne("admin.Product_getTotalRow",map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProductList(HashMap<String, Object> map) throws Exception{
		System.out.println(map.get("workgb"));
		System.out.println(map.get("strdate"));
		System.out.println(map.get("enddate"));
		return (List<Map<String, Object>>)selectList("admin.searchProductList", map);			
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectProductList_detail(HashMap<String, Object> map) throws Exception{
		
		return (List<Map<String, Object>>)selectList("admin.searchProductList_Detail", map);			
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectinfo(HashMap<String, Object> map) throws Exception{
		
		return (List<Map<String, Object>>)selectList("admin.searchinfo", map);			
	}
	
	@SuppressWarnings("unchecked")
	public String selectnewofferno() throws Exception{
		
		return (String)selectOne("admin.serchofferno");
	}
	
	public void ipgoinsert_st01(HashMap<String, Object> map) throws Exception{
		insert("admin.ipgoinsert_st01", map);
	}
	
	public void ipgoinsert_st02(HashMap<String, Object> map) throws Exception{
		insert("admin.ipgoinsert_st02", map);
	}
	
	public void product_delete(HashMap<String, Object> map) throws Exception{
		delete("admin.product_delete", map);
	}
	
	public void magam(HashMap<String, Object> map) throws Exception{
		delete("admin.magam", map);
	}
	
	public void magamcheck(HashMap<String, Object> map) throws Exception{
		update("admin.magamcheck", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> pro_det_jego_wk02(HashMap<String, Object> map)throws Exception{
		return (List<Map<String, Object>>)selectList("admin.pro_det_jego_wk02", map);		
	};
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> pro_det_jego_wk03(HashMap<String, Object> map)throws Exception{
		return (List<Map<String, Object>>)selectList("admin.pro_det_jego_wk03", map);		
	};
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> pro_det_jego_pre(HashMap<String, Object> map)throws Exception{
		System.out.println("adminDao");
		return (List<Map<String, Object>>)selectList("admin.pro_det_jego_pre", map);		
	};
	
	public void jegoinsert_st01_wk02(HashMap<String, Object> map) throws Exception{
		insert("admin.jegoinsert_st01_wk02", map);
	}
	
	public void jegoinsert_st02_wk02(HashMap<String, Object> map) throws Exception{
		insert("admin.jegoinsert_st02_wk02", map);
	}
	
	public void jegoinsert_st01_wk03(HashMap<String, Object> map) throws Exception{
		insert("admin.jegoinsert_st01_wk03", map);
	}
	
	public void jegoinsert_st02_wk03(HashMap<String, Object> map) throws Exception{
		insert("admin.jegoinsert_st02_wk03", map);
	}
	
	@SuppressWarnings("unchecked")
	public String selectnewcode() throws Exception{
		
		return (String)selectOne("admin.serchcode");
	}
	
	
}

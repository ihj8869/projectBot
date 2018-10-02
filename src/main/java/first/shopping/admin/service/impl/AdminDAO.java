package first.shopping.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import first.common.dao.AbstractDAO;
import first.shopping.admin.bean.CodeIUbean;
import first.shopping.admin.bean.MemberBean;
 
@Repository("adminDAO")
public class AdminDAO extends AbstractDAO{
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectUserList(HashMap<String, Object> map) throws Exception{
		
		//manageMember.jsp�뿉 form�씠 �엳�쓣寃쎌슦(�쁽�옱�뒗 �궘�젣�븿), �쉶�썝 寃��깋 �썑 �닔�젙踰꾪듉 �겢由��떆 �쁽�옱 �럹�씠吏�媛� �깉濡쒓퀬移⑤릺湲� �븣臾몄뿉 �뙆�씪誘명꽣媛� null �씠�씪�꽌 遺��쟻�빀�븳 �뿴�쑀�삎 #1 �뿉�윭 諛쒖깮
		if(map.get("name")==null && map.get("id")==null) { // �뙆�씪誘명꽣媛� null �씪 寃쎌슦, �쟾泥� �쉶�썝寃��깋
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
	public HashMap<String, Object> selectCodeInfo(HashMap<String, Object> map) throws Exception{
		return (HashMap<String, Object>)selectOne("admin.selectCodeInfo", map);
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
		System.out.println("@@@@@ = " + map);
		return (List<Map<String, Object>>)selectList("admin.searchCodeList", map);			
	}
	
	public int Code_getTotalRow(HashMap<String, Object> map) throws Exception{
//		System.out.println("test1111111111111");
//		System.out.println(map);
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
	public String selectnewcode(String code) throws Exception{
		
		return (String)selectOne("admin.serchcode",code);
	}
	
	public void insertcode(MemberBean bean) throws Exception{
		update("admin.insertcode", bean);
	}
	
	public void updatecode(MemberBean bean) throws Exception{
		update("admin.updatecode", bean);
	}
	
	public void createBFS_CODE() throws Exception{
		update("admin.createBFS_CODE","");
	}
	
	public void createBFS_USER() throws Exception{
		update("admin.createBFS_USER","");
	}
	
	public void createBFS_PRODUCT() throws Exception{
		update("admin.createBFS_PRODUCT","");
	}
	
	public void insertuser() throws Exception{
		insert("admin.insertuser", "");
	}
	
	public void insertcode() throws Exception{
		insert("admin.insertcode2", "");
	}
	
	//------------------------------------------------------------------------------
	
	public int Code_getTotalRow_v2(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO Code_getTotalRow_v2");
		System.out.println("@@@@@ = " + map);
		return (int)selectOne("admin.Code_getTotalRow_v2",map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCodeList_v2(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO selectCodeList_v2");
		System.out.println("@@@@@ = " + map);
		return (List<Map<String, Object>>)selectList("admin.searchCodeList_v2", map);			
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> selectCodeInfo_v2(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO selectCodeInfo_v2");
		System.out.println("@@@@@ = " + map);
		return (HashMap<String, Object>)selectOne("admin.selectCodeInfo_v2", map);
	}
	
	@SuppressWarnings("unchecked")
	public String selectnewcode_v2(String code) throws Exception{
		
		return (String)selectOne("admin.serchcode_v2",code);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select_upcode(String code_gb) throws Exception{
		System.out.println("AdminDAO select_upcode");
		System.out.println("@@@@@ = " + code_gb);
		return (List<Map<String, Object>>)selectList("admin.select_upcode", code_gb);			
	}
	
	public void insertcode_v2(CodeIUbean bean) throws Exception{
		System.out.println("AdminDAO insertcode_v2");
		System.out.println("@@@@@ = " + bean.toString());
		insert("admin.insertcode_v2", bean);
	}
	
	public void updatecode_v2(CodeIUbean bean) throws Exception{
		System.out.println("AdminDAO updatecode_v2");
		System.out.println("@@@@@ = " + bean.toString());
		update("admin.updatecode_v2", bean);
	}
	
	public void updatecode_v2_plus(CodeIUbean bean) throws Exception{
		System.out.println("AdminDAO updatecode_v2_plus");
		System.out.println("@@@@@ = " + bean.toString());
		update("admin.updatecode_v2_plus", bean);
	}
	
	
	public int ipgolist_getTotalRow(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO ipgolist_getTotalRow");
		System.out.println("@@@@@ = " + map);
		
		return (int)selectOne("admin.ipgolist_getTotalRow",map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectipgolist(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO selectipgolist");
		System.out.println("@@@@@ = " + map);
		
		return (List<Map<String, Object>>)selectList("admin.selectipgolist", map);			
	}
	
	@SuppressWarnings("unchecked")
	public String selectnewofferno_v2() throws Exception{
		System.out.println("AdminDAO selectnewofferno_v2");
		
		return (String)selectOne("admin.serchofferno_v2");
	}
	
	public void new_work_insert(HashMap<String, Object> map) throws Exception{
		System.out.println("new_work_insert");
		System.out.println("@@@@@ = " + map);
		
		String go = null;
		
		if(map.get("work_gb").equals("WK01")){
			go = "admin.new_work_insert";
		}else {
			go = "admin.new_work_insert_wk02";
		}
		
		insert(go, map);
		
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectwork(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO selectwork");
		System.out.println("@@@@@ = " + map);
		
		return (List<Map<String, Object>>)selectList("admin.selectwork", map);			
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectipgo(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO selectipgo");
		System.out.println("@@@@@ = " + map);
		System.out.println(map.get("magam_gb"));
		String go = null;
		
		if(map.get("magam_gb").equals("1")){
			go = "admin.new_code_list";
		}else {
			go = "admin.selectipgo";
		}
		
		return (List<Map<String, Object>>)selectList(go, map);			
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectjin(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO selectjin");
		System.out.println("@@@@@ = " + map);
		System.out.println(map.get("magam_gb"));
		String go = null;
		map.put("code_gb","C");
		
		if(map.get("magam_gb").equals("2")){
			go = "admin.new_code_list";
		}else {
			go = "admin.selectjin";
		}
		
		return (List<Map<String, Object>>)selectList(go, map);			
	}
	
	public void work_update(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO work_update");
		System.out.println("@@@@@ = " + map);
		System.out.println(map.get("savenext"));
		String go = null;
		
		if(map.get("savenext").equals("Y")){
			go = "admin.work_update";
		}else {
			go = "admin.work_save";
		}
		
		
		update(go, map);
	}
	
	public void ipgo_insert(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO ipgo_insert");
		System.out.println("@@@@@ = " + map);
		update("admin.ipgo_insert", map);
	}
	
	public void ipgo_update(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO ipgo_update");
		System.out.println("@@@@@ = " + map);
		update("admin.ipgo_update", map);
	}
	
	public void jin_insert(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO jin_insert");
		System.out.println("@@@@@ = " + map);
		update("admin.jin_insert", map);
	}
	
	public void jin_update(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO jin_update");
		System.out.println("@@@@@ = " + map);
		update("admin.jin_update", map);
	}
	
	public void product_delete_work(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO product_delete_work");
		System.out.println("@@@@@ = " + map);
		delete("admin.product_delete_work", map);
	}
	
	public void product_delete_ipgo(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO product_delete_ipgo");
		System.out.println("@@@@@ = " + map);
		delete("admin.product_delete_ipgo", map);
	}
	
	public void product_delete_jin(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO product_delete_jin");
		System.out.println("@@@@@ = " + map);
		delete("admin.product_delete_jin", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCalList_v2(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO selectCalList_v2");
		System.out.println("@@@@@ = " + map);
		
		return (List<Map<String, Object>>)selectList("admin.selectCalList_v2", map);
	}
	
	@SuppressWarnings("unchecked")
	public String selectpreofferno_v2() throws Exception{
		System.out.println("AdminDAO selectpreofferno_v2");
		
		return (String)selectOne("admin.selectpreofferno_v2");
	}
	
	public int ipgo_magam_check(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO ipgo_magam_check");
		System.out.println("@@@@@ = " + map);
		
		return (int)selectOne("admin.ipgo_magam_check",map);
	}
	
	public int jego_magam_check() throws Exception{
		System.out.println("AdminDAO jego_magam_check()");
		
		return (int)selectOne("admin.jego_magam_check()");
	}
	
	public void new_jego_insert(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO new_jego_insert");
		System.out.println("@@@@@ = " + map);
		delete("admin.new_jego_insert", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectjego(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO selectjego");
		System.out.println("@@@@@ = " + map);
		
		return (List<Map<String, Object>>)selectList("admin.selectjego", map);			
	}
	
	public void product_delete_jego(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO product_delete_jego");
		System.out.println("@@@@@ = " + map);
		delete("admin.product_delete_jego", map);
	}
	
	public void jego_update(HashMap<String, Object> map) throws Exception{
		System.out.println("AdminDAO jego_update");
		System.out.println("@@@@@ = " + map);
		update("admin.jego_update", map);
	}
	
	
}

package first.shopping.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import first.shopping.admin.bean.CodeIUbean;
import first.shopping.admin.bean.MemberBean;
import first.shopping.admin.service.AdminService;

 
@Service("adminService")
public class AdminServiceImpl implements AdminService{
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="adminDAO")
	private AdminDAO adminDAO;
	
	@Override
	public List<Map<String, Object>> selectUserList(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectUserList(map);
	}
	
	@Override
	public int getTotalRow(HashMap<String, Object> map) throws Exception {
		return adminDAO.getTotalRow(map);
	}

	@Override
	public void updateRating(HashMap<String, Object> map) throws Exception {
		adminDAO.updateRating(map);
	}
	
	@Override
	public HashMap<String, Object> selectUserInfo(String id) throws Exception {
		return adminDAO.selectUserInfo(id);
	}
	@Override
	public HashMap<String, Object> selectCodeInfo(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectCodeInfo(map);
	}

	@Override
	public void updateUser(MemberBean bean) throws Exception {
		adminDAO.updateUser(bean);
	}

	@Override
	public void updateIsDel(HashMap<String, Object> map) throws Exception {
		adminDAO.updateIsDel(map);
	}
//====================================================================================================
	@Override
	public String checkPw(String id) throws Exception {
		return adminDAO.checkPw(id);
	}
	@Override
	public String checkState(String id) throws Exception {
		return adminDAO.checkState(id);
	}
	@Override
	public String checkId(String id) throws Exception {
		return adminDAO.checkId(id);
	}
	
	@Override
	public void updateLoginDate(String id) throws Exception {
		adminDAO.updateLoginDate(id);
	}
	
	@Override
	public void signUp(HashMap<String, Object> map) throws Exception {
		adminDAO.signUp(map);
	}

	@Override
	public List<Map<String, Object>> selectPdList() throws Exception {
		return adminDAO.selectPdList();
	}

	public List<Map<String, Object>> selectCalList(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectCalList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectCodeList(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectCodeList(map);
	}
	
	@Override
	public int Code_getTotalRow(HashMap<String, Object> map) throws Exception {
		return adminDAO.Code_getTotalRow(map);
	}
	
	@Override
	public int Product_getTotalRow(HashMap<String, Object> map) throws Exception {
		return adminDAO.Product_getTotalRow(map);
	}
	
	@Override
	public List<Map<String, Object>> selectProductList(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectProductList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectProductList_detail(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectProductList_detail(map);
	}
	
	@Override
	public List<Map<String, Object>> selectinfo(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectinfo(map);
	}
	
	@Override
	public String selectnewofferno() throws Exception{
		return adminDAO.selectnewofferno();
	}
	
	@Override
	public void ipgoinsert_st01(HashMap<String, Object> map) throws Exception {
		adminDAO.ipgoinsert_st01(map);
	}
	
	@Override
	public void ipgoinsert_st02(HashMap<String, Object> map) throws Exception {
		adminDAO.ipgoinsert_st02(map);
	}
	
	public void product_delete(HashMap<String, Object> map) throws Exception{
		adminDAO.product_delete( map);
	}
	
	public void magam(HashMap<String, Object> map) throws Exception{
		adminDAO.magam(map);
	}
	
	public void magamcheck(HashMap<String, Object> map) throws Exception{
		adminDAO.magamcheck(map);
	}
	
	public List<Map<String, Object>> pro_det_jego_wk02(HashMap<String, Object> map)throws Exception{
		return adminDAO.pro_det_jego_wk02(map);
	};
	
	public List<Map<String, Object>> pro_det_jego_wk03(HashMap<String, Object> map)throws Exception{
		return adminDAO.pro_det_jego_wk03(map);
	};
	
	public List<Map<String, Object>> pro_det_jego_pre(HashMap<String, Object> map)throws Exception{
		System.out.println("adminservice");
		return adminDAO.pro_det_jego_pre(map);
	};
	
	@Override
	public void jegoinsert_st01_wk02(HashMap<String, Object> map) throws Exception {
		adminDAO.jegoinsert_st01_wk02(map);
	}
	
	@Override
	public void jegoinsert_st02_wk02(HashMap<String, Object> map) throws Exception {
		adminDAO.jegoinsert_st02_wk02(map);
	}
	
	@Override
	public void jegoinsert_st01_wk03(HashMap<String, Object> map) throws Exception {
		adminDAO.jegoinsert_st01_wk03(map);
	}
	
	@Override
	public void jegoinsert_st02_wk03(HashMap<String, Object> map) throws Exception {
		adminDAO.jegoinsert_st02_wk03(map);
	}
	
	@Override
	public String selectnewcode(String code) throws Exception{
		return adminDAO.selectnewcode(code);
	}
	
	@Override
	public void updatecode(MemberBean bean) throws Exception {
		adminDAO.updatecode(bean);
	}
	
	@Override
	public void insertcode(MemberBean bean) throws Exception {
		adminDAO.insertcode(bean);
	}
	
	@Override
	public void createBFS_CODE() throws Exception {
		adminDAO.createBFS_CODE();
	}
	
	@Override
	public void createBFS_USER() throws Exception {
		adminDAO.createBFS_USER();
	}
	
	@Override
	public void createBFS_PRODUCT() throws Exception {
		adminDAO.createBFS_PRODUCT();
	}
	
	@Override
	public void insertcode() throws Exception {
		adminDAO.insertcode();
	}
	
	@Override
	public void insertuser() throws Exception {
		adminDAO.insertuser();
	}
	
	//---------------------------------------------------------------------------------------------------
	
	@Override
	public int Code_getTotalRow_v2(HashMap<String, Object> map) throws Exception {
		return adminDAO.Code_getTotalRow_v2(map);
	}
	
	@Override
	public List<Map<String, Object>> selectCodeList_v2(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectCodeList_v2(map);
	}
	
	@Override
	public HashMap<String, Object> selectCodeInfo_v2(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectCodeInfo_v2(map);
	}
	
	@Override
	public String selectnewcode_v2(String code) throws Exception{
		return adminDAO.selectnewcode_v2(code);
	}
	
	@Override
	public List<Map<String, Object>> select_upcode(String code_gb) throws Exception {
		return adminDAO.select_upcode(code_gb);
	}
	
	@Override
	public void insertcode_v2(CodeIUbean bean) throws Exception {
		adminDAO.insertcode_v2(bean);
	}
	
	@Override
	public void updatecode_v2(CodeIUbean bean) throws Exception {
		adminDAO.updatecode_v2(bean);
	}
	
	@Override
	public void updatecode_v2_plus(CodeIUbean bean) throws Exception {
		adminDAO.updatecode_v2_plus(bean);
	}
	
	@Override
	public int ipgolist_getTotalRow(HashMap<String, Object> map) throws Exception {
		return adminDAO.ipgolist_getTotalRow(map);
	}
	
	@Override
	public List<Map<String, Object>> selectipgolist(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectipgolist(map);
	}
	
	@Override
	public String selectnewofferno_v2() throws Exception{
		return adminDAO.selectnewofferno_v2();
	}
	
	@Override
	public void new_work_insert(HashMap<String, Object> map) throws Exception {
		adminDAO.new_work_insert(map);
	}
	
	@Override
	public List<Map<String, Object>> selectwork(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectwork(map);
	}
	
	
	@Override
	public List<Map<String, Object>> selectipgo(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectipgo(map);
	}
	
	
	@Override
	public List<Map<String, Object>> selectjin(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectjin(map);
	}
	
	@Override
	public void work_update(HashMap<String, Object> map) throws Exception {
		adminDAO.work_update(map);
	}
	
	@Override
	public void ipgo_insert(HashMap<String, Object> map) throws Exception {
		adminDAO.ipgo_insert(map);
	}
	
	@Override
	public void ipgo_update(HashMap<String, Object> map) throws Exception {
		adminDAO.ipgo_update(map);
	}
	
	@Override
	public void jin_insert(HashMap<String, Object> map) throws Exception {
		adminDAO.jin_insert(map);
	}
	
	@Override
	public void jin_update(HashMap<String, Object> map) throws Exception {
		adminDAO.jin_update(map);
	}
	
	
	public void product_delete_work(HashMap<String, Object> map) throws Exception{
		adminDAO.product_delete_work( map);
	}
	
	public void product_delete_ipgo(HashMap<String, Object> map) throws Exception{
		adminDAO.product_delete_ipgo( map);
	}
	
	public void product_delete_jin(HashMap<String, Object> map) throws Exception{
		adminDAO.product_delete_jin( map);
	}
	
	public List<Map<String, Object>> selectCalList_v2(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectCalList_v2(map);
	}
	
	@Override
	public String selectpreofferno_v2() throws Exception{
		return adminDAO.selectpreofferno_v2();
	}
	
	@Override
	public int ipgo_magam_check(HashMap<String, Object> map) throws Exception {
		return adminDAO.ipgo_magam_check(map);
	}
	
	@Override
	public int jego_magam_check() throws Exception {
		return adminDAO.jego_magam_check();
	}
	
	public void new_jego_insert(HashMap<String, Object> map) throws Exception{
		adminDAO.new_jego_insert(map);
	}
	
	public List<Map<String, Object>> selectjego(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectjego(map);
	}
	
	public void product_delete_jego(HashMap<String, Object> map) throws Exception{
		adminDAO.product_delete_jego( map);
	}
	
	@Override
	public void jego_update(HashMap<String, Object> map) throws Exception {
		adminDAO.jego_update(map);
	}

}



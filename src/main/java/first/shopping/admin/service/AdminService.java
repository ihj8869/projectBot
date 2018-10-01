package first.shopping.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import first.shopping.admin.bean.CodeIUbean;
import first.shopping.admin.bean.MemberBean;


public interface AdminService {
	
	List<Map<String, Object>> selectUserList(HashMap<String, Object> map) throws Exception;
	
	int getTotalRow(HashMap<String, Object> map)throws Exception;
	
	public void updateRating(HashMap<String, Object> map) throws Exception;
	
	HashMap<String, Object> selectUserInfo(String id) throws Exception;
	HashMap<String, Object> selectCodeInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateUser(MemberBean bean) throws Exception;
	
	public void updateIsDel(HashMap<String, Object> map) throws Exception;
//====================================================================================================
	String checkPw(String id)throws Exception;
	String checkState(String id)throws Exception;
	String checkId(String id)throws Exception;
	
	public void updateLoginDate(String id)throws Exception;
	
	public void signUp(HashMap<String, Object> map)throws Exception;
	
	List<Map<String, Object>> selectPdList() throws Exception;
	
	List<Map<String, Object>> selectCalList(HashMap<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectCodeList(HashMap<String, Object> map) throws Exception;
	
	int Code_getTotalRow(HashMap<String, Object> map) throws Exception;
	
	int Product_getTotalRow(HashMap<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectProductList(HashMap<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectProductList_detail(HashMap<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectinfo(HashMap<String, Object> map) throws Exception;
	
	String selectnewofferno() throws Exception;
	
	public void ipgoinsert_st01(HashMap<String, Object> map)throws Exception;
	
	public void ipgoinsert_st02(HashMap<String, Object> map)throws Exception;
	
	public void product_delete(HashMap<String, Object> map)throws Exception;
	
	public void magam(HashMap<String, Object> map)throws Exception;
	
	public void magamcheck(HashMap<String, Object> map)throws Exception;
	
	public List<Map<String, Object>> pro_det_jego_wk02(HashMap<String, Object> map)throws Exception;
	
	public List<Map<String, Object>> pro_det_jego_wk03(HashMap<String, Object> map)throws Exception;
	
	public List<Map<String, Object>> pro_det_jego_pre(HashMap<String, Object> map)throws Exception;
	
	public void jegoinsert_st01_wk02(HashMap<String, Object> map)throws Exception;
	
	public void jegoinsert_st02_wk02(HashMap<String, Object> map)throws Exception;
	
	public void jegoinsert_st01_wk03(HashMap<String, Object> map)throws Exception;
	
	public void jegoinsert_st02_wk03(HashMap<String, Object> map)throws Exception;
	
	String selectnewcode(String code) throws Exception;
	
	public void insertcode(MemberBean bean) throws Exception;
	
	public void updatecode(MemberBean bean) throws Exception;
	
	public void createBFS_CODE() throws Exception;
	
	public void createBFS_USER() throws Exception;
	
	public void createBFS_PRODUCT() throws Exception;
	
	public void insertcode() throws Exception;
	
	public void insertuser() throws Exception;
	
	
	//--------------------------------------------------------------------------------
	
	int Code_getTotalRow_v2(HashMap<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectCodeList_v2(HashMap<String, Object> map) throws Exception;
	
	HashMap<String, Object> selectCodeInfo_v2(HashMap<String, Object> map) throws Exception;
	
	String selectnewcode_v2(String code) throws Exception;
	
	List<Map<String, Object>> select_upcode(String code_gb) throws Exception;
	
	public void insertcode_v2(CodeIUbean bean) throws Exception;
	
	public void updatecode_v2(CodeIUbean bean) throws Exception;
	
	int ipgolist_getTotalRow(HashMap<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectipgolist(HashMap<String, Object> map) throws Exception;
	
	String selectnewofferno_v2() throws Exception;
	
	public void new_work_insert(HashMap<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectwork(HashMap<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectipgo(HashMap<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectjin(HashMap<String, Object> map) throws Exception;
	
	public void work_update(HashMap<String, Object> map) throws Exception;
	
	public void ipgo_insert(HashMap<String, Object> map) throws Exception;
	
	public void ipgo_update(HashMap<String, Object> map) throws Exception;
	
	public void jin_insert(HashMap<String, Object> map) throws Exception;
	
	public void jin_update(HashMap<String, Object> map) throws Exception;
	
	public void product_delete_work(HashMap<String, Object> map)throws Exception;
	
	public void product_delete_ipgo(HashMap<String, Object> map)throws Exception;
	
	public void product_delete_jin(HashMap<String, Object> map)throws Exception;
	
	List<Map<String, Object>> selectCalList_v2(HashMap<String, Object> map) throws Exception;
	
	
	String selectpreofferno_v2() throws Exception;
	
	int ipgo_magam_check(HashMap<String, Object> map) throws Exception;
	
	int jego_magam_check() throws Exception;
	
	public void new_jego_insert(HashMap<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectjego(HashMap<String, Object> map) throws Exception;
	
	public void product_delete_jego(HashMap<String, Object> map)throws Exception;
	
	public void jego_update(HashMap<String, Object> map) throws Exception;
}





package first.shopping.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import first.shopping.admin.bean.MemberBean;


public interface AdminService {
	
	List<Map<String, Object>> selectUserList(HashMap<String, Object> map) throws Exception;
	
	int getTotalRow(HashMap<String, Object> map)throws Exception;
	
	public void updateRating(HashMap<String, Object> map) throws Exception;
	
	HashMap<String, Object> selectUserInfo(String id) throws Exception;
	
	public void updateUser(MemberBean bean) throws Exception;
	
	public void updateIsDel(HashMap<String, Object> map) throws Exception;
//====================================================================================================
	String checkPw(String id)throws Exception;
	
	public void updateLoginDate(String id)throws Exception;
	
	public void signUp(HashMap<String, Object> map)throws Exception;
	
	List<Map<String, Object>> selectPdList() throws Exception;
	
	List<Map<String, Object>> selectCalList(HashMap<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectCodeList(HashMap<String, Object> map) throws Exception;
	
	int Code_getTotalRow(HashMap<String, Object> map) throws Exception;
	
	int Product_getTotalRow(HashMap<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectProductList(HashMap<String, Object> map) throws Exception;
}





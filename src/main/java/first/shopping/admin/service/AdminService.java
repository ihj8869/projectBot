package first.shopping.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import first.shopping.admin.bean.MemberBean;


public interface AdminService {
	
	List<Map<String, Object>> selectMemberList(HashMap<String, Object> map) throws Exception;
	
	int getTotalRow(HashMap<String, Object> map)throws Exception;
	
	public void updateRating(HashMap<String, Object> map) throws Exception;
	
	HashMap<String, Object> selectMemberInfo(int no) throws Exception;
	
	public void updateMember(MemberBean bean) throws Exception;
	
	public void updateIsDel(HashMap<String, Object> map) throws Exception;
//====================================================================================================
	String checkPw(String id)throws Exception;
	
	List<Map<String, Object>> selectPdList() throws Exception;
	
	List<Map<String, Object>> selectCalList(HashMap<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectCodeList(HashMap<String, Object> map) throws Exception;
	
	int Code_getTotalRow(HashMap<String, Object> map) throws Exception;
}





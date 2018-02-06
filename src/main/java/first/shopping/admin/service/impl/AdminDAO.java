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
	public List<Map<String, Object>> selectMemberList(HashMap<String, Object> map) throws Exception{
		
		//manageMember.jsp에 form이 있을경우(현재는 삭제함), 회원 검색 후 수정버튼 클릭시 현재 페이지가 새로고침되기 때문에 파라미터가 null 이라서 부적합한 열유형 #1 에러 발생
		if(map.get("name")==null && map.get("id")==null) { // 파라미터가 null 일 경우, 전체 회원검색
			return (List<Map<String, Object>>)selectList("admin.selectMemberList", map);
		}else {
			return (List<Map<String, Object>>)selectList("admin.searchMemberList", map);			
		}
	}
	
	public int getTotalRow(HashMap<String, Object> map) throws Exception{
		return (int)selectOne("admin.getTotalRow",map);
	}
	
	public void updateRating(HashMap<String, Object> map) throws Exception{
		update("admin.updateRating", map);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> selectMemberInfo(int no) throws Exception{
		return (HashMap<String, Object>)selectOne("admin.selectMemberInfo", no);
	}
	
	public void updateMember(MemberBean bean) throws Exception{
		update("admin.updateMember", bean);
	}
	
	public void updateIsDel(HashMap<String, Object> map) throws Exception{
		update("admin.updateIsDel", map);
	}
//====================================================================================================
	public String checkPw(String id) throws Exception{
		return (String)selectOne("admin.checkPw", id);
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
}

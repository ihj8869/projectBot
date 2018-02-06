package first.shopping.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import first.shopping.admin.bean.MemberBean;
import first.shopping.admin.service.AdminService;

 
@Service("adminService")
public class AdminServiceImpl implements AdminService{
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="adminDAO")
	private AdminDAO adminDAO;
	
	@Override
	public List<Map<String, Object>> selectMemberList(HashMap<String, Object> map) throws Exception {
		return adminDAO.selectMemberList(map);
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
	public HashMap<String, Object> selectMemberInfo(int no) throws Exception {
		return adminDAO.selectMemberInfo(no);
	}

	@Override
	public void updateMember(MemberBean bean) throws Exception {
		adminDAO.updateMember(bean);
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
	
}



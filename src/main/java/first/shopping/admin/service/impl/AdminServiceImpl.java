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
	public HashMap<String, Object> selectCodeInfo(String minor_cd) throws Exception {
		return adminDAO.selectCodeInfo(minor_cd);
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
	public String selectnewcode() throws Exception{
		return adminDAO.selectnewcode();
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
}



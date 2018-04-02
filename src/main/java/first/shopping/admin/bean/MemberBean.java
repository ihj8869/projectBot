package first.shopping.admin.bean;

public class MemberBean {
	private String id;
	private String password;
	private String kor_name;
	private String state_gb;
	private String update_id;
	private String update_name;
	private String update_ip;
	private String insert_gb;
	private String code_cd;
	
	public MemberBean() {
		super();
	}

	public MemberBean(String id, String password, String kor_name, String state_gb, String update_id,
			String update_name, String update_ip, String insert_gb, String code_cd) {
		super();
		this.id = id;
		this.password = password;
		this.kor_name = kor_name;
		this.state_gb = state_gb;
		this.update_id = update_id;
		this.update_name = update_name;
		this.update_ip = update_ip;
		this.insert_gb = insert_gb;
		this.code_cd = code_cd;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getKor_name() {
		return kor_name;
	}

	public void setKor_name(String kor_name) {
		this.kor_name = kor_name;
	}

	public String getState_gb() {
		return state_gb;
	}

	public void setState_gb(String state_gb) {
		this.state_gb = state_gb;
	}

	public String getUpdate_id() {
		return update_id;
	}
	
	public String getInsert_gb() {
		return insert_gb;
	}
	
	public String getCode_cd() {
		return code_cd;
	}

	public void setUpdate_id(String update_id) {
		this.update_id = update_id;
	}

	public String getUpdate_name() {
		return update_name;
	}

	public void setUpdate_name(String update_name) {
		this.update_name = update_name;
	}

	public String getUpdate_ip() {
		return update_ip;
	}

	public void setUpdate_ip(String update_ip) {
		this.update_ip = update_ip;
	}
	
	public void setInsert_gb(String insert_gb) {
		this.insert_gb = insert_gb;
	}
	
	public void setCode_cd(String code_cd) {
		this.code_cd = code_cd;
	}

	@Override
	public String toString() {
		return "MemberBean [id=" + id + ", password=" + password + ", kor_name=" + kor_name + ", state_gb=" + state_gb
				+ ", update_id=" + update_id + ", update_name=" + update_name + ", update_ip=" + update_ip + ", insert_gb=" + insert_gb + ", code_cd=" + code_cd + "]";
	}

	
	
	
}

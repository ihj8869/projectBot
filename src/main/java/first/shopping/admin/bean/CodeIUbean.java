package first.shopping.admin.bean;

public class CodeIUbean {
	private String code;
	private String code_nm;
	private String code_gb;
	private String up_code;
	private String up_code_nm;
	private String bigo;
	private String insert_gb;
	private String state_gb;
	


	/**
	 * @return the state_gb
	 */
	public String getState_gb() {
		return state_gb;
	}

	/**
	 * @param state_gb the state_gb to set
	 */
	public void setState_gb(String state_gb) {
		this.state_gb = state_gb;
	}

	public CodeIUbean() {
		super();
	}

	public CodeIUbean(String code, String code_nm, String code_gb, String up_code, String up_code_nm, String bigo, String insert_gb, String state_gb) {
		super();
		this.code = code;
		this.code_nm = code_nm;
		this.code_gb = code_gb;
		this.up_code = up_code;
		this.up_code_nm = up_code_nm;
		this.bigo = bigo;
		this.insert_gb = insert_gb;
		this.state_gb = state_gb;
		
	}
	
	@Override
	public String toString() {
		return "CodeIUbean [code=" + code + ", code_nm=" + code_nm + ", code_gb =" + code_gb + ", up_code=" + up_code
				+ ", up_code_nm=" + up_code_nm + ", bigo=" + bigo + ", state_gb=" + state_gb + ", insert_gb=" + insert_gb +"]";
	}
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCode_nm() {
		return code_nm;
	}
	public void setCode_nm(String code_nm) {
		this.code_nm = code_nm;
	}
	public String getCode_gb() {
		return code_gb;
	}
	public void setCode_gb(String code_gb) {
		this.code_gb = code_gb;
	}
	public String getUp_code() {
		if(up_code.equals(null)) {
			up_code = "";
		}
		return up_code;
	}
	public void setUp_code(String up_code) {
		this.up_code = up_code;
	}
	public String getUp_code_nm() {
		return up_code_nm;
	}
	public void setUp_code_nm(String up_code_nm) {
		this.up_code_nm = up_code_nm;
	}
	public String getBigo() {
		return bigo;
	}
	public void setBigo(String bigo) {
		if(bigo.equals(null)) {
			bigo = "";
		}
		this.bigo = bigo;
	}
	/**
	 * @return the insert_gb
	 */
	public String getInsert_gb() {
		return insert_gb;
	}

	/**
	 * @param insert_gb the insert_gb to set
	 */
	public void setInsert_gb(String insert_gb) {
		this.insert_gb = insert_gb;
	}
	
}
